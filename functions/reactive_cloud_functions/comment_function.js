/** @format */

const { v1: uuidv1 } = require("uuid");
const firebase = require("firebase");

async function commentMonitor(admin_sdk, snap) {
  const id = uuidv1();
  const data = snap.data();

  const commenterId = data.commenterId;
  const postOwnerId = data.postOwnerId;
  const comment = data.comment;
  console.log(
    `user ${commenterId} added a comment to post ${data.postCommentId}`
  );

  const notificationData = {
    id: id,
    timestamp: data.timestamp,
    commenterId: commenterId,
    postCommentId: data.postCommentId,
    type: "comment",
    read: false,
    comment: comment,
  };

  await setNotificationData(admin_sdk, postOwnerId, id, notificationData);

  // await incrementNotificationCount(admin_sdk, postOwnerId);

  return sendNotificationToUser(
    admin_sdk,
    postOwnerId,
    commenterId,
    comment,
    data.postCommentId
  );
}

async function setNotificationData(
  admin_sdk,
  postOwnerId,
  id,
  notificationData
) {
  await admin_sdk
    .firestore()
    .doc(`userData/${postOwnerId}/notification/${id}`)
    .set(notificationData)
    .then((value) => {
      console.info(
        "save commenter data to post owner collection function executed succesfully"
      );
      console.log(`comment added to post owner notification`);
      return {
        msg:
          "save commenter data to post owner collection function executed succesfully",
      };
    })
    .catch((err) => {
      console.info(
        "error in save commenter data to post owner colloection function"
      );
      console.log(err);
      return {
        msg: "error in save commenter data to post owner colloection function",
      };
    });
}

async function incrementNotificationCount(admin_sdk, postOwnerId) {
  await admin_sdk
    .firestore()
    .doc(`userData/${postOwnerId}`)
    .set(
      { notificationCount: firebase.firestore.FieldValue.increment(1) },
      { merge: true }
    )
    .then((value) => {
      console.info(
        "increment notification count function executed succesfully"
      );
      console.log(`increment notification count to post owner notification`);
      return {
        msg: "increment notification count function executed succesfully",
      };
    })
    .catch((err) => {
      console.info("error in increment notification count function");
      console.log(err);
      return {
        msg: "error in increment notification count function",
      };
    });
}

async function getcommenterDetails(admin_sdk, commenterId) {
  const snapshot = await admin_sdk
    .firestore()
    .doc(`userData/${commenterId}`)
    .get()
    .then((value) => {
      console.info("function executed succesfully: got commenter user name");
      console.log(value);
      return value;
    })
    .catch((error) => {
      console.info("error in execution: unable to get commenter name");
      console.log(error);
      return { msg: "error in execution: unable to get commenter name" };
    });

  return snapshot.data().fullName;
}

async function sendNotificationToUser(
  admin_sdk,
  postOwnerId,
  commenterId,
  comment,
  postCommentId
) {
  const userName = await getcommenterDetails(admin_sdk, commenterId);

  const payload = {
    notification: {
      title: "You got a new Comment!",
      body: `${userName} added a comment - ${comment}`,
    },
    data: {
      data_to_send: "msg_from_the_cloud",
      click_action: "FLUTTER_NOTIFICATION_CLICK",
      type: "comment",
      postLikedId: postCommentId,
    },
  };

  const options = {
    priority: "high",
    timeToLive: 60 * 60 * 24,
  };

  return admin_sdk
    .messaging()
    .sendToTopic(`${postOwnerId}`, payload, options)
    .then((value) => {
      console.info("function executed succesfully: sent notification");
      return { msg: "function executed succesfully" };
    })
    .catch((error) => {
      console.info("error in execution: notification not sent");
      console.log(error);
      return { msg: "error in execution: notification not sent" };
    });
}

exports.commentMonitor = commentMonitor;
