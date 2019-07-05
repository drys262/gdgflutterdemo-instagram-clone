const admin = require("firebase-admin");

var db = admin.firestore();
const settings = { timestampsInSnapshots: true };
db.settings(settings);

function addUserDocument(user) {
  var uid = user.uid;
  var displayName = user.displayName;
  var data = {
    displayName: displayName,
    profile: {
      email: user.email,
      photoUrl: user.photoURL,
      provider: user.providerData[0].providerId,
      coverPhotoUrl: user.photoURL
    },
    active: true,
    noOfPosts: 0,
    noOfQuestions: 0,
  };

  return db.doc(`users/${uid}`).set(data);
}

module.exports = addUserDocument;
