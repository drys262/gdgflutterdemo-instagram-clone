const functions = require("firebase-functions");
const admin = require("firebase-admin");

exports = module.exports = functions
  .region("asia-northeast1")
  .firestore.document("questions/{questionsId}")
  .onCreate((snap, context) => {
    const db = admin.firestore();
    const addToUserHistory = require("./onCreateUtils/addToUserHistory");
    const snapData = snap.data();
    return addToUserHistory(snapData, snap.id);
  });
