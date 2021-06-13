import * as admin from "firebase-admin";
import NotificationModel from "../models/notification_model";
import {usersCollection} from "./values/collection_references";

export const sendPushNotification = async (
    notification: NotificationModel,
    notificationId: string,
): Promise<void> => {
    const userReceiver = await usersCollection.doc(notification.receiverUsername).get();
    const tokens: string[] = userReceiver?.data()?.tokens ?? [];
    const filteredTokens = tokens.filter((element) => element !== null);
    const payload = {
        notification: {
            "title": notification.title,
            "body": notification.text,
            "priority": "high",
            "sound": "default"
        },
        data: {
            "title": notification.title,
            "text": notification.text,
            "click_action": "FLUTTER_NOTIFICATION_CLICK",
            "creatorUsername": notification.creatorUsername,
            "notificationId": notificationId,
            "notificationType": notification.notificationType,
        },
    };
    try {
        const response = await admin.messaging().sendToDevice(filteredTokens, payload);
        console.log('Notification send success:', response);
    } catch (error) {
        console.log('Error sending notification:', error);
    }
}
