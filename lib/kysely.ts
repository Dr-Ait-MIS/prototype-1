import { Kysely, MysqlDialect } from "kysely";
import { createPool } from "mysql2";
import dotenv from "dotenv";

dotenv.config();

interface DB {
  degree: {
    id: number;
    degreeId: string;
    name: string;
  };
}

const db = new Kysely<DB>({
  dialect: new MysqlDialect({
    pool: createPool({
      host: process.env.DB_HOST,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      database: process.env.DB_NAME,
    }),
  }),
});

export default db;
