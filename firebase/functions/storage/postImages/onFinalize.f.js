const functions = require("firebase-functions");

exports = module.exports = functions
  .region("asia-northeast1")
  .storage.object()
  .onFinalize(async object => {
    const admin = require("firebase-admin");
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
