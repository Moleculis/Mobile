import {firestore} from "firebase-admin/lib/firestore";
import Timestamp = firestore.Timestamp;

interface MessageModel {
    id: string,
    creatorUsername: string,
    text: string,
    createdAt: Timestamp,
    chatId: string,
    updatedAt: Timestamp,
    isDeleted: boolean,
}

export default MessageModel;
