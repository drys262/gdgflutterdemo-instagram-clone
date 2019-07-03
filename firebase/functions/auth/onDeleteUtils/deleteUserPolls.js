const admin = require('firebase-admin');

function deleteUserPolls(user) {
  var db = admin.firestore();
  db.collection('polls').where('owner.userId', '==', user.uid).get().then((snap) => {
    snap.forEach(doc => {
      return db.doc(`polls/${doc.id}`).delete();
    });
    return snap;
  }).catch(err => {
    console.log('Error getting documents', err);
    throw new Error('ERROR HALU');
  });
}

module.exports = deleteUserPolls;