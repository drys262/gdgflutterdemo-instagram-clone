const admin = require('firebase-admin');


function addUserActivityDoc(user) {
  var db = admin.firestore();
  const data = {
    likedPolls: {},
    bookmarkedPolls: {}
  };
  db.doc(`user_activity/${user.uid}`).set(data);
}

module.exports = addUserActivityDoc;