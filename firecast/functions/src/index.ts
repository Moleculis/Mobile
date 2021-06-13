import * as admin from "firebase-admin";

admin.initializeApp();

exports.notification_triggers = require("./triggers/notifications");
exports.chats_messages_triggers = require("./triggers/chat_message");
exports.rtbd_chat_presence_triggers = require("./triggers/rtdb/chat_presence");
