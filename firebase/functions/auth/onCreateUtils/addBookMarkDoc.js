const admin = require('firebase-admin');


function addBookMarkDoc(user) {
  var db = admin.firestore();
  const Data = {
    pollIds: []
  };
  return db.doc(`bookmarks/${user.uid}`).set(Data);
}

module.exports = addBookMarkDoc;