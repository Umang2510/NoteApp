import express from 'express';
import { userController } from '../controller/user_controller';

const userRouter : express.Router = express.Router();

userRouter.post("/signup", userController.singUp);
userRouter.post("/signin", userController.signIn);
userRouter.get("/myprofile", userController.myProfile);
userRouter.put("/updateprofile", userController.updateProfile);

export default userRouter;