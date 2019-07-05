const admin = require("firebase-admin");
const db = admin.firestore();
const fcm = admin.messaging();

const notifyUsers = async postsId => {
  const { loadUsersWithoutCaller } = require("../../../utils/loadUsers");
  const userDoc = db.doc(`posts/${postsId}`);
  return userDoc.get().then(async snapshot => {
    const data = snapshot.data();
    const userId = data.user.userId;
    console.log("NOTIFY USERS HERE WHEN UPLOAD IS DONE");
    console.log(data);
    const msg = `New Post by ${data.user.displayName}`;
    const payload = {
      notification: {
        title: "GDG Flutter Demo Notification",
        body: msg,
        sound: "default",
        icon:
          "https://firebasestorage.googleapis.com/v0/b/gdgflutterdemo.appspot.com/o/sample_icon.png?alt=media&token=27016cb2-b6e6-49cb-a973-9275d13ebf96",
        clickAction: "FLUTTER_NOTIFICATION_CLICK"
      }
    };
    const tokens = await loadUsersWithoutCaller(userId);
    console.log("TOKENS HERE");
    console.log(tokens);
    return fcm.sendToDevice(tokens, payload);
  });
};

module.exports = notifyUsers;
