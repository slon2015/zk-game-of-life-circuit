pragma circom 2.1.4;

include "comparators.circom";

// 0 - dead, 1 - red team, 2 - blue team
template BirthRule() {
    signal input blueCnt;
    signal input redCnt;

    signal output birth;

    signal team;
    signal result;

    component gt = GreaterThan(4);
    component e = IsEqual();

    gt.in[0] <== redCnt;
    gt.in[1] <== blueCnt;

    team <== 2 - gt.out;

    e.in[0] <== blueCnt + redCnt;
    e.in[1] <== 3;

    result <== e.out * team;

    birth <== result;
}