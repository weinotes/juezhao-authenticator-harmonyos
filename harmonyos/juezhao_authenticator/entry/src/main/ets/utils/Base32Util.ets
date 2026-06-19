export class Base32Util {
  private static readonly ALPHABET = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567';

  static decode(encoded: string): Uint8Array {
    const cleaned = encoded.replace(/=+$/, '').toUpperCase();
    const bits: number[] = [];

    for (let i = 0; i < cleaned.length; i++) {
      const val = this.ALPHABET.indexOf(cleaned[i]);
      if (val === -1) throw new Error(`Invalid Base32 character: ${cleaned[i]}`);
      for (let j = 4; j >= 0; j--) {
        bits.push((val >> j) & 1);
      }
    }

    const bytes: number[] = [];
    for (let i = 0; i + 8 <= bits.length; i += 8) {
      let byte = 0;
      for (let j = 0; j < 8; j++) {
        byte = (byte << 1) | bits[i + j];
      }
      bytes.push(byte);
    }

    return new Uint8Array(bytes);
  }
}
