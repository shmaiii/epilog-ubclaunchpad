exports.list_all = async(req, res, next) => {
    try {
        // fetching the list from the database
        const all = [];
        res.status(200).json({
            entry_list: all 
        });
    } catch (error) {
        console.log(error)
    }
}