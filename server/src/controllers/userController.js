import { doc, getDoc, setDoc } from "firebase/firestore";
import { getDB } from "../firebase/db.js";

const getPersonalInformation = async (req, res) => {
  console.log("getting user's personal info from db");

  const id = req.firebaseUserId;
  const location = req.userLocation;
  const userDB = getDB(location);
  const testSpecial = doc(userDB, "/users/" + id);

  try {
    const snapshot = await getDoc(testSpecial);
    let returnedData = {};
    if (snapshot.exists()) {
      returnedData = snapshot.data();
    }
    console.log('What is returnedData', returnedData);
    res.status(200).send(JSON.stringify(returnedData));
  } catch (error) {
    console.log("Got an error");
    console.log(error);
  }
};

const storePersonalInformation = async (req, res) => {
  const docData = {
    ...req.body,
  };
  try {
    const contactDoc = await setDoc(
      doc(getDB(req.userLocation), "users", req.firebaseUserId),
      docData
    );
    res.status(200).send(JSON.stringify(contactDoc));
  } catch (error) {
    console.log("Got an error");
    console.log(error);
  }
};

export default {
  getPersonalInformation,
  storePersonalInformation,
};
