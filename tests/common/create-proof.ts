import { join, normalize } from "node:path";
import { writeFile } from "node:fs/promises";
import { groth16 } from "snarkjs";

import { TEST_FOLDER } from "./constants";

export async function createProof(witness: Uint8Array) {
  const zkeyPath = normalize(join(__dirname, "../../build/main.zkey"));

  const witnessPath = normalize(
    join(__dirname, `../../${TEST_FOLDER}/witnessToProve.wtns`)
  );

  await writeFile(witnessPath, witness);

  return groth16.prove(zkeyPath, witnessPath);
}
