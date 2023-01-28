import express from 'express';
import cors from 'cors';

import { addDoc, collection, doc, getDoc, getFirestore, setDoc, updateDoc } from "firebase/firestore";
import { db } from './firebase/db.js';

const app = express();

app.use(express.json());
app.use(cors());

const PORT = 8080;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`)
})
app.get('/', (req, res) => {
    console.log("connected");
    res.status(200).send("connected");
});
app.get('/ping', (req, res) => {
    console.log("pong");
    res.status(200).send("pong");
});

// USERS ENDPOINTS

app.get('/user/:id/personal-information/read', async (req, res) => {
    console.log("getting user's personal info from db");

    const id = req.params.id;
    const testSpecial = doc(db, "/users/" + id);

    try {
        const snapshot = await getDoc(testSpecial);
        if (snapshot.exists()) {
            const docData = snapshot.data();
            res.status(200).send(JSON.stringify(docData));
        }
    } catch (error) {
        console.log("Got an error");
        console.log(error);
    }
});

app.post('/user/:id/personal-information/edit', async (req, res) => {
    console.log("editing user's personal info in db");
});

// MEDICATIONS ENDPOINTS

app.get('/user/:id/medications/read', async (req, res) => {
    console.log("getting user's medications from db");

    const id = req.params.id;
    const testSpecial = doc(db, "/users/" + id);

    try {
        const snapshot = await getDoc(testSpecial);
        if (snapshot.exists()) {
            const docData = snapshot.data();

            const mids = [];
            for (const x of docData["Medications"]) {
                mids.push(x["_key"]["path"]["segments"][6]);
            }

            const medications = [];
            for (const y of mids) {
                const testSpecial2 = doc(db, "/medications/" + y);

                const snapshot2 = await getDoc(testSpecial2)
    
                if (snapshot2.exists()) {
                    medications.push(snapshot2.data());
                }
            }

            res.status(200).send(JSON.stringify(medications));
        }
    } catch (error) {
        console.log("Got an error");
        console.log(error);
    }
});

app.post('/medications/add', async (req, res) => {
    console.log("adding medication in db");
    const testSpecial = doc(db, "/medications/FDsVfAhfhwqkqvesRPVH");

    const docData = {
        name: req.body.name,
        dosage: req.body.dosage,
        administration_method: req.body.administration_method
    };
    console.log("Defined docData");
    try {
        await setDoc(testSpecial, docData);
        res.status(200).send("success");
    } catch (error) {
        console.log("Got an error");
        console.log(error);
    }
});

app.post('/medications/edit', async (req, res) => {
    console.log("editing user's medication in db");

    const testSpecial = doc(db, req.body.path);

    const docData = {
        name: req.body.name
    };
    console.log("Defined docData");
    try {
        await updateDoc(testSpecial, docData);
        res.status(200).send("success");
    } catch (error) {
        console.log("Got an error");
        console.log(error);
    }
});

// CONTACTS ENDPOINTS

app.get('/user/:id/contacts/read', async (req, res) => {
    console.log("getting user's contacts from db");
});

app.post('/contacts/add', async (req, res) => {
    console.log("adding user's contact in db");
});

app.post('/contacts/:cid/edit', async (req, res) => {
    console.log("editing user's contact in db");
});