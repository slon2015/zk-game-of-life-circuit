import { join, normalize } from "node:path";
import { writeFile, readFile } from "node:fs/promises";
import { execSync } from "node:child_process";
import { DEFAULT_CIRCUIT_INPUT, TEST_FOLDER } from "./constants";
import { mapWitnessInput } from "./types";

export async function calculateWitness(
  witnessInput: Partial<typeof DEFAULT_CIRCUIT_INPUT>
): Promise<Uint8Array> {
  if (typeof witnessInput !== "object") {
    throw new Error("invalid witness input type");
  }

  const generateScriptPath = normalize(
    join(__dirname, "../../build/main_js/generate_witness.js")
  );
  const wasmPath = normalize(join(__dirname, "../../build/main_js/main.wasm"));
  const witnessInputPath = normalize(
    join(__dirname, `../../${TEST_FOLDER}/witness-input.temp`)
  );
  const witnessPath = normalize(
    join(__dirname, `../../${TEST_FOLDER}/witness.wtns`)
  );

  await writeFile(
    witnessInputPath,
    JSON.stringify(
      mapWitnessInput({ ...DEFAULT_CIRCUIT_INPUT, ...witnessInput })
    )
  );
  execSync(
    `node ${generateScriptPath} ${wasmPath} ${witnessInputPath} ${witnessPath}`
  );

  const buff = await readFile(witnessPath);
  return new Uint8Array(buff);
}
