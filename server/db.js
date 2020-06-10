const sqlite3 = require("sqlite3");

exports.connectDB = () => {
	let db = new sqlite3.Database(
		"./database.db",
		sqlite3.OPEN_READWRITE,
		(err) => {
			if (err) {
				console.error(err.message);
			} else {
				console.log("Connected to the mydb database.");
			}
		}
	)

	return db;
}
