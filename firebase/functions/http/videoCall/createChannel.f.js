const functions = require("firebase-functions");
const admin = require("firebase-admin");

exports = module.exports = functions.https.onCall(async (data, context) => {
  const { getTokenFromAUser } = require("../../utils/loadUsers");
  console.log("ON CALL CREATE CHANNEL TOPIC HERE");
  console.log(data);
  console.log(typeof data);
  const uid = context.auth.uid;
  const caller = data.caller;
  const receiver = data.receiver;
  const callerUserId = caller.userId;
  const receiverUserId = receiver.userId;
  const channelId = data.channelId;
  const msg = `${caller.displayName} is calling you!!`;
  const payload = {
    notification: {
      title: "GDG Flutter Demo Video Call Notification",
      body: msg,
      sound: "default",
      icon:
        "https://firebasestorage.googleapis.com/v0/b/gdgflutterdemo.appspot.com/o/sample_icon.png?alt=media&token=27016cb2-b6e6-49cb-a973-9275d13ebf96",
      clickAction: "FLUTTER_NOTIFICATION_CLICK"
    },
    data: {
      notificationType: "VIDEO_CALL",
      channelId: channelId,
      userId: caller.userId
    }
  };
  const receiverTokens = await getTokenFromAUser(receiverUserId);
  console.log("BEFORE SEND TO DEVICE HERE");
  console.log(receiverTokens);
  await admin.messaging().sendToDevice(receiverTokens, payload);
  return { message: "SUCCESS" };
});
