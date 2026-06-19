export class TimeUtil {
  static nowSeconds(): number {
    return Math.floor(Date.now() / 1000);
  }

  static getCounter(period: number = 30): number {
    return Math.floor(this.nowSeconds() / period);
  }

  static getRemainingSeconds(period: number = 30): number {
    return period - (this.nowSeconds() % period);
  }
}
