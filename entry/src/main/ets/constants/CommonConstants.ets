import { relationalStore } from '@kit.ArkData'
import { MimoTable } from '../model/iMimoTable'

export default class CommonConstants {
  // 数据库配置
  static readonly STORE_CONFIG: relationalStore.StoreConfig = {
    name: 'mimoDB.db',
    securityLevel: relationalStore.SecurityLevel.S1
  }
  // 数据表
  static readonly MIMO_TABLE: MimoTable = {
    tableName: 'mimoTable',
    sqlCreate: 'CREATE TABLE IF NOT EXISTS mimoTable(id INTEGER PRIMARY KEY AUTOINCREMENT, updateTime INTEGER, content TEXT)',
    columns: ['id', 'updateTime', 'content']
  }
  // 标识
  static readonly RDB_TAG = '[Debug.Rdb]';
  static readonly TABLE_TAG = '[Debug.mimoTable]';
  static readonly INDEX_TAG = '[Debug.Index]';
}