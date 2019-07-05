const functions = require("firebase-functions");
const admin = require("firebase-admin");

exports = module.exports = functions
  .region("asia-northeast1")
  .firestore.document("users/{userId}/tokens/{tokenId}")
  .onCreate((snap, context) => {
    const addTokenToUserDoc = require("./onCreateUtils/addTokenToUserDoc");
    const db = admin.firestore();
    const settings = { timestampsInSnapshots: true };
    db.settings(settings);
    const snapData = snap.data();
    const userId = context.params.userId;
    const tokenId = context.params.tokenId;
    return addTokenToUserDoc(userId, tokenId);
  });
