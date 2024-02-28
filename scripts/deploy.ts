import { ethers } from "hardhat";

async function main() {


  const SocialMediaNFT= await ethers.deployContract("SocialMediaNFT");
  await SocialMediaNFT.waitForDeployment();
  console.log(`Social  media  NFT contract deployed to ${SocialMediaNFT.target}`);

  const SocialMediaFactory= await ethers.deployContract("SocialMediaFactory",[SocialMediaNFT]);
  const socialMediaFactory=await SocialMediaFactory.waitForDeployment();
  console.log(`Factory contract deployed to ${socialMediaFactory.target}`);

  const SocialMediaContract = await ethers.deployContract("SocialMediaContract", [socialMediaFactory.target]);
  const socialMediaContract=await SocialMediaContract.waitForDeployment();
  console.log(`Social media  deployed to ${socialMediaContract.target}`);


//   Social  media  NFT contract deployed to 0x76B185ddB5B9d81a726634a57F3dBE54E367Ab23
// Factory contract deployed to 0xFC9D7c3920888e8c4553f38e011482c306028186
// Social media  deployed to 0x403ccb90562510e98d73dC22BF0875148441921b

// https://mumbai.polygonscan.com/address/0x403ccb90562510e98d73dC22BF0875148441921b#code
  
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
