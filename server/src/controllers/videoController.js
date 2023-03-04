import { collection, query, where, getDocs, doc, getDoc, addDoc, updateDoc, deleteDoc } from "firebase/firestore"; 
import { db } from "../firebase/db.js";

const getVideoDoc = async (req, res) => {
    console.log("getting video path from db");

    const id = req.params.id;
    const videoDocumentRef = doc(db, `videos/${id}`);

    try {
        const video = await getDoc(videoDocumentRef);
        if (video.exists()) {
            const docData = video.data();
            res.status(200).send(JSON.stringify(docData));
        }
    } catch (error) {
        console.log(error);
    }
}

const getAllVideos = async(req, res) => {
    console.log("getting all videos");
    const videoCollectionRef = collection(db, 'videos');

    try {
        const videoDocs = await getDocs(videoCollectionRef);
        const videos = [];
        videoDocs.forEach((videoDoc) => {
            var data = videoDoc.data();
            data.id = videoDoc.id;
            videos.push(data);
        })

        res.status(200).send(JSON.stringify(videos));

    } catch (error) {
        console.log(error);
    }
}

export default {
    getVideoDoc,
    getAllVideos
}