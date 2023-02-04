import express from 'express';
import cors from 'cors';

import { addDoc, collection, doc, getDoc, getFirestore, setDoc, updateDoc, getDocs } from "firebase/firestore";
import { db } from './firebase/db.js';

const app = express();

app.use(express.json());
app.use(cors());

const PORT = 8080;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`)
})

app.get('/ping', (req, res) => {
    console.log("pong");
    res.status(200).send("pong");
});

// class Reminder {
//     constructor(type, title, date, time, notes) {
//         this.type = type;
//         this.title = title;
//         this.date = date;
//         this.time = time;
//         this.notes = notes;
//     }
// }

// Endpoint for Get request for user's reminders
app.get('/Users/:id/Reminders', async (req, res) => {
    console.log("Get user's reminders");

    const id = req.params.id;
    var reminders = [];

    try {
        const reminderSnapshot = await getDocs(collection(db, "/Users/" + id + "/Reminders"));

        // Add all reminder objects into an array
        reminderSnapshot.docs.forEach((doc) => {
            reminders.push(doc.data());
        });

        // Send the array of reminders back to client
        res.status(200).send(JSON.stringify(reminders));
    } catch (error) {
        console.log("error while getting user reminders");
        console.log(error);
    }

});

// Post request endpoint for adding new reminder
app.post('/new_reminder', async (req, res) => {
    console.log("entering new reminder post request end point");

    const id = req.body.id;
    const new_reminder = req.body.reminder;
    const docRef = await addDoc(collection(db, "/Users/" + id + "/Reminders"), new_reminder)

    res.status(200).send();
});