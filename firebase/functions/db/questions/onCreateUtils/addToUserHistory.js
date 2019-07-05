const admin = require("firebase-admin");

function addToUserHistory(snapData, questionId) {
  const userId = snapData.user.userId;
  const action = "ADD_QUESTIONS";
  const resourceId = questionId;
  const message = `You add a new question ${snapData.questions}`;
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
