const admin = require('firebase-admin');

function deleteUserComments(user) {
  var db = admin.firestore();
  db.collection('comments').where('owner.userId', '==', user.uid).get().then((snap) => {
    snap.forEach(doc => {
      return db.doc(`comments/${doc.id}`).delete();
    });
    return snap;
  }).catch(err => {
    console.log('Error getting documents', err);
    throw new Error('ERROR HALU');
  });
}

module.exports = deleteUserComments;