import 'package:moleculis/models/chat/message_model.dart';

class SortUtils {
  static void messages(List<MessageModel> messages) {
    messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
  }
}
