const functions = require("firebase-functions");

function sendWelcomeEmail(user) {
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
  return sgMail.send(msg, (error, body) => {
    if (error) {
      console.log("ERROR HERE");
      console.log(error);
    } else {
      console.log("DONE SENDING EMAIL");
      console.log(body);
    }
  });
}

module.exports = sendWelcomeEmail;
