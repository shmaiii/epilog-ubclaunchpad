const User = require("./config")

exports.list_all = async(req, res) => {
    try {
        // fetching the list from the database
        const snapshot = await User.get(); 
        const all = snapshot.docs.map((doc) => ({
            id: doc.id, ...doc.data()
        }))
        res.status(200).json({
            entry_list: all 
        });
    } catch (error) {
        console.log(error)
    }
}

exports.create = async (req, res) => {
    try {
        const data = req.body;
        await User.add({data})
        res.status(200).json({
            msg: "User Added"
        });
    } catch (e) {
        console.log(e)
    }
}