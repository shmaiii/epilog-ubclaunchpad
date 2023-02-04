import { collection, query, where, getDocs, doc, getDoc, addDoc, updateDoc, deleteDoc } from "firebase/firestore"; 
import { db } from "../firebase/db.js";

// Todo: implement authorization for calendar collection in firebase website once we implement authentication

const getAllCalendarDocuments = async (req, res, next) => {
  try{
    const queryStatement = query(collection(db, "calendar"), where("user", "==", req.params.user));

    // Note: we might not need req.params.user once we implement firebase authorization rules to deny user access 
    // other user's calendar documents. If so, use code below for queryStatement variable and delete user path params
    //const queryStatement = query(collection(db, "calendar"));

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

    return res.json(documentData);
  } catch (err) {
    err.code = err.code ?? 500;
    next(err);
  }
};

const postCalendarDocument = async (req, res, next) => {
  try {
    const addDocFieldInputs = req.body;

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

    await updateDoc(doc(db, "calendar", req.params.id), updateDocFieldInputs); 
    return res.json({id: req.params.id});
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
