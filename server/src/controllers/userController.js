import { collection, query, where, getDocs, doc, getDoc, addDoc, updateDoc, deleteDoc, setDoc } from "firebase/firestore"; 
import { db, getDB } from "../firebase/db.js";

const getLocation = async (id) => {
    console.log("getting user's location info from db");

    const testSpecial = doc(db, "/users/" + id);

    try {
        const snapshot = await getDoc(testSpecial);
        if (snapshot.exists()) {
            const docData = snapshot.data();
            return docData["location"];
        }
    } catch (error) {
        console.log("Got an error");
        console.log(error);
    }

};

const getPersonalInformation = async (req, res) => {
    console.log("getting user's personal info from db");

    const id = req.firebaseUserId;
    const location = await getLocation(id);
    console.log(location);
    const userDB = getDB(location);
    console.log('before doc()');
    const testSpecial = doc(userDB, "/users/" + id);
    console.log('after doc()');

    try {
        console.log('before getDoc()');
        const snapshot = await getDoc(testSpecial);
        console.log('after getDoc()');
        console.log(snapshot);
        console.log(snapshot.data());
        if (snapshot.exists()) {
            const docData = snapshot.data();
            console.log(JSON.stringify(docData));
            res.status(200).send(JSON.stringify(docData));
            
        }
    } catch (error) {
        console.log("Got an error");
        console.log(error);
    }

};

const storePersonalInformation = async(req,res)=>{
    const docData = {
        ...req.body
    }
    try{
        const contactDoc = await setDoc(doc(db, 'users', req.firebaseUserId), docData);
        res.status(200).send(JSON.stringify(contactDoc));
            
    } catch (error) {
        console.log("Got an error");
        console.log(error);
        
    }
}

export default {
  getPersonalInformation,
  storePersonalInformation
};