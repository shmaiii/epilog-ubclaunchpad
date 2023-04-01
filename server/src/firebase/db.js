import { initializeApp } from "firebase/app";
import { addDoc, collection, doc, getDoc, getFirestore, setDoc, updateDoc } from "firebase/firestore";

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfigCA = {
  apiKey: "AIzaSyCpoC0dvzTLnNtAE-gdO7RPQwyZ78EBAzQ",
  authDomain: "epilog-1fa6c.firebaseapp.com",
  projectId: "epilog-1fa6c",
  storageBucket: "epilog-1fa6c.appspot.com",
  messagingSenderId: "768848997584",
  appId: "1:768848997584:web:5a943283446d64f8d942d5",
  measurementId: "G-7FKJSC1P1L"
};

const firebaseConfigUS = {
  apiKey: "AIzaSyCdXGKxluhFglC7c9PDdOwxRiyxguuqu4U",
  authDomain: "epilog-us.firebaseapp.com",
  projectId: "epilog-us",
  storageBucket: "epilog-us.appspot.com",
  messagingSenderId: "834330198268",
  appId: "1:834330198268:web:446e4868928031e1a15779",
  measurementId: "G-MZMVTB3RBQ"
};


// Initialize Firebase
const appCA = initializeApp(firebaseConfigCA, "CA");
const dbCA = getFirestore(appCA);

const appUS = initializeApp(firebaseConfigUS, "US");
const dbUS = getFirestore(appUS);

const db = dbCA;

function getDB(country) {
  if (country == "USA") {
    return dbUS;
  }
  return dbCA;
}

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

export { db, getDB };
