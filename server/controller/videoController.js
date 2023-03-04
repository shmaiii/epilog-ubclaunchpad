import { collection, query, where, getDocs, doc, getDoc, addDoc, updateDoc, deleteDoc } from "firebase/firestore"; 
import { db } from "../firebase/db.js";

const getVideoPath = async (req, res) => {
    console.log("getting video path from db");

    const id = req.params.id;
    const videoCollectionRef = doc(db, 'videos')
}