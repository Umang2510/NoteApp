import express from "express";
//Cross Origin Resource Sharing
import cors from "cors"; //We will load data using this
import { connectToDB } from "./config/mongodb_client";
import { appLogger } from "./middleware/app_logger";
import userRouter from "./router/user_router";

const app: express.Application = express();

app.use(cors());
app.use(express.json());
app.use(appLogger);
app.use(express.urlencoded({ extended: false }));
app.use("/v1/user", userRouter);
const hostName = "localhost";
const portNumber = 5000;

app.listen(portNumber, hostName, async () => {
  await connectToDB();
  console.log("Welcome to Note App");
});
