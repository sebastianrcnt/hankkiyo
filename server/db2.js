const db = require('./db').connectDB();
// db.serialize(() => {
// 	db.run(`insert into users
// 	values ("01037019358", "Sebasitan Jeong", "sec")`)
// })

db.serialize(async () => {
	 db.all(`select phone from users`, (err, rows) => {
		 console.log(rows.length);
	 });
})