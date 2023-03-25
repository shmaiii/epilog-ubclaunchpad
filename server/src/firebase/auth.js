import firebaseAdmin from "firebase-admin";
import { adminFirebaseCredentials } from "./adminFirebaseCredentials.js";

const admin = firebaseAdmin.initializeApp({
  credential: firebaseAdmin.credential.cert(adminFirebaseCredentials),
  databaseURL: "https://epilog-1fa6c.firebaseio.com"
});

const auth = admin.auth();

export { auth };
