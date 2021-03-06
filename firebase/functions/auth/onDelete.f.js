const functions = require("firebase-functions");
const admin = require("firebase-admin");

exports = module.exports = functions
  .region("asia-northeast1")
  .auth.user()
  .onDelete(user => {
    var db = admin.firestore();
    var uid = user.uid;
    db.doc(`history/${uid}`).delete();
    return db.doc(`users/${uid}`).delete();
  });
