import express from "express";
import { NoteController } from "../controller/note_controller";

const noteRouter: express.Router = express.Router();

noteRouter.get("/getmynotes", NoteController.getMyNotes);
noteRouter.post("/addnote", NoteController.addNote);

export default noteRouter;
