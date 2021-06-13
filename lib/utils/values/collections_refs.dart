// Collections names
import 'package:cloud_firestore/cloud_firestore.dart';

const String chats = 'chats';
const String users = 'users';
const String messages = 'messages';
const String notifications = 'notifications';

// Collections refs
final firestore = FirebaseFirestore.instance;

final chatsCollection = firestore.collection(chats);
final notificationsCollection = firestore.collection(notifications);
final usersCollection = firestore.collection(users);

CollectionReference chatMessagesCollection(String chatId) {
  return chatsCollection.doc(chatId).collection(messages);
}
