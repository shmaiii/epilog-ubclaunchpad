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
} from "firebase/firestore";
import { getDB } from "../firebase/db.js";

const getMedications = async (req, res) => {
  console.log("getting user's medications from db");

  const id = req.firebaseUserId;
  const userMedications = collection(
    getDB(req.userLocation),
    "/users/" + id + "/medications"
  );

  try {
    const medDocs = await getDocs(userMedications);

    const medications = [];
    medDocs.forEach((medDoc) => {
      var data = medDoc.data();
      data.id = medDoc.id;
      medications.push(data);
    });

    res.status(200).send(JSON.stringify(medications));
  } catch (error) {
    console.log("Got an error");
    console.log(error);
  }
};

const addMedication = async (req, res) => {
  console.log("adding medication in db");

  const id = req.firebaseUserId;
  const docData = {
    name: req.body.name,
    dosage: req.body.dosage,
    administration_method: req.body.administration_method,
  };

  try {
    const medDoc = await addDoc(
      collection(getDB(req.userLocation), "/users/" + id + "/medications"),
      docData
    );
    res.status(200).send(medDoc.id);
  } catch (error) {
    console.log("Got an error");
    console.log(error);
  }
};

const editMedication = async (req, res) => {
  console.log("editing user's medication in db");

  const uid = req.firebaseUserId;
  const mid = req.params.mid;
  const docData = {
    name: req.body.name,
    dosage: req.body.dosage,
    administration_method: req.body.administration_method,
  };

  try {
    await updateDoc(
      doc(getDB(req.userLocation), "/users/" + uid + "/medications/" + mid),
      docData
    );
    res.status(200).send("Success!");
  } catch (error) {
    console.log("Got an error");
    console.log(error);
  }
};

const deleteMedication = async (req, res) => {
  console.log("deleting user's medication in db");

  const uid = req.firebaseUserId;
  const mid = req.params.mid;

  try {
    await deleteDoc(
      doc(getDB(req.userLocation), "/users/" + uid + "/medications/" + mid)
    );
    res.status(200).send("Success!");
  } catch (error) {
    console.log("Got an error");
    console.log(error);
  }
};

export default {
  getMedications,
  addMedication,
  editMedication,
  deleteMedication,
};
