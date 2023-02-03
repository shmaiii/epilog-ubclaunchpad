import { collection, query, where, getDocs, doc, getDoc } from "firebase/firestore"; 
import { db } from "../firebase/db.js";

const getAllCalendarDocumentsGivenUser = async (req, res, next) => {
  try{
    const q = query(collection(db, "calendar"), where("user", "==", req.params.user));
    const querySnapshot = await getDocs(q);
    const userCalendarDocuments = [];

    querySnapshot.forEach((doc) => {
      userCalendarDocuments.push({id: doc.id, ...doc.data()});
    })

    return res.json({userCalendarDocuments});
  } catch (err) {
    err.statusCode = 500;
    next(err)
  }
}

const getCalendarDocumentGivenId = async (req, res, next) => {
  try {
    const d = doc(db, "calendar", req.params.id);
    const documentSnapshot = await getDoc(d);
    let documentData = documentSnapshot.data();
    let responseStatusCode = 200;

    if (documentData?.user === req.params.user) {
      documentData = {id: documentSnapshot.id, ...documentData};
      responseStatusCode = 200;
    } else {
      documentData = null;
      responseStatusCode = 404;
    }

    return res.status(responseStatusCode).json(documentData);
  } catch (err) {
    err.statusCode = 500;
    next(err)
  }
}

export default {
  getAllCalendarDocumentsGivenUser,
  getCalendarDocumentGivenId
}