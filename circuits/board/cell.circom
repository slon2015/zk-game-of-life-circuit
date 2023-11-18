pragma circom 2.1.4;

include "../rules/birth.circom";
include "../rules/survive.circom";
include "../rules/change.circom";
include "./counter.circom";
include "comparators.circom";
include "gates.circom";

template BoardCell() {
    /*
        |n[0]|n[1]|n[2]|
        |n[3]|    |n[4]|
        |n[5]|n[6]|n[7]|
    */
    signal input neighbors[8];
    signal input myState;

    signal output newState;

    signal birthBranch;
    signal surviveBranch;

    component birth = BirthRule();
    component survive = SurviveRule();
    component change = ChangeRule();

    component counter = NeighborsCounter();
    counter.in <== neighbors;

    component isDead = IsZero();
    component isAlive = NOT();
    component isSurvived = MultiAND(2);

    isDead.in <== myState;
    isAlive.in <== isDead.out;

    birth.redCnt <== counter.redCnt;
    birth.blueCnt <== counter.blueCnt;

    survive.neighborsCount <== counter.redCnt + counter.blueCnt;

    change.redCnt <== counter.redCnt;
    change.blueCnt <== counter.blueCnt;
    change.state <== myState;

    isSurvived.in[0] <== isAlive.out;
    isSurvived.in[1] <== survive.survived;

    birthBranch <== isDead.out * birth.birth;
    
    surviveBranch <== isSurvived.out * change.newState;

    newState <==  birthBranch + surviveBranch;
}