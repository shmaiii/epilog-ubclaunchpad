import { collection, query, where, getDocs, doc, getDoc, addDoc, updateDoc, deleteDoc, Timestamp } from "firebase/firestore"; 
import { db } from "../firebase/db.js";



// Note: comments below should be uncommented once we implement authentication and add an identification token attached to req.firebaseUserId
const getAllReminderDocuments = async (req, res, next) => {
  try{
    const queryStatement = query(collection(db, `/users/${req.params.user}/reminder`));
    // const queryStatement = query(collection(db, "calendar"), where("user", "==", req.firebaseUserId));
    const querySnapshot = await getDocs(queryStatement);
    const userReminderDocuments = [];

    querySnapshot.forEach((doc) => {
      userReminderDocuments.push({id: doc.id, ...doc.data()});
    })

    return res.json({userReminderDocuments});
  } catch (err) {
    err.code = err.code ?? 500;
    next(err);
  }
};

const updateHomepageReminderGivenId = async (req, res, next) => {
  try {

    let updateDocFieldInputs =  req.body;
    // TODO: check how reminders handle date
    if(updateDocFieldInputs.date){
     updateDocFieldInputs.date = Timestamp.fromDate(new Date(updateDocFieldInputs.date));
    }
   
    await updateDoc(doc(db, `/users/${req.params.user}/reminder/${req.params.reminderDocId}`), updateDocFieldInputs); 
    return res.json({id: req.params.reminderDocId});
  } catch (err) {
    err.code = err.code ?? 500;
    next(err);
  }
};


const deleteHomepageReminderDocumentGivenId = async (req, res, next) => {
  try {
    await deleteDoc(doc(db, `/users/${req.params.user}/reminder/${req.params.reminderDocId}`)); 
    return res.sendStatus(200);
  } catch (err) {
    err.code = err.code ?? 500;
    next(err);
  }
};


export default {
  getAllReminderDocuments,
  updateHomepageReminderGivenId,
  deleteHomepageReminderDocumentGivenId
};
