type Cell = "R" | "B" | "E";

export type HumanReadableWitnessInput = {
  initialBoard: Array<Array<Cell>>;
  initialCount: number;
};

export type WitnessInput = {
  initialBoard: Array<Array<number>>;
  initialCount: number;
};

function cellToBinary(input: Cell): number {
  switch (input) {
    case "R":
      return 1;
    case "B":
      return 2;
    default:
      return 0;
  }
}

function binaryToCell(input: string): Cell {
  switch (input) {
    case "1":
      return "R";
    case "2":
      return "B";
    default:
      return "E";
  }
}

export function mapWitnessInput(
  humanReadable: HumanReadableWitnessInput
): WitnessInput {
  return {
    initialBoard: humanReadable.initialBoard.map((row) =>
      row.map((cell) => cellToBinary(cell))
    ),
    initialCount: humanReadable.initialCount,
  };
}

export function mapToHumanReadable(
  publicSignal: Array<string>,
  size: number,
  offset: number
): Array<Array<Cell>> {
  let counter = 0;
  const result: Array<Array<Cell>> = [];
  for (let i = 0; i < size; i++) {
    result.push([]);
    for (let j = 0; j < size; j++) {
      const element = publicSignal[offset + counter];

      result[i].push(binaryToCell(element));
      counter++;
    }
  }

  return result;
}
