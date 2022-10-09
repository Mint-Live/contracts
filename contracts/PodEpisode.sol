// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/utils/cryptography/SignatureChecker.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./Interface.sol";

contract PodEpisode is Ownable {
    IERC721Mintable public nontransferableNFT;
    IERC721Mintable public permanentNFT;

    mapping(address => uint256) public tiers;
    mapping(address => listener) public listeners;
    mapping(address => bool) public claimed;

    struct listener {
        uint256 start;
        uint256 end;
    }

    constructor(
        IERC721Mintable _nontransferableNFT,
        IERC721Mintable _permanentNFT
    ) {
        permanentNFT = _permanentNFT;
        nontransferableNFT = _nontransferableNFT;
    }

    function mint(uint256 tier, bytes calldata signature) external {
        require(!claimed[msg.sender], "Token is claimed");
        bytes32 message = keccak256(abi.encode(tier, msg.sender));
        bool valid = SignatureChecker.isValidSignatureNow(
            owner(),
            message,
            signature
        );
        require(valid, "Wrong Signature");

        nontransferableNFT.mint(msg.sender);
        tiers[msg.sender] = tier;
        claimed[msg.sender] = true;
    }

    function releaseOnLens() external {
        //
    }

    // ---------------------------------------------------------------------------------------------
    // SUPER APP CALLBACKS

    function afterAgreementCreated(
        address, //_superToken,
        address, //_agreementClass,
        bytes32, //_agreementId
        bytes calldata _agreementData,
        bytes calldata, //_cbdata
        bytes calldata
    ) external returns (bytes memory newCtx) {
        address sender;
        (sender, ) = abi.decode(_agreementData, (address, address));
        uint256 id = uint256(keccak256(abi.encode(msg.sender)));
        permanentNFT.mint(sender, id);
        listeners[msg.sender].start = block.timestamp;
    }

    function afterAgreementTerminated(
        address,
        address,
        bytes32, // _agreementId,
        bytes calldata _agreementData,
        bytes calldata, // _cbdata,
        bytes calldata
    ) external returns (bytes memory newCtx) {
        address sender;
        (sender, ) = abi.decode(_agreementData, (address, address));
        uint256 id = uint256(keccak256(abi.encode(msg.sender)));
        permanentNFT.burn(id);
        listeners[msg.sender].end = block.timestamp;
    }
}
