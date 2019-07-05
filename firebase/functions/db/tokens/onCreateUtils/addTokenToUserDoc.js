const admin = require("firebase-admin");

const addTokenToUserDoc = (userId, tokenId) => {
  const db = admin.firestore();
  return db.doc(`users/${userId}`).update({
    tokens: admin.firestore.FieldValue.arrayUnion(tokenId)
  });
};

module.exports = addTokenToUserDoc;
