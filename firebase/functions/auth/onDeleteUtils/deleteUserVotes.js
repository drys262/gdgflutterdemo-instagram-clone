const admin = require('firebase-admin');


function deleteUserVotes(uid) {
  var db = admin.firestore();
  db.collection('votes').where(`users.${uid}.email`, ">=", "").get().then((snapshot) => {
    const updates = {};
    updates[`users.${uid}`] = admin.firestore.FieldValue.delete();
    snapshot.forEach(doc => {
      doc.ref.update(updates);
    });
    return snapshot;
  }).catch((err) => {
    console.log(err);
    throw new Error("ERROR IN DELETE USER VOTES FUNCTIONS");
  });
}

module.exports = deleteUserVotes;