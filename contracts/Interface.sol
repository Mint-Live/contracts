// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

interface IERC721Mintable is IERC721 {
    function mint(address to, uint256 id) external;

    function mint(address to) external;

    function burn(uint256 id) external;
}

interface IStreamRegistryV4 {
    function createStream(
        string calldata streamIdPath,
        string calldata metadataJsonString
    ) external;
}
