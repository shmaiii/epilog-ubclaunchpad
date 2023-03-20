import { collection, query, where, getDocs, doc, getDoc, addDoc, updateDoc, deleteDoc, setDoc } from "firebase/firestore"; 
import { db } from "../firebase/db.js";

const getPersonalInformation = async (req, res) => {
    console.log("getting user's personal info from db");

    const id = req.params.id;
    const testSpecial = doc(db, "/users/" + id);

    try {
        const snapshot = await getDoc(testSpecial);
        if (snapshot.exists()) {
            const docData = snapshot.data();
            res.status(200).send(JSON.stringify(docData));
            
        }
    } catch (error) {
        console.log("Got an error");
        console.log(error);
    }

};

const storePersonalInformation = async(req,res)=>{
    const fullName = req.body.fullName;
    const docData = {
        name : fullName
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