/** @format */

const { v1: uuidv1 } = require("uuid");
const { admin } = require("..");
const db_likes = admin.firestore();

async function likeMonitor(snap) {
  const id = uuidv1();
  const data = snap.data();

  const likerUid = data.likerId;
  const postOwnerId = data.postOwnerId;
  console.log(`post ${data.postLikedId} was liked by user: ${likerUid}`);

  const notificationData = {
    id: id,
    timestamp: data.timestamp,
    likerId: likerUid,
    postLikedId: data.postLikedId,
    type: "likes",
  };

  await setNotificationData(postOwnerId, id, notificationData);
  return setNotificationData(postOwnerId);
}

async function setNotificationData(postOwnerId, id, notificationData) {
  await db_likes
    .doc(`userData/${postOwnerId}/notification/${id}`)
    .set(notificationData)
    .then((value) => {
      console.info("monitorLikesFunction function executed succesfully");
      console.log(`like added to post owner notification`);
      return { msg: "function executed succesfully" };
    })
    .catch((err) => {
      console.info("error in monitorLikesFunction execution");
      console.log(err);
      return { msg: "error in execution" };
    });
}

async function getLikerDetails(likerId) {
  const snapshot = await db_likes.firestore
    .doc(`userData/${likerId}`)
    .get()
    .then((value) => {
      console.info("function executed succesfully: got liker user name");
      return { msg: "function executed succesfully" };
    })
    .catch((error) => {
      console.info("error in execution: unable to get liker name");
      console.log(error);
      return { msg: "error in execution" };
    });

  return snapshot.fullName;
}

async function sendNotificationToUser(postOwnerId) {
  const userName = await getLikerDetails(likerId);

  const payload = {
    notification: {
      title: "The title of the notification",
      body: data["your_param_sent_from_the_client"],
    },
    data: {
      data_to_send: "msg_from_the_cloud",
      click_action: "FLUTTER_NOTIFICATION_CLICK",
    },
    priority: "high",
  };

  admin
    .messaging()
    .sendToTopic(`${postOwnerId}`, payload)
    .then((value) => {
      console.info("function executed succesfully: sent notification");
      return { msg: "function executed succesfully" };
    })
    .catch((error) => {
      console.info("error in execution: notification not sent");
      console.log(error);
      return { msg: "error in execution" };
    });
}

exports.likeMonitor = likeMonitor;
