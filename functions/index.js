/** @format */

const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

const db = admin.firestore();

exports.monitorLikesFunction = functions.firestore
  .document("likes/{docId}")
  .onCreate(async (snap, context) => {
    const data = snap.data();
    const likerUid = data.likerId;
    console.log(`post ${data.postLikedId} was liked by user: ${likerUid}`);

    //   db.document()
  });
