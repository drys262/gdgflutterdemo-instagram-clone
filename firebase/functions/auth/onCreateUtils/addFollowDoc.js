const admin = require('firebase-admin');


function addFollowDoc(user) {
  var db = admin.firestore();
  const followData = {
    follows: [],
    displayName: user.displayName,
    photoUrl: user.photoURL,
    email: user.email
  };
  return db.doc(`follows/${user.uid}`).set(followData);
}

module.exports = addFollowDoc;