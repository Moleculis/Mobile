import ChatType from "../enums/chat_type";

interface ChatModel {
    id: string,
    chatType: ChatType,
    usersUsernames: string[],
    groupId?: string,
    mutedForUserNames?: string[],
    onlineUsersNames?: string[],
}

export default ChatModel;
