const functions = require("firebase-functions");
// my files
const addUserDoc = require("./onCreateUtils/addUserDoc");

exports = module.exports = functions
  .region("asia-northeast1")
  .auth.user()
  .onCreate(async user => {
    const addUserHistoryDoc = require("./onCreateUtils/addUserHistoryDoc");
    const sendWelcomeEmail = require("./onCreateUtils/sendWelcomeEmail");
    console.log("ON CREATE USER HERE");
    console.log(user);
    addUserDoc(user);
    addUserHistoryDoc(user);
    return sendWelcomeEmail(user);
  });
