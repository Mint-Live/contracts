import { StreamrClient } from "streamr-client";

const channel = "0x5b3D38803237fA28fbd3df0ddb14009651c83709";
const listener = "0x00000";
const streamId = `${channel}/${listener}`;
async function main() {
  const streamId = "";
  const streamr = new StreamrClient({
    auth: {
      privateKey: "your-ethereum-private-key",
    },
  });

  const stream = await streamr.createStream(streamId);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
