import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import FieldValue = admin.firestore.FieldValue;
import {chatsCollection} from "../../utils/values/collection_references";

exports.onChatPresenceChange = functions.database
    .ref(`/chatsUsersPresences/{chatId}/{userUsername}/presence`)
    .onUpdate(async (change, context) => {
        const isOnline = change.after.val();

        const chatId: string = context.params.chatId;
        const userUsername: string = context.params.userUsername;

        return chatsCollection.doc(chatId).update({
            'onlineUsersNames': isOnline
                ? FieldValue.arrayUnion(userUsername)
                : FieldValue.arrayRemove(userUsername),
        });
    });
