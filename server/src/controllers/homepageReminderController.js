import { collection, query, where, getDocs, doc, getDoc, addDoc, updateDoc, deleteDoc } from "firebase/firestore"; 
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


// const deleteHomepageReminderDocumentGivenId = async (req, res, next) => {
//   try {
//     await deleteDoc(doc(db, `/users/${req.params.user}/reminder/${req.params.reminderDocId}`)); 
//     return res.sendStatus(200);
//   } catch (err) {
//     err.code = err.code ?? 500;
//     next(err);
//   }
// };


export default {
  getAllReminderDocuments,
  // deleteHomepageReminderDocumentGivenId
};
