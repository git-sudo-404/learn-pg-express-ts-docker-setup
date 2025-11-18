import express, { type Request, type Response } from "express";
import pool from "./DB/connection.js";

const app = express();

app.get("/", (req: Request, res: Response) => {
  res.status(200).json({ msg: "Response from Server" });
});

app.get("/db-test-tables", async (req: Request, res: Response) => {
  const query_response = await pool.query(`
    

    SELECT * from users;

    `);
  console.log(query_response);

  const return_response = query_response.rows.map((row) => {
    return {
      id: row.id,
      name: row.name,
      age: row.age,
      email: row.email,
    };
  });

  res.status(200).send(return_response);
});

export default app;
