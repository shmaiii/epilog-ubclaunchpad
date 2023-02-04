import express from 'express';
import cors from 'cors';

import { addDoc, collection, deleteDoc, doc, getDoc, getDocs, setDoc, updateDoc } from "firebase/firestore";
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

app.get('/user/:id/patientsdoctors/read', async (req, res) => {
    console.log("getting user's personal info from db");

    const id = req.params.id;
    const testSpecial = doc(db, "/users/" + id);
    var docData;
    try {
        const snapshot = await getDoc(testSpecial);
        if (snapshot.exists()) {
            docData = snapshot.data().doctors;
            //console.log(docData)
            //res.status(200).send(`Data is ${JSON.stringify(docData)}`);
        }
    } catch (error) {
        console.log("Got an error");
        console.log(error);
    }
    //console.log(docData)
    const xx = doc(db, "/contacts/" + docData[0] );
    
    try {
        const snapshot = await getDoc(xx);
        if (snapshot.exists()) {
            docData = snapshot.data();
            console.log(docData)
            res.status(200).send(`Data is ${JSON.stringify(docData)}`);
            const docData = snapshot.data();
            res.status(200).send(JSON.stringify(docData));
        }
    } catch (error) {
        console.log("Got an error");
        console.log(error);
    }
});

app.get('/user/:id/patientsdoctors/read', async (req, res) => {
    console.log("getting user's personal info from db");

    const id = req.params.id;
    const testSpecial = doc(db, "/users/" + id);
    var docData;
    try {
        const snapshot = await getDoc(testSpecial);
        if (snapshot.exists()) {
            docData = snapshot.data().doctors;
            //console.log(docData)
            //res.status(200).send(`Data is ${JSON.stringify(docData)}`);
        }
    } catch (error) {
        console.log("Got an error");
        console.log(error);
    }
    //console.log(docData)
    const xx = doc(db, "/contacts/" + docData[0] );
    
    try {
        const snapshot = await getDoc(xx);
        if (snapshot.exists()) {
            docData = snapshot.data();
            console.log(docData)
            res.status(200).send(`Data is ${JSON.stringify(docData)}`);
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
    const userMedications = collection(db, "/users/" + id + "/medications");

    try {
        const medDocs = await getDocs(userMedications);

        const medications = [];
        medDocs.forEach((medDoc) => {
            var data = medDoc.data();
            data.id = medDoc.id;
            medications.push(data);
        })

        res.status(200).send(JSON.stringify(medications));

    } catch (error) {
        console.log("Got an error");
        console.log(error);
    }
});

app.post('/user/:id/medications/add', async (req, res) => {
    console.log("adding medication in db");

    const id = req.params.id;
    const docData = {
        name: req.body.name,
        dosage: req.body.dosage,
        administration_method: req.body.administration_method
    };

    try {
        const medDoc = await addDoc(collection(db, '/users/' + id + '/medications'), docData);
        res.status(200).send(medDoc.id);
    } catch (error) {
        console.log("Got an error");
        console.log(error);
    }
});

app.post('/user/:uid/medications/:mid/edit', async (req, res) => {
    console.log("editing user's medication in db");

    const uid = req.params.uid;
    const mid = req.params.mid;
    const docData = {
        name: req.body.name,
        dosage: req.body.dosage,
        administration_method: req.body.administration_method
    };

    try {
        await updateDoc(doc(db, '/users/' + uid + '/medications/' + mid), docData);
        res.status(200).send("Success!");
    } catch (error) {
        console.log("Got an error");
        console.log(error);
    }
});

app.post('/user/:uid/medications/:mid/delete', async (req, res) => {
    console.log("deleting user's medication in db");

    const uid = req.params.uid;
    const mid = req.params.mid;

    try {
        await deleteDoc(doc(db, '/users/' + uid + '/medications/' + mid));
        res.status(200).send("Success!");
    } catch (error) {
        console.log("Got an error");
        console.log(error);
    }
});

// CONTACTS ENDPOINTS

const readIds = async (collection, ids)=>{
    const reads = ids.map(id => collection.doc(id).get())
    const result = await Promise.all(reads)
    return result.map(v => v.data())
}


app.get('/user/:id/contacts/read', async (req, res) => {
    console.log("getting user's contacts from db");
   

    const id = req.params.id;
    const testSpecial = doc(db, "/users/" + id);
    var docDataArray;
    try {
        const snapshot = await getDoc(testSpecial);
        if (snapshot.exists()) {
            docDataArray = snapshot.data().Doctors;
            console.log(docDataArray)
        }
    } catch (error) {
        console.log("Got an error");
        console.log(error);
    }
    let result = {};
    try {
        for(var i =0; i< docDataArray.length; i++){
            const snapshot = await getDoc(docDataArray[i]);
            if (snapshot.exists()) {
                const docData = snapshot.data();
                //console.log(docData)
                result[i] = docData;
                
            }
        }
        console.log(result)
        res.status(200).send(`Data is ${JSON.stringify(result)}`);
       
    } catch (error) {
        console.log("Got an error");
        console.log(error);
    }
});

/**
 * still need to figure out how to assign a auto-generated id to each document 
 */
app.post('/contacts/add', async (req, res) => {
    console.log("adding user's contact in db");
    const data = {
    first: 'Ada',
    last: 'Lovelace',
    born: 1815
    }

    await setDoc(doc(db, "/users/", "1"), data);
    //res.status(200).send(`Data is ${JSON.stringify(result)}`);
});


// does not work
app.post('/contacts/:cid/edit', async (req, res) => {
    const id = req.params.cid;
    const reqBody = {
        first : req.body.fullName,
        last : req.body.height,
        born: 999
    }
    console.log(req)
    console.log("adding user's contact in db");
    
    const data = {
        first: 'aha',
        last: 'changed',
        born: 2002
    }

    await updateDoc(doc(db, "/users/", id), reqBody);
});