// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/utils/cryptography/SignatureChecker.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/presets/ERC721PresetMinterPauserAutoId.sol";

contract nontransferableNFT is ERC721PresetMinterPauserAutoId {
    constructor(address minter)
        ERC721PresetMinterPauserAutoId("POD3 SBT", "POD3", "URI")
    {
        _setupRole(MINTER_ROLE, minter);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId
    ) internal virtual override(ERC721PresetMinterPauserAutoId) {
        require(false, "Tokens are not transferable");
    }

    function mint(address to, uint256 id) external {
        _mint(to, id);
    }
}
