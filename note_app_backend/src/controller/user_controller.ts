import express from "express";
import { getDb } from "../config/mongodb_client";
import { User } from "../models/user_model";
import bcrypt from "bcrypt";
import { ObjectId } from "mongodb";

export class userController {
  static async singUp(request: express.Request, response: express.Response) {
    let db = getDb();
    let usersCollection = db.collection("users");
    const user: User = request.body;

    const checkUser = {
      email: user.email,
    };
    const data = await usersCollection.find(checkUser).toArray();
    if (data.length != 0) {
      response.status(403).send({
        status: "Failure",
        response: "Email already exist.",
      });
    } else {
      const salt = await bcrypt.genSalt(10);
      user.password = await bcrypt.hash(user.password, salt);

      const responseData = await usersCollection.insertOne(user);
      const objId = responseData.insertedId;

      const userInfo = await usersCollection
        .find({ _id: new ObjectId(objId) })
        .toArray();
      const userResponseData = userInfo[0];
      userResponseData.password = "";
      response.status(200).send({
        status: "Success",
        response: userResponseData,
      });
    }
  }

  static async signIn(request: express.Request, response: express.Response) {
    let db = getDb();
    let usersCollection = db.collection("users");
    const user: User = request.body;

    const checkUser = {
      email: user.email,
    };
    const data = await usersCollection.find(checkUser).toArray();
    console.log(data);
    if (data.length != 0) {
      let userInfo = data[0];
      const pass = await bcrypt.compare(user.password, userInfo.password);
      if (user.email == userInfo.email && pass) {
        userInfo.password = "";
        response.status(200).json({
          status: "Sucess",
          response: userInfo,
        });
      } else {
        response.status(403).json({
          status: "Failure",
          response: "Invalid Email & Password please check!",
        });
      }
    } else {
      response.status(403).json({
        status: "Failure",
        response: "Invalid Email & Password please check!",
      });
    }
  }

  static async myProfile(request: express.Request, response: express.Response) {
    let db = getDb();
    let usersCollection = db.collection("users");
    const uid = request.query.uid;

    const userData = await usersCollection
      .find({ _id: new ObjectId(uid!.toString()) })
      .toArray();
    response.status(200).json({
      status: "Success",
      response: userData[0],
    });
  }

  static async updateProfile(
    request: express.Request,
    response: express.Response
  ) {
    let db = getDb();
    let usersCollection = db.collection("users");
    const user: User = request.body;
    const salt = await bcrypt.genSalt(10);
    user.password = await bcrypt.hash(user.password, salt);
    const updateUserObject = {
      username: user.username,
      password: user.password,
    };

    const updateUserInfo = await usersCollection.updateOne(
      { _id: new ObjectId(user.uid) },
      { $set: updateUserObject }
    );
    response.status(200).json({
      Status: "Success",
      response: updateUserInfo,
    });
  }
}
