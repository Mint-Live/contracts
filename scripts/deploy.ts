import { ethers } from "hardhat";

async function main() {
  const nontransferableNFTFactory = await ethers.getContractFactory(
    "nontransferableNFT"
  );
  const PodEpisodeFactory = await ethers.getContractFactory("PodEpisode");

  const nontransferableNFT = await nontransferableNFTFactory.deploy();
  await nontransferableNFT.deployed();

  const temporaryNFT = await nontransferableNFTFactory.deploy();
  await temporaryNFT.deployed();

  const PodEpisode = await PodEpisodeFactory.deploy(
    nontransferableNFT.address,
    temporaryNFT.address
  );
  await PodEpisode.deployed();

  console.log(`
    PodEpisode         : ${PodEpisode.address}
    temporaryNFT       : ${temporaryNFT.address}
    nontransferableNFT : ${nontransferableNFT.address}
  `);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
