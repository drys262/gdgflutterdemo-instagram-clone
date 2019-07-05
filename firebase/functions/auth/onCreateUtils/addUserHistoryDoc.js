const admin = require("firebase-admin");

function addUserHistoryDoc(user) {
  var db = admin.firestore();
  const data = {
    events: []
  };
  db.doc(`history/${user.uid}`).set(data);
}

module.exports = addUserHistoryDoc;
