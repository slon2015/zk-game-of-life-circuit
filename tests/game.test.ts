import { mkdir, rm } from "node:fs/promises";
import { join, normalize } from "node:path";

import { calculateWitness } from "./common/calculate-witness";
import { createProof } from "./common/create-proof";
import { TEST_FOLDER } from "./common/constants";
import { mapToHumanReadable } from "./common/types";

const TEST_DATA_DIR = normalize(join(__dirname, "..", TEST_FOLDER));

describe("GameBoard", () => {
  beforeEach(async () => mkdir(TEST_DATA_DIR));

  afterEach(async () =>
    rm(TEST_DATA_DIR, {
      recursive: true,
    })
  );

  it("Test session", async () => {
    const witness = await calculateWitness({
      initialBoard: [
        ["B", "B", "E", "E", "E"],
        ["B", "E", "B", "R", "E"],
        ["E", "B", "E", "E", "R"],
        ["B", "E", "E", "R", "E"],
        ["E", "E", "R", "R", "R"],
      ],
      initialCount: 6,
    });
    const proof = await createProof(witness);

    const result = mapToHumanReadable(proof.publicSignals, 5, 0);

    console.log(result.map((r) => r.join(" ")).join("\n"));
  });
});
