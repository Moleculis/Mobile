import * as admin from "firebase-admin";
import Timestamp = admin.firestore.Timestamp;

export type NotificationType = "newPersonalChatMessage" | "newGroupChatMessage";

interface NotificationModel {
    id: string,
    creatorUsername: string,
    receiverUsername: string,
    title: string,
    text: string,
    notificationType: NotificationType,
    createdAt: Timestamp,
    isRead: boolean,
    valueName?: string,
    valueId?: string,
}

export default NotificationModel;
