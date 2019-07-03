const admin = require('firebase-admin');


function addRelationshipDoc(user) {
  var db = admin.firestore();
  db.doc(`relationship_following/${user.uid}`).set({
    following: {}
  });
  return db.doc(`relationship_followers/${user.uid}`).set({
    followers: {}
  });
}

module.exports = addRelationshipDoc;