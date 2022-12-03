import {db, doc, collection, addDoc, getDoc, query, where, getDocs, updateDoc} from "../config.js"

const list_all = async(req, res) => {
    try {
        // fetching the list from the database
        const querySnapshot = await getDocs(collection(db, "/Users"));
        console.log(querySnapshot)
        let all = []
        querySnapshot.forEach((doc) => {
            // console.log(doc.id, " => ", doc.data());
            all.push({id: doc.id, info: doc.data()})
          });
        res.status(200).json({
            entry_list: all,
            msg: "done"
        });
    } catch (error) {
        console.log(error)
        res.status(500).json({
            msg: "Internal error"
        })
    }
}

const create = async (req, res) => {
    try {
        const data = req.body;
        const docRef = await addDoc(collection(db, "Users"), data)
        //console.log("Here is the reference to the documnet", docRef)
        res.status(200).json({
            msg: "User Added"
        });
    } catch (e) {
        console.log(e)
        res.status(500).json({
            msg: "Internal error"
        })
    }
}

const update = async (req, res) => {
    try {
        console.log("Received an update request: ---------- ", req)
        const entryInfo = req.body;
        console.log("Request body: ", entryInfo)
        const docRef = doc(db, "Users", entryInfo.userId)
        await updateDoc(docRef, entryInfo.entry);
        res.status(200).json({
            msg: "User Updated"
        });
    } catch (e) {
        console.log(e)
        res.status(500).json({
            msg: "Internal error"
        })
    }
}

export {
    list_all,
    create, 
    update
}