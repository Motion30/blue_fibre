/** @format */
const { v1: uuidv1 } = require("uuid");

const functions = require("firebase-functions");
const admin = require("firebase-admin");
const { likeMonitor } = require("./reactive_cloud_functions/likes_function");
const {
  commentMonitor,
} = require("./reactive_cloud_functions/comment_function");

admin.initializeApp();

// const db = admin.firestore();

exports.monitorLikesFunction = functions.firestore
  .document("likes/{docId}")
  .onCreate(async (snap, context) => {
    return likeMonitor(admin, snap);
  });

exports.monitorCommentsFunction = functions.firestore
  .document("comments/{commentId}")
  .onCreate(async (snap, context) => {
    return commentMonitor(admin, snap);
  });
