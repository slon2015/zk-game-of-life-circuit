pragma circom 2.1.4;

include "comparators.circom";

template NeighborsCounter() {
    signal input in[8];
    
    signal output redCnt;
    signal output blueCnt;

    component isRed[8];
    component isBlue[8];

    var redExpression = 0;
    var blueExpression = 0;

    for (var i = 0; i < 8; i++) {
        isRed[i] = IsEqual();
        isRed[i].in[0] <== in[i];
        isRed[i].in[1] <== 1;

        redExpression += isRed[i].out;

        isBlue[i] = IsEqual();
        isBlue[i].in[0] <== in[i];
        isBlue[i].in[1] <== 2;

        blueExpression += isBlue[i].out;
    }

    redCnt <== redExpression;
    blueCnt <== blueExpression;
}

template BoardCounter(Size) {
    signal input in[Size][Size];

    signal output redCnt;
    signal output blueCnt;

    component isRed[Size][Size];
    component isBlue[Size][Size];

    var redExpression = 0;
    var blueExpression = 0;

    for (var i = 0;i < Size; i++) {
        for (var j = 0; j < Size; j++) {
            isRed[i][j] = IsEqual();
            isRed[i][j].in[0] <== in[i][j];
            isRed[i][j].in[1] <== 1;

            redExpression += isRed[i][j].out;

            isBlue[i][j] = IsEqual();
            isBlue[i][j].in[0] <== in[i][j];
            isBlue[i][j].in[1] <== 2;

            blueExpression += isBlue[i][j].out;
        }
    }

    redCnt <== redExpression;
    blueCnt <== blueExpression;
}