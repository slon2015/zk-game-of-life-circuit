pragma circom 2.1.4;

include "gates.circom";
include "comparators.circom";

template Condition() {
    signal input min;
    signal input max;

    signal input actual;

    signal output met;

    component lte = LessEqThan(4);
    component gte = GreaterEqThan(4);

    component and = AND();

    lte.in[0] <== actual;
    lte.in[1] <== max;

    gte.in[0] <== actual;
    gte.in[1] <== min;

    and.a <== lte.out;
    and.b <== gte.out;

    met <== and.out;
}

template InvertedConfition() {
    signal input min;
    signal input max;

    signal input actual;

    signal output met;

    component cond = Condition();
    component not = NOT();

    cond.min <== min;
    cond.max <== max;
    cond.actual <== actual;

    not.in <== cond.met;

    met <== not.out;
}