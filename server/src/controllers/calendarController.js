import { collection, query, where, getDocs, doc, getDoc, addDoc, updateDoc } from "firebase/firestore"; 
import { db } from "../firebase/db.js";

// Note: commends below should be uncommented once we implement authentication and add an identification token attached to req.firebaseUID
const getAllCalendarDocuments = async (req, res, next) => {
  try{
    const queryStatement = query(collection(db, "calendar"), where("user", "==", req.params.user));
    // const queryStatement = query(collection(db, "calendar"), where("user", "==", req.firebaseUID));
    const querySnapshot = await getDocs(queryStatement);
    const userCalendarDocuments = [];

    querySnapshot.forEach((doc) => {
      userCalendarDocuments.push({id: doc.id, ...doc.data()});
    })

    return res.json({userCalendarDocuments});
  } catch (err) {
    err.code = err.code ?? 500;
    next(err);
  }
};

const getCalendarDocumentGivenId = async (req, res, next) => {
  try {
    const documentSnapshot = await getDoc(doc(db, "calendar", req.params.id));
    let documentData = documentSnapshot.data();
    let responseStatusCode = 200;

    // if (documentData?.user === req.firebaseUID) {
    //   documentData = {id: documentSnapshot.id, ...documentData};
    //   responseStatusCode = 200;
    // } else {
    //   documentData = null;
    //   responseStatusCode = 404;
    // }

    return res.status(responseStatusCode).json(documentData);
  } catch (err) {
    err.code = err.code ?? 500;
    next(err);
  }
};

const postCalendarDocument = async (req, res, next) => {
  try {
    const addDocFieldInputs = req.body;

    // if (addDocFieldInputs.user !== req.firebaseUID) {
    //   const error = new Error("Cannot create calendar documents for another user");
    //   error.statusCode = 403
    //   throw error;
    // }

    const addedDocRef = await addDoc(collection(db, "calendar"), addDocFieldInputs); 
    return res.json({id: addedDocRef.id});
  } catch (err) {
    err.code = err.code ?? 500;
    next(err);
  }
};

const updateCalendarDocumentGivenId = async (req, res, next) => {
  try {
    const updateDocFieldInputs = req.body;
    // const documentSnapshot = await getDoc(doc(db, "calendar", req.firebaseUID));
    // const documentData = documentSnapshot.data();

    // if (documentData.user !== req.firebaseUID){
    //   const error = new Error("Cannot update the calendar documents of another user");
    //   error.statusCode = 403
    //   throw error;
    // }
    // else if (updateDocFieldInputs.user !== undefined) {
    //   const error = new Error("Cannot update calendar document's user field");
    //   error.statusCode = 400
    //   throw error;
    // }

    const updatedDocRef = await updateDoc(doc(db, "calendar", req.params.id), updateDocFieldInputs); 
    return res.json({id: updatedDocRef.id});
  } catch (err) {
    err.code = err.code ?? 500;
    next(err);
  }
};

const deleteCalendarDocumentGivenId = async (req, res, next) => {
  try {
    await deleteDoc(doc(db, "calendar", req.params.id)); 
    return res.sendStatus(200);
  } catch (err) {
    err.code = err.code ?? 500;
    next(err);
  }
};

export default {
  getAllCalendarDocuments,
  getCalendarDocumentGivenId,
  postCalendarDocument,
  updateCalendarDocumentGivenId,
  deleteCalendarDocumentGivenId
};
