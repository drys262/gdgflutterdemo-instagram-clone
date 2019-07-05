const functions = require("firebase-functions");

exports = module.exports = functions
  .region("asia-northeast1")
  .storage.object()
  .onFinalize(async object => {
    const admin = require("firebase-admin");
    var db = admin.firestore();
    const settings = { timestampsInSnapshots: true };
    db.settings(settings);
    const uploadUrlToPostDb = require("./onFinalizeUtils/uploadUrlToPostDb");
    const notifyUsers = require("./onFinalizeUtils/sendNotificationToUsers");
    const filePath = object.name;
    console.log("FILE PATH HERE");
    console.log(filePath);
    const ids = filePath.split("/");
    const postId = ids[1];
    const postImageId = ids[2];
    const file = admin
      .storage()
      .bucket()
      .file(filePath);

    console.log(`post id: ${postId}`);
    console.log(`post image id: ${postImageId}`);

    await uploadUrlToPostDb(file, postId, postImageId);
    return notifyUsers(postId);
  });

// users/Ii1CGwh6noMsQg6paU7jnteamod2/polls/-LWjzK6ouIZQhF9xAlAJ/-LWjzK6p5hHz_jKqNqDc/Screenshot_20181014-072721.png

// posts/-LiwNCIrMmwNSO4cNySW/9a19abe0-9e40-11e9-bbbb-3989b9abbd5e/filename.jpg/png
