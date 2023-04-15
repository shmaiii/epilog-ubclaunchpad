// import {db, doc, collection, addDoc, getDoc, query, where, getDocs, updateDoc, setDoc} from "../../config.js"
import {doc, collection, addDoc, getDoc, query, where, getDocs, updateDoc, setDoc} from "firebase/firestore"; 
import { getDB } from "../firebase/db.js";


const list_all = async(req, res) => {
    console.log(req);
    //const userId = req.query.userId;
    // todo: revert the hardcoded user and add the token that is the id here
    // the id is injected to the req in the middle layer, we can access that using the req.firebaseUserId
    const userId = req.firebaseUserId;
    console.log("------------------------------------------------------------------------")
    console.log("userId: " + userId)
    try {
        // fetching the list from the database
        const querySnapshot = await getDocs(collection(getDB(req.userLocation), "/users/" + userId + "/entries"));
        // console.log(querySnapshot)
        let all = []
        querySnapshot.forEach((doc) => {
            // console.log(doc.id, " => ", doc.data());
            all.push({id: doc.id, info: doc.data()})
          });
        res.status(200).json({
            entry_list: all,
            msg: "done"
        });
    } catch (error) {
        console.log(error)
        res.status(500).json({
            msg: "Internal error"
        })
    }
}

const create = async (req, res) => {
    const userId = req.firebaseUserId;
    // req.query.userId;
    try {
        const data = req.body;
        const collectionAddress = "users/" + userId + "/entries"
        const {id: docId} = await addDoc(collection(getDB(req.userLocation), collectionAddress), data)
        // console.log("Here is the id", docId)
        // we don't need to keep the id in the document, we can pass it in the get response
        // const collectionRef = collection(db, collectionAddress);
        // const entryWithId = { ...data, id: docId };
        // await setDoc(doc(collectionRef, docId), entryWithId);
        res.status(200).json({
            msg: "User Added"
        });
    } catch (e) {
        console.log(e)
        res.status(500).json({
            msg: "Internal error"
        })
    }
}

const update = async (req, res) => {
    const userId = req.firebaseUserId;
    // req.query.userId;
    try {
        // console.log("Received an update request: ---------- ", req.body)
        const entryInfo = req.body;
        // console.log("Request body: ", entryInfo)
        const docRef = doc(getDB(req.userLocation), "users/" + userId + "/entries", entryInfo.userId)
        await updateDoc(docRef, entryInfo.entry);
        res.status(200).json({
            msg: "User Updated"
        });
    } catch (e) {
        console.log(e)
        res.status(500).json({
            msg: "Internal error"
        })
    }
}

export {
    list_all,
    create, 
    update
}