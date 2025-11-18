import { Pool } from "pg";

const pool = new Pool({
  host: "postgres-db",
  user: process.env.POSTGRES_USER,
  password: process.env.POSTGRES_PASSWORD,
  database: process.env.POSTGRES_DB,
  max: 20,
});

export default pool;
