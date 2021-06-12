import * as admin from "firebase-admin";

admin.initializeApp();

exports.notification_triggers = require("./triggers/notifications");
exports.chats_messages_triggers = require("./triggers/chat_message");
