// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "./SocialMediaNFT.sol";

contract SocialMediaFactory  {
    SocialMediaNFT public nftContract;
    
    constructor(SocialMediaNFT _nftContract) {
        nftContract = _nftContract;
    }
    
    function createNFT(address to, uint256 tokenId,string memory uri) public  {
        nftContract.safeMint(to, tokenId,uri);
    }
}
