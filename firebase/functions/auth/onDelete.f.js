const functions = require("firebase-functions");
const admin = require("firebase-admin");

exports = module.exports = functions.auth.user().onDelete(user => {
  var db = admin.firestore();
  var uid = user.uid;
  return db.doc(`users/${uid}`).delete();
});
