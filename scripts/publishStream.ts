import { ethers } from "hardhat";
import { StreamrClient } from "streamr-client";

const delay = (ms: any) => new Promise((resolve) => setTimeout(resolve, ms));
const privateKey = "";
const channel = "0x5b3D38803237fA28fbd3df0ddb14009651c83709";
const listener = "0x5b3D38803237fA28fbd3df0ddb14009651c83709";

const stream = "0x5b3d38803237fa28fbd3df0ddb14009651c83709/pod3";
async function main() {
  const streamr = new StreamrClient({
    auth: {
      privateKey,
    },
  });
  const wallet = new ethers.Wallet(privateKey);

  const score = 100;
  const message = ethers.utils.soliditySha256(
    ["uint256", "address"],
    [score, listener]
  );
  const signature = await wallet.signMessage(message);

  // Here is the message we'll be sending
  const msg = {
    score,
    signature,
  };

  await streamr.publish(stream, msg);
  // Publish the message to the Stream
  await delay(1000); /// waiting 15 second.
  await streamr.publish(stream, msg);
  await delay(1000); /// waiting 15 second.
  await streamr.publish(stream, msg);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
