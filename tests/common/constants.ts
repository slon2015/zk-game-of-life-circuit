import { HumanReadableWitnessInput } from "./types";

export const TEST_FOLDER = "tests/temp";

export const DEFAULT_CIRCUIT_INPUT: HumanReadableWitnessInput = {
  initialBoard: [
    ["B", "B", "E", "E", "E"],
    ["B", "E", "E", "E", "E"],
    ["E", "E", "E", "E", "E"],
    ["E", "E", "E", "E", "E"],
    ["E", "E", "R", "R", "R"],
  ],
  initialCount: 3,
};
