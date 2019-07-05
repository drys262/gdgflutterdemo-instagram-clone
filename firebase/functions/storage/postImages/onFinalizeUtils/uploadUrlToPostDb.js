const admin = require("firebase-admin");
var db = admin.firestore();

function uploadUrlToPollDb(file, postId, postImageId) {
  return file.getSignedUrl({ action: "read", expires: "01-01-2030" }).then(
    urls => {
      const signedUrl = urls[0];
      const path = `posts/${postId}`;
      const data = {};
      data[`images.${postImageId}.photoUrl`] = signedUrl;
      data[`images.${postImageId}.likeCount`] = 0;
      return db.doc(path).update(data);
    },
    error => {
      console.log(error);
      console.log("ERROR HERE GET SIGNED URL");
      throw new Error("ERROR HERE GET SIGNED URL HAHAHAHA");
    }
  );
}

module.exports = uploadUrlToPollDb;
