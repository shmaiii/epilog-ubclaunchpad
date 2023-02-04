import { initializeApp } from "firebase/app";
import { addDoc, collection, doc, getDoc, getFirestore, setDoc, updateDoc, query, where, getDocs} from "firebase/firestore";
import firebaseEnv from "./firebaseEnv";

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = firebaseEnv;

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const db = getFirestore(app);

const testSpecial = doc(db, "hello/world");
// Write document if it exists, replace document otherwise
async function testSet() {
  console.log("Test Set");
  const docData = {
    hello: "world",
    foo: "boo",
  };
  console.log("Defined docData");
  try {
    await setDoc(testSpecial, docData);
  } catch (error) {
    console.log("Got an error");
    console.log(error);
  }
}

// Only update specified fields
async function testUpdate() {
  console.log("Test Set");
  const docData = {
    hello: "eqeworld",
  };
  try {
    await updateDoc(testSpecial, docData);
  } catch (error) {
    console.log("Got an error");
    console.log(error);
  }
}

async function testGet() {
  console.log("Test Get");
  try {
    const snapshot = await getDoc(testSpecial);
    if (snapshot.exists()) {
      const docData = snapshot.data();
      console.log(`Data is ${JSON.stringify(docData)}`);
    }
  } catch (error) {
    console.log("Got an error");
    console.log(error);
  }
}

const testCollection = collection(db, "testingBackend");
async function testNewDoc() {
  try {
    const newdoc = await addDoc(testCollection, {
      testing: "yes this is a test",
    });
    console.log(`New doc created at ${newdoc.path}`);
  } catch (error) {
    console.log("Oops, error with newdoc");
  }
}

// testSet();
// testUpdate();
// testNewDoc();
// testGet();
// console.log("Testing");

export { db, collection, addDoc, getDoc, doc, query, where, getDocs, updateDoc};