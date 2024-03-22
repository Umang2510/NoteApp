import { MongoClient, Db } from "mongodb";

let mongodb: Db;

export async function connectToDB() {
  const url = "mongodb://127.0.0.1:27017";
  const client = new MongoClient(url);
  mongodb = client.db("notedb");
  console.log("DB connected successfully!");
}

export function getDb(): Db {
  return mongodb;
}
