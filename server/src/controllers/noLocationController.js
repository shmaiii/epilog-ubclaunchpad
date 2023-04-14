import { doc, getDoc, setDoc } from "firebase/firestore";
import { getDB } from "../firebase/db.js";

const getLocation = async (req, res) => {
  const userDoc = doc(getDB("Canada"), "/users/" + req.firebaseUserId);

  try {
    const snapshot = await getDoc(userDoc);
    const returnedData = {};
    if (snapshot.exists()) {
      const docData = snapshot.data();
      returnedData["location"] = docData["location"];
    }
    return res.status(200).send(JSON.stringify(returnedData));
  } catch (error) {
    console.log("Got an error");
    console.log(error);
  }
};

// For users in USA, we will create an entry in Canada and USA. The entry in Canada will not
// have personal information but will be used to check user location in future HTTP request.
const initializeUserUSA = async (req, res) => {
  const { name, location } = req.body;
  const docData = {
    name: name,
    location: location,
  };
  try {
    await setDoc(doc(getDB("USA"), "users", req.firebaseUserId), docData);

    await setDoc(doc(getDB("Canada"), "users", req.firebaseUserId), docData);

    res.sendStatus(200);
  } catch (err) {
    console.log("Got an error");
    console.log(err);
  }
};

const initializeUserCanada = async (req, res) => {
  const { name, location } = req.body;
  const docData = {
    name: name,
    location: location,
  };
  try {
    await setDoc(doc(getDB("Canada"), "users", req.firebaseUserId), docData);

    res.sendStatus(200);
  } catch (err) {
    console.log("Got an error");
    console.log(err);
  }
};

export default {
  initializeUserCanada,
  initializeUserUSA,
  getLocation,
};
