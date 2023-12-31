import {
  collection,
  query,
  where,
  getDocs,
  doc,
  getDoc,
  addDoc,
  updateDoc,
  deleteDoc,
  Timestamp,
} from "firebase/firestore";
import { getDB } from "../firebase/db.js";

// Note: comments below should be uncommented once we implement authentication and add an identification token attached to req.firebaseUserId
const getAllCalendarDocuments = async (req, res, next) => {
  try {
    const queryStatement = query(
      collection(
        getDB(req.userLocation),
        `/users/${req.firebaseUserId}/calendar`
      )
    );
    // const queryStatement = query(collection(getDB(req.userLocation), "calendar"), where("user", "==", req.firebaseUserId));
    const querySnapshot = await getDocs(queryStatement);
    const userCalendarDocuments = [];

    querySnapshot.forEach((doc) => {
      userCalendarDocuments.push({ id: doc.id, ...doc.data() });
    });

    return res.json({ userCalendarDocuments });
  } catch (err) {
    next(err);
  }
};

const getCalendarDocumentGivenId = async (req, res, next) => {
  try {
    const documentSnapshot = await getDoc(
      doc(
        getDB(req.userLocation),
        `/users/${req.firebaseUserId}/calendar/${req.params.calendarDocId}`
      )
    );
    let documentData = documentSnapshot.data();
    let responseStatusCode = 200;

    // if (documentData?.user === req.firebaseUserId) {
    //   documentData = {id: documentSnapshot.id, ...documentData};
    //   responseStatusCode = 200;
    // } else {
    //   documentData = null;
    //   responseStatusCode = 404;
    // }

    return res.status(responseStatusCode).json(documentData);
  } catch (err) {
    next(err);
  }
};

const postCalendarDocument = async (req, res, next) => {
  try {
    const addDocFieldInputs = req.body;

    if (
      addDocFieldInputs.date?.seconds ||
      addDocFieldInputs.date?.nanoseconds
    ) {
      addDocFieldInputs.date = new Timestamp(
        addDocFieldInputs.date.seconds,
        addDocFieldInputs.date.nanoseconds
      );
    }
    // set default boolean for reminder status: "take or untake"
    addDocFieldInputs.take = false;

    // if (addDocFieldInputs.user !== req.firebaseUserId) {
    //   const error = new Error("Cannot create calendar documents for another user");
    //   error.statusCode = 403
    //   throw error;
    // }

    const addedDocRef = await addDoc(
      collection(
        getDB(req.userLocation),
        `/users/${req.firebaseUserId}/calendar`
      ),
      addDocFieldInputs
    );
    return res.json({ id: addedDocRef.id });
  } catch (err) {
    next(err);
  }
};

const updateCalendarDocumentGivenId = async (req, res, next) => {
  try {
    const updateDocFieldInputs = req.body;
    // const documentSnapshot = await getDoc(doc(getDB(req.userLocation), "calendar", req.firebaseUserId));
    // const documentData = documentSnapshot.data();

    // if (documentData.user !== req.firebaseUserId){
    //   const error = new Error("Cannot update the calendar documents of another user");
    //   error.statusCode = 403
    //   throw error;
    // }
    // else if (updateDocFieldInputs.user !== undefined) {
    //   const error = new Error("Cannot update calendar document's user field");
    //   error.statusCode = 400
    //   throw error;
    // }

    if (
      updateDocFieldInputs.date?.seconds ||
      updateDocFieldInputs.date?.nanoseconds
    ) {
      updateDocFieldInputs.date = new Timestamp(
        updateDocFieldInputs.date.seconds,
        updateDocFieldInputs.date.nanoseconds
      );
    }

    await updateDoc(
      doc(
        getDB(req.userLocation),
        `/users/${req.firebaseUserId}/calendar/${req.params.calendarDocId}`
      ),
      updateDocFieldInputs
    );
    return res.json({ id: req.params.calendarDocId });
  } catch (err) {
    next(err);
  }
};

const updateCalendarDocumentDateGivenId = async (req, res, next) => {
  try {
    let updateDocFieldInputs = req.body;

    if (updateDocFieldInputs.date) {
      updateDocFieldInputs.date = Timestamp.fromDate(
        new Date(updateDocFieldInputs.date)
      );
    }
    await updateDoc(
      doc(
        getDB(req.userLocation),
        `/users/${req.firebaseUserId}/calendar/${req.params.calendarDocId}`
      ),
      updateDocFieldInputs
    );
    return res.json({ id: req.params.calendarDocId });
  } catch (err) {
    err.code = err.code ?? 500;
    next(err);
  }
};

const updateCalendarDocumentTakeGivenId = async (req, res, next) => {
  try {
    let updateDocFieldInputs = req.body;
    await updateDoc(
      doc(
        getDB(req.userLocation),
        `/users/${req.firebaseUserId}/calendar/${req.params.calendarDocId}`
      ),
      updateDocFieldInputs
    );
    return res.json({ id: req.params.calendarDocId });
  } catch (err) {
    err.code = err.code ?? 500;
    next(err);
  }
};

const deleteCalendarDocumentGivenId = async (req, res, next) => {
  try {
    await deleteDoc(
      doc(
        getDB(req.userLocation),
        `/users/${req.firebaseUserId}/calendar/${req.params.calendarDocId}`
      )
    );
    return res.sendStatus(200);
  } catch (err) {
    next(err);
  }
};

export default {
  getAllCalendarDocuments,
  getCalendarDocumentGivenId,
  postCalendarDocument,
  updateCalendarDocumentGivenId,
  updateCalendarDocumentDateGivenId,
  updateCalendarDocumentTakeGivenId,
  deleteCalendarDocumentGivenId,
};
