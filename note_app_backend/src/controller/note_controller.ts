import express from "express";
import { getDb } from "../config/mongodb_client";
import { Note } from "../models/note_model";

export class NoteController {
  static async addNote(request: express.Request, response: express.Response) {
    let db = getDb();
    let notesCollection = db.collection("notes");
    const note: Note = request.body;
    note.createAt = Date.now();
    const data = await notesCollection.insertOne(note);
    response.status(200).json({
      status: "success",
      response: data,
    });
  }

  static async getMyNotes(
    request: express.Request,
    response: express.Response
  ) {
    let db = getDb();
    let notesCollection = db.collection("notes");
    const uid = request.query.uid;
    const data = await notesCollection.find({ creatorId: uid }).toArray();
    response.status(200).json({
      status: "Success",
      response: data,
    });
  }
}
