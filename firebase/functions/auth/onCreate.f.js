const functions = require("firebase-functions");
// my files
const addUserDoc = require("./onCreateUtils/addUserDoc");

exports = module.exports = functions
  .region("asia-northeast1")
  .auth.user()
  .onCreate(async user => {
    console.log("ON CREATE USER HERE");
    console.log(user);
    var sendgridApiKey = functions.config().sendgrid.api_key;
    const sgMail = require("@sendgrid/mail");
    sgMail.setApiKey(sendgridApiKey);
    const msg = {
      to: user.email,
      from: "DK Chavez <dkchavez0987@gmail.com>",
      templateId: "d-5ba7c61e57ce4366be052fd525d3640d",
      dynamicTemplateData: {
        username: user.displayName
      }
    };
    console.log("MSG HERE");
    console.log(msg);
    await sgMail.send(msg, (error, body) => {
      if (error) {
        console.log("ERROR HERE");
        console.log(error);
      } else {
        console.log("DONE SENDING EMAIL");
        console.log(body);
      }
    });
    return addUserDoc(user);
  });
