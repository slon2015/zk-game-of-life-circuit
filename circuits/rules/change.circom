pragma circom 2.1.4;

include "comparators.circom";
include "gates.circom";

// 0 - dead, 1 - red team, 2 - blue team
template ChangeRule() {
    signal input blueCnt;
    signal input redCnt;
    signal input state;

    signal output newState;

    signal team;

    component gt[2];
    component eq = IsEqual();
    component inz = GreaterThan(2);

    inz.in[0] <== state;
    inz.in[1] <== 0;

    eq.in[0] <== redCnt;
    eq.in[1] <== blueCnt;

    gt[0] = GreaterThan(4);
    gt[0].in[0] <== redCnt;
    gt[0].in[1] <== blueCnt;

    gt[1] = GreaterThan(4);
    gt[1].in[0] <== blueCnt;
    gt[1].in[1] <== redCnt;

    team <== (1 * gt[0].out) + (2 * gt[1].out) + (state * eq.out);

    newState <== inz.out * team;
}