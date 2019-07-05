const admin = require("firebase-admin");

function loadAllUsers() {
  var db = admin.firestore();
  let dbRef = db.collection("users").get();
  let defer = new Promise((resolve, reject) => {
    dbRef
      .then(
        snap => {
          let users = [];
          snap.forEach(doc => {
            var data = doc.data();
            if (data["pushToken"] !== undefined) {
              users.push(data);
            }
          });
          resolve(users);
          return users;
        },
        err => {
          reject(err);
        }
      )
      .catch(() => {
        console.log("ERROR IN LOAD USERS");
        throw new Error("ERRRRRRRROOOOOORR LOAD USERS HAHAHA");
      });
  });
  return defer;
}

const loadUsersWithoutCaller = async callerUserId => {
  console.log("LOAD USER WITHOUT CALLER");
  console.log(callerUserId);
  var db = admin.firestore();
  let userQuerySnapshot = await db.collection("users").get();
  return new Promise((resolve, reject) => {
    console.log("PROMISE STARTS HERE");
    var userTokens = userQuerySnapshot.docs
      .filter(userSnapshot => userSnapshot.id !== callerUserId)
      .map(userSnapshot => userSnapshot.data().tokens);
    let tokens = [].concat.apply([], userTokens);
    console.log("USER TOKENS HERE ---");
    console.log(userTokens);
    console.log(tokens);
    resolve(tokens);
  });
};

const getTokenFromAUser = async userId => {
  console.log("GET TOKEN FROM A USER HERE");
  console.log(userId);
  var db = admin.firestore();
  let userSnapshot = await db.doc(`users/${userId}`).get();
  let userTokens = userSnapshot.data().tokens;
  console.log("USER TOKENS HERE HAHAH");
  console.log(userTokens);
  return userTokens;
};

module.exports = {
  loadAllUsers,
  loadUsersWithoutCaller,
  getTokenFromAUser
};
