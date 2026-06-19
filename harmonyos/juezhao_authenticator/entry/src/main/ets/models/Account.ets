@Observed
export class Account {
  id: string;
  name: string;
  issuer: string;
  encryptedSecret: string;
  algorithm: string;
  digits: number;
  period: number;
  currentCode: string;
  remainingSeconds: number;

  constructor(id: string, name: string, issuer: string, encryptedSecret: string) {
    this.id = id;
    this.name = name;
    this.issuer = issuer;
    this.encryptedSecret = encryptedSecret;
    this.algorithm = 'SHA1';
    this.digits = 6;
    this.period = 30;
    this.currentCode = '';
    this.remainingSeconds = 30;
  }
}
