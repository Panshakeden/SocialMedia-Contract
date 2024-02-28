import { ethers } from "hardhat";

async function main() {


  const SocialMedia= await ethers.deployContract("SocialMediaFactory");
  await SocialMedia.waitForDeployment();
  console.log(`Factory contract deployed to ${SocialMedia.target}`);

  const SocialMediaFactory= await ethers.deployContract("SocialMediaFactory",[SocialMedia]);
  const socialMediaFactory=await SocialMediaFactory.waitForDeployment();
  console.log(`Factory contract deployed to ${socialMediaFactory.target}`);

  const SocialMediaContract = await ethers.deployContract("SocialMediaContract", [socialMediaFactory.target]);
  const socialMediaContract=await SocialMediaContract.waitForDeployment();
  console.log(`Social media  deployed to ${socialMediaContract.target}`);
  
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
