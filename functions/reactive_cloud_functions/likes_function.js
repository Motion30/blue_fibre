/** @format */

const { v1: uuidv1 } = require("uuid");
const firebase = require("firebase");

async function likeMonitor(admin_sdk, snap) {
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
    read: false,
  };

  await setNotificationData(admin_sdk, postOwnerId, id, notificationData);
  // await incrementNotificationCount(admin_sdk, postOwnerId);
  return sendNotificationToUser(
    admin_sdk,
    postOwnerId,
    likerUid,
    data.postLikedId
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
        "increment notification count function executed succesfully"
      );
      console.log(`like added to post owner notification`);
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

async function incrementNotificationCount(admin_sdk, postOwnerId) {
  await admin_sdk
    .firestore()
    .doc(`userData/${postOwnerId}`)
    .update({ notificationCount: firebase.firestore.FieldValue.increment(1) })
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

async function getLikerDetails(admin_sdk, likerId) {
  const snapshot = await admin_sdk
    .firestore()
    .doc(`userData/${likerId}`)
    .get()
    .then((value) => {
      console.info("function executed succesfully: got liker user name");
      console.log(value);
      return value;
    })
    .catch((error) => {
      console.info("error in execution: unable to get liker name");
      console.log(error);
      return { msg: "error in execution: unable to get liker name" };
    });

  return snapshot.data().fullName;
}

async function sendNotificationToUser(
  admin_sdk,
  postOwnerId,
  likerId,
  postLikedId
) {
  const userName = await getLikerDetails(admin_sdk, likerId);

  const payload = {
    notification: {
      title: "You got a new like!",
      body: `${userName} Liked your post`,
    },
    data: {
      data_to_send: "msg_from_the_cloud",
      click_action: "FLUTTER_NOTIFICATION_CLICK",
      type: "likes",
      postLikedId: postLikedId,
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

exports.likeMonitor = likeMonitor;
