/** @format */
const { v1: uuidv1 } = require("uuid");

const functions = require("firebase-functions");
const admin = require("firebase-admin");
const { likeMonitor } = require("./reactive_cloud_functions/likes_function");

admin.initializeApp();

const db = admin.firestore();

exports.monitorLikesFunction = functions.firestore
  .document("likes/{docId}")
  .onCreate(async (snap, context) => {
    return likeMonitor(snap);
  });

exports.monitorCommentsFunction = functions.firestore
  .document("comments/{commentId}")
  .onCreate(async (snap, context) => {
    const id = uuidv1();

    const data = snap.data();
    const commenterId = data.commenterId;
    const postOwnerId = data.postOwnerId;
    const postId = data.postCommentId;
    const comment = data.comment;

    console.log(`${commenterId} add a comment to ${postId}`);

    return db
      .doc(`userData/${postOwnerId}/notification/${id}`)
      .set({
        id: id,
        timestamp: data.timestamp,
        commenterId: commenterId,
        postId: postId,
        type: "comments",
        comment: comment,
      })
      .then((value) => {
        console.info("monitorCommentsFunction function executed succesfully");
        console.log(`Comment added to post owner notification`);
        return { msg: "execution done" };
      })
      .catch((err) => {
        console.info("error in monitorCommentsFunction execution");
        console.log(err);
        return { msg: "error in execution" };
      });
  });

exports.admin = admin;
