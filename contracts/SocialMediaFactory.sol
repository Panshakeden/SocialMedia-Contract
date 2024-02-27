// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./SocialMedia.sol";

contract NftFactory  {
    CaveToken public nftContract;
    
    constructor(CaveToken _nftContract) {
        nftContract = _nftContract;
    }
    
    function createNFT(address to, uint256 tokenId,string memory uri) public  {
        nftContract.safeMint(to, tokenId,uri);
    }
}
