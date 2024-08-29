import { DB } from '@/src/db/types'
import { createPool } from 'mysql2' // do not use 'mysql2/promises'!
import { Kysely, MysqlDialect } from 'kysely'

const dialect = new MysqlDialect({
  pool: createPool({
    database: 'DB_NAME',
    host: 'DB_HOST',
    user: 'DB_USER',
    password: 'DB_PASSWORD',
    port: process.env.DB_PORT ? parseInt(process.env.DB_PORT) : 3306,
    connectionLimit: 10,
  })
})

// Database interface is passed to Kysely's constructor, and from now on, Kysely 
// knows your database structure.
// Dialect is passed to Kysely's constructor, and from now on, Kysely knows how 
// to communicate with your database.
export const db = new Kysely<DB>({
  dialect,
})