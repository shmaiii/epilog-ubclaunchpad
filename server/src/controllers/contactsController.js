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

const getContacts = async (req, res) => {
  console.log("getting user's contacts from db");

  const id = req.params.id;
  const userContactsInfo = collection(
    getDB(req.userLocation),
    "/users/" + id + "/contacts"
  );

  try {
    const contactsDocs = await getDocs(userContactsInfo);

    const contacts = [];
    contactsDocs.forEach((contactDoc) => {
      var data = contactDoc.data();
      data.id = contactDoc.id;
      contacts.push(data);
    });

    res.status(200).send(JSON.stringify(contacts));
  } catch (error) {
    console.log("Got an error");
    console.log(error);
  }
};

const addContact = async (req, res) => {
  console.log("adding a new contact in db");
  const id = req.params.id;
  const docData = {
    name: req.body.name,
    phoneNumber: req.body.phoneNumber,
    type: req.body.type,
  };
  try {
    const contactDoc = await addDoc(
      collection(getDB(req.userLocation), "/users/" + id + "/contacts"),
      docData
    );
    res.status(200).send(contactDoc.id);
  } catch (error) {
    console.log("Got an error");
    console.log(error);
  }
};

const editContact = async (req, res) => {
  console.log("editing user's contact in db");

  const uid = req.params.uid;
  const cid = req.params.cid;
  const docData = {
    name: req.body.name,
    phoneNumber: req.body.phoneNumber,
    type: req.body.type,
  };

  try {
    await updateDoc(
      doc(getDB(req.userLocation), "/users/" + uid + "/contacts/" + cid),
      docData
    );
    res.status(200).send("Success!");
  } catch (error) {
    console.log("Got an error");
    console.log(error);
  }
};

const deleteContact = async (req, res) => {
  console.log("deleting user's contact in db");

  const uid = req.params.uid;
  const cid = req.params.cid;
  try {
    await deleteDoc(
      doc(getDB(req.userLocation), "/users/" + uid + "/contacts/" + cid)
    );
    res.status(200).send("Success!");
  } catch (error) {
    console.log("Got an error");
    console.log(error);
  }
};

export default {
  getContacts,
  addContact,
  editContact,
  deleteContact,
};
