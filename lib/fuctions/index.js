// functions/src/index.ts
import * as functions from 'firebase-functions';

export const onNewPost = functions.firestore
    .document('posts/{postId}')
    .onCreate((snap, context) => {
        const post = snap.data();
        const postId = context.params.postId;

        console.log(`New post created - ID: ${postId}`);
        console.log(`Message: ${post.message}`);
        console.log(`Author: ${post.username}`);
        console.log(`Timestamp: ${post.timestamp}`);

        // Here you could add additional logic like:
        // - Sending push notifications
        // - Updating user statistics
        // - Triggering other cloud functions

        return null;
    });