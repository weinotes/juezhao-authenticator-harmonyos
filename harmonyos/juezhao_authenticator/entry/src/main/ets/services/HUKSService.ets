import huks from '@ohos.security.huks';
import { BusinessError } from '@ohos.base';

export class HUKSService {
  private static readonly AES_KEY_ALIAS = 'juezhao_authenticator_aes_key';

  static async generateKey(): Promise<void> {
    const keyAlias = this.AES_KEY_ALIAS;
    const options: huks.HuksOptions = {
      properties: [
        { tag: huks.HuksTag.HUKS_TAG_ALGORITHM, value: huks.HuksKeyAlg.HUKS_ALG_AES },
        { tag: huks.HuksTag.HUKS_TAG_KEY_SIZE, value: huks.HuksKeySize.HUKS_AES_KEY_SIZE_256 },
        { tag: huks.HuksTag.HUKS_TAG_PURPOSE, value: huks.HuksKeyPurpose.HUKS_KEY_PURPOSE_ENCRYPT | huks.HuksKeyPurpose.HUKS_KEY_PURPOSE_DECRYPT },
        { tag: huks.HuksTag.HUKS_TAG_BLOCK_MODE, value: huks.HuksCipherMode.HUKS_MODE_GCM }
      ]
    };

    try {
      await huks.generateKeyItem(keyAlias, options);
    } catch (error) {
      const err = error as BusinessError;
      if (err.code !== huks.HuksErrorCode.HUKS_ERROR_KEY_ALREADY_EXISTS) throw error;
    }
  }

  static async encrypt(plainText: string): Promise<string> {
    await this.generateKey();
    const keyAlias = this.AES_KEY_ALIAS;
    const options: huks.HuksOptions = {
      properties: [
        { tag: huks.HuksTag.HUKS_TAG_ALGORITHM, value: huks.HuksKeyAlg.HUKS_ALG_AES },
        { tag: huks.HuksTag.HUKS_TAG_BLOCK_MODE, value: huks.HuksCipherMode.HUKS_MODE_GCM }
      ],
      inData: new Uint8Array(Buffer.from(plainText))
    };

    const encryptResult = await huks.encryptItem(keyAlias, options);
    return Buffer.from(encryptResult.outData).toString('base64');
  }

  static async decrypt(cipherText: string): Promise<string> {
    const keyAlias = this.AES_KEY_ALIAS;
    const options: huks.HuksOptions = {
      properties: [
        { tag: huks.HuksTag.HUKS_TAG_ALGORITHM, value: huks.HuksKeyAlg.HUKS_ALG_AES },
        { tag: huks.HuksTag.HUKS_TAG_BLOCK_MODE, value: huks.HuksCipherMode.HUKS_MODE_GCM }
      ],
      inData: new Uint8Array(Buffer.from(cipherText, 'base64'))
    };

    const decryptResult = await huks.decryptItem(keyAlias, options);
    return Buffer.from(decryptResult.outData).toString();
  }
}
