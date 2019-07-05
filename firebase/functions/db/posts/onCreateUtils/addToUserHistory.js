const admin = require("firebase-admin");

function addToUserHistory(snapData, postsId) {
  const userId = snapData.user.userId;
  const action = "ADD_POSTS";
  const resourceId = postsId;
  const message = `You add a new posts with a caption of ${snapData.caption}`;
  const createdAt = admin.firestore.Timestamp.now();
  const newEventData = {
    action,
    resourceId,
    message,
    createdAt
  };
  return admin
    .firestore()
    .doc(`history/${userId}`)
    .update({
      events: admin.firestore.FieldValue.arrayUnion(newEventData)
    });
}

module.exports = addToUserHistory;
