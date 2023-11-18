pragma circom 2.1.4;

include "../condition.circom";

template SurviveRule() {
    signal input neighborsCount;

    signal output survived;

    component cond = InvertedConfition();

    cond.min <== 2;
    cond.max <== 3;

    cond.actual <== neighborsCount;

    survived <== cond.met;
}