import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {ChatsCollections, Collections} from "../utils/values/collections";
import {
    chatsCollection, notificationsCollection,
    usersCollection
} from "../utils/values/collection_references";
import UserModel from "../models/user_model";
import MessageModel from "../models/chat/message_model";
import ChatModel from "../models/chat/chat_model";
import NotificationModel from "../models/notification_model";
import ChatType from "../models/enums/chat_type";
import DocumentSnapshot = admin.firestore.DocumentSnapshot;
import WriteBatch = admin.firestore.WriteBatch;
import FieldValue = admin.firestore.FieldValue;

const db = admin.firestore();

exports.onCreateChatMessage = functions.firestore
    .document(`${Collections.chats}/{chatId}/${ChatsCollections.messages}/{messageId}`)
    .onCreate(async (snapshot, context) => {
        const chatId: string = context.params.chatId;
        const messageModel: MessageModel = snapshot.data() as MessageModel;

        const creatorUsername: string = messageModel.creatorUsername;

        const chatReference = chatsCollection.doc(chatId);

        const dataSnapshots: DocumentSnapshot[] = await Promise.all([
            chatReference.get(),
            usersCollection.doc(creatorUsername).get()
        ]);

        const chatModel: ChatModel = dataSnapshots[0].data() as ChatModel;
        const authUser: UserModel = dataSnapshots[1].data() as UserModel;

        const chatUsersUsernames: string[] = chatModel.usersUsernames;
        const chatMutedForUserNames: string[] = chatModel.mutedForUserNames ?? [];
        const onlineUsersNames: string[] = chatModel.onlineUsersNames ?? [];

        const activeUsersUsernames = chatUsersUsernames.filter((id: string) =>
            !chatMutedForUserNames.includes(id) && !onlineUsersNames.includes(id)
        );

        const requestsPromises: Promise<unknown>[] = [];

        const isGroupChat: boolean = chatModel.chatType == ChatType.group;

        if (activeUsersUsernames.length !== 0) {
            const notificationsBatch: WriteBatch = db.batch();
            activeUsersUsernames.map((userName: string) => {
                return {
                    creatorUsername: authUser.username,
                    title: authUser.username,
                    receiverUsername: userName,
                    notificationType: isGroupChat ? "newGroupChatMessage" : "newPersonalChatMessage",
                    text: isGroupChat ? "New message in the group chat" : `New message from ${authUser.username}`,
                    createdAt: FieldValue.serverTimestamp(),
                    valueId: messageModel.chatId,
                    isRead: false,
                } as NotificationModel;
            }).forEach((notification) => {
                if (notification.receiverUsername !== creatorUsername) {
                    const notificationRef = notificationsCollection.doc();
                    notification.id = notificationRef.id;
                    notificationsBatch.set(notificationRef, notification);
                }
            });
            requestsPromises.push(notificationsBatch.commit());
        }

        return Promise.all(requestsPromises);
    });
