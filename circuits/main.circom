pragma circom 2.1.4;

include "comparators.circom";
include "gates.circom";

include "./board/board.circom";
include "./board/counter.circom";

template GameOfLife(Size, Rounds) {
    signal input initialBoard[Size][Size];
    signal input initialCount;

    signal output finalBoard[Size][Size];
    signal output winner;

    component rounds[Rounds];
    component countsBeforeGame = BoardCounter(Size);
    component countsAfterGame = BoardCounter(Size);

    component isEqualCounts = IsEqual();
    component isRedGreater = GreaterThan(8);
    component isBlueGreater = NOT();

    countsBeforeGame.in <== initialBoard;
    countsBeforeGame.redCnt === initialCount;
    countsBeforeGame.blueCnt === initialCount;

    rounds[0] = Board(Size);
    rounds[0].in <== initialBoard;

    for (var i = 1; i < Rounds; i++) {
        rounds[i] = Board(Size);
        rounds[i].in <== rounds[i-1].out;
    }

    countsAfterGame.in <== rounds[Rounds - 1].out;

    isEqualCounts.in[0] <== countsAfterGame.redCnt;
    isEqualCounts.in[1] <== countsAfterGame.blueCnt;

    isRedGreater.in[0] <== countsAfterGame.redCnt;
    isRedGreater.in[1] <== countsAfterGame.blueCnt;

    isBlueGreater.in <== isRedGreater.out;

    finalBoard <== rounds[Rounds - 1].out;
    winner <== (1 * isRedGreater.out) + (2 * isBlueGreater.out) + (3 * isEqualCounts.out);
}

component main = GameOfLife(5, 5);