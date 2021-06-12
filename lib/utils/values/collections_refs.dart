// Collections names
import 'package:cloud_firestore/cloud_firestore.dart';

const String chats = 'chats';
const String messages = 'messages';

// Collections refs
final firestore = FirebaseFirestore.instance;

final chatsCollection = firestore.collection('chats');

CollectionReference chatMessagesCollection(String chatId) {
  return chatsCollection.doc(chatId).collection(messages);
}
