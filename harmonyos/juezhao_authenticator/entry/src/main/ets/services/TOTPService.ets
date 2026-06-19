import cryptoFramework from '@ohos.security.cryptoFramework';
import { Base32Util } from '../utils/Base32Util';
import { TimeUtil } from '../utils/TimeUtil';

export class TOTPService {
  static async generateTOTP(secret: string, period: number = 30, digits: number = 6): Promise<string> {
    const keyBytes = Base32Util.decode(secret);
    const counter = TimeUtil.getCounter(period);

    const counterBytes = new Uint8Array(8);
    let temp = counter;
    for (let i = 7; i >= 0; i--) {
      counterBytes[i] = temp & 0xff;
      temp >>= 8;
    }

    const symKeyGenerator = cryptoFramework.createSymKeyGenerator('HMAC');
    const mac = cryptoFramework.createMac('SHA1');
    const keyBlob = { data: keyBytes };
    const symKey = await symKeyGenerator.convertKey(keyBlob);
    await mac.init(symKey);
    const msgBlob = { data: counterBytes };
    const hmacResult = await mac.doFinal(msgBlob);

    const hmacBytes = hmacResult.data;
    const offset = hmacBytes[hmacBytes.length - 1] & 0x0f;
    const code = ((hmacBytes[offset] & 0x7f) << 24 |
      (hmacBytes[offset + 1] & 0xff) << 16 |
      (hmacBytes[offset + 2] & 0xff) << 8 |
      (hmacBytes[offset + 3] & 0xff)) % 1000000;

    return code.toString().padStart(digits, '0');
  }
}
