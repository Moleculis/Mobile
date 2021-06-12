import * as admin from "firebase-admin";
import {Collections} from "./collections";

const db = admin.firestore();

const usersCollection = db.collection(Collections.users);
const chatsCollection = db.collection(Collections.chats);
const notificationsCollection = db.collection(Collections.notifications);

export {
    usersCollection,
    chatsCollection,
    notificationsCollection,
};
