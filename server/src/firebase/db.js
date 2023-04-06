import { initializeApp } from "firebase/app";
import {
  addDoc,
  collection,
  doc,
  getDoc,
  getFirestore,
  setDoc,
  updateDoc,
} from "firebase/firestore";

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfigCA = {
  apiKey: "AIzaSyCpoC0dvzTLnNtAE-gdO7RPQwyZ78EBAzQ",
  authDomain: "epilog-1fa6c.firebaseapp.com",
  projectId: "epilog-1fa6c",
  storageBucket: "epilog-1fa6c.appspot.com",
  messagingSenderId: "768848997584",
  appId: "1:768848997584:web:5a943283446d64f8d942d5",
  measurementId: "G-7FKJSC1P1L",
};

const firebaseConfigUS = {
  apiKey: "AIzaSyCdXGKxluhFglC7c9PDdOwxRiyxguuqu4U",
  authDomain: "epilog-us.firebaseapp.com",
  projectId: "epilog-us",
  storageBucket: "epilog-us.appspot.com",
  messagingSenderId: "834330198268",
  appId: "1:834330198268:web:446e4868928031e1a15779",
  measurementId: "G-MZMVTB3RBQ",
};

// Initialize Firebase
const appCA = initializeApp(firebaseConfigCA, "CA");
const dbCA = getFirestore(appCA);

const appUS = initializeApp(firebaseConfigUS, "US");
const dbUS = getFirestore(appUS);

function getDB(country) {
  if (country == "USA") {
    return dbUS;
  }
  return dbCA;
}

export { getDB };
