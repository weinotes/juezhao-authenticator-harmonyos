import relationalStore from '@ohos.data.relationalStore';
import { Account } from '../models/Account';

export class StorageService {
  private static readonly STORE_CONFIG: relationalStore.StoreConfig = {
    name: 'juezhao_authenticator.db',
    securityLevel: relationalStore.SecurityLevel.S1
  };

  private static store: relationalStore.RdbStore | null = null;

  static async init(context: Context): Promise<void> {
    this.store = await relationalStore.getRdbStore(context, this.STORE_CONFIG);
    const sql = `CREATE TABLE IF NOT EXISTS accounts (
      id TEXT PRIMARY KEY, name TEXT NOT NULL, issuer TEXT NOT NULL,
      encrypted_secret TEXT NOT NULL, algorithm TEXT NOT NULL DEFAULT 'SHA1',
      digits INTEGER NOT NULL DEFAULT 6, period INTEGER NOT NULL DEFAULT 30
    )`;
    await this.store.executeSql(sql);
  }

  static async saveAccount(account: Account): Promise<void> {
    if (!this.store) throw new Error('Storage not initialized');
    const valueBucket = {
      id: account.id, name: account.name, issuer: account.issuer,
      encrypted_secret: account.encryptedSecret, algorithm: account.algorithm,
      digits: account.digits, period: account.period
    };
    await this.store.insert('accounts', valueBucket);
  }

  static async loadAccounts(): Promise<Account[]> {
    if (!this.store) throw new Error('Storage not initialized');
    const predicates = new relationalStore.RdbPredicates('accounts');
    const resultSet = await this.store.query(predicates);
    const accounts: Account[] = [];
    while (resultSet.goToNextRow()) {
      const id = resultSet.getString(resultSet.getColumnIndex('id'));
      const name = resultSet.getString(resultSet.getColumnIndex('name'));
      const issuer = resultSet.getString(resultSet.getColumnIndex('issuer'));
      const encryptedSecret = resultSet.getString(resultSet.getColumnIndex('encrypted_secret'));
      accounts.push(new Account(id, name, issuer, encryptedSecret));
    }
    resultSet.close();
    return accounts;
  }

  static async deleteAccount(id: string): Promise<void> {
    if (!this.store) throw new Error('Storage not initialized');
    const predicates = new relationalStore.RdbPredicates('accounts');
    predicates.equalTo('id', id);
    await this.store.delete(predicates);
  }
}
