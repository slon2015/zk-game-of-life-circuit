declare module "snarkjs" {
  declare namespace groth16 {
    declare function prove(
      zkeyFileName: string,
      witnessFileName: string
    ): Promise<{
      pi_a: Array<string>;
      pi_b: Array<string>;
      pi_c: Array<string>;
      protocol: string;
      curve: string;
      publicSignals: Array<string>;
    }>;
  }
}
