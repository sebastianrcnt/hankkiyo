const express = require("express");
const jwt = require("jsonwebtoken");
const sqlite3 = require("sqlite3");

// create app
const app = express();

// set database
const connectDB = require("./db.js").connectDB;
const db = connectDB();

// set parameters
app.set("port", 3000);

// set middlewares
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use((req, res, next) => {
  console.log(`${req.method} request on ${req.url}`);
  next();
});

// responses
app.post("/signup", (req, res) => {
  const { phone, name, password } = req.body;
  if (phone && name && password) {
    db.serialize(() => {
      let alreadyExists;
      db.all(`select phone from users`, (err, rows) => {
        alreadyExists = rows.length > 0;
      });
      if (!alreadyExists) {
        db.run(
          `
						insert into users(phone, name, password)
						values("${phone}", "${name}", "${password}")
					`,
          (err) => {
            if (err) {
              res.status(400).json(err);
            } else {
              res.sendStatus(200);
            }
          }
        );
      } else {
        res.sendStatus(400);
      }
    });
  } else {
    res.sendStatus(400);
  }
});

app.get("/login", (req, res) => {
  const { phone, password } = req.body;
  console.table(req.body);
  db.serialize(() => {
    db.all(`select phone, password from users`, (err, rows) => {
      const found = rows.find((row) => {
        return row.phone === phone && row.password === password;
      });
      if (found) {
        const token = jwt.sign(
          {
            phone: found.phone,
          },
          "secret",
          { expiresIn: 10 }
        );
        res.json({
          success: true,
          token,
        });
      } else {
        res.json({
          success: false,
        });
      }
    });
  });
});

app.get("/verify", (req, res) => {
  const token = req.query.token;
  if (token) {
    jwt.verify(token, "secret", (error, payload) => {
      if (error) {
        res.json({ success: false, error });
      } else {
        res.json({ success: true, user });
      }
    });
  } else {
    res.sendStatus(400);
  }
});

app.listen(app.get("port"));
