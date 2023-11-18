pragma circom 2.1.4;

include "./cell.circom";

template Board(Size) {
    signal input in[Size][Size];

    signal output out[Size][Size];

    component cells[Size][Size];

    for (var i = 0; i < Size; i++) {
        for (var j = 0; j < Size; j++) {
            var neighbors[8] = [
                i == 0 || j == 0? 0: in[i-1][j-1],
                i == 0? 0: in[i-1][j],
                i == 0 || j == Size - 1? 0: in[i-1][j+1],
                j == 0? 0: in[i][j-1],
                j == Size - 1? 0: in[i][j+1],
                i == Size - 1 || j == 0? 0: in[i+1][j-1],
                i == Size - 1? 0: in[i+1][j],
                i == Size - 1 || j == Size - 1? 0: in[i+1][j+1]
            ];

            cells[i][j] = BoardCell();

            cells[i][j].neighbors <== neighbors;
            cells[i][j].myState <== in[i][j];

            out[i][j] <== cells[i][j].newState;
        }
    }
}