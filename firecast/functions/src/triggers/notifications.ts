import * as functions from "firebase-functions";
import {Collections} from "../utils/values/collections";
import {sendPushNotification} from "../utils/notification_utils";
import NotificationModel from "../models/notification_model";

exports.onCreateNotification = functions.firestore
    .document(`${Collections.notifications}/{notificationId}`)
    .onCreate(async (snapshot, _) => {
        return sendPushNotification(snapshot.data() as NotificationModel, snapshot.id);
    });
