const snarkjs = require("snarkjs");
const path = require("path");

const r1csFileName = path.join(__dirname, "..", "build", "main.r1cs");
const potFileName = path.join(__dirname, "..", "pot", "pot15_final.ptau");
const zkeyFileName = path.join(__dirname, "..", "build", "main.zkey");

snarkjs.zKey
  .newZKey(r1csFileName, potFileName, zkeyFileName, console)
  .then(() => process.exit(0));
