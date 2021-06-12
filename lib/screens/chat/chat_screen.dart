import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moleculis/blocs/auth/auth_bloc.dart';
import 'package:moleculis/cubits/chat_cubit/chat_cubit.dart';
import 'package:moleculis/cubits/chat_cubit/chat_state.dart';
import 'package:moleculis/models/chat/message_model.dart';
import 'package:moleculis/models/enums/chat_type.dart';
import 'package:moleculis/models/group.dart';
import 'package:moleculis/models/user/user_small.dart';
import 'package:moleculis/screens/chat/widgets/messages_group_widget.dart';
import 'package:moleculis/screens/chat/widgets/no_messages_view.dart';
import 'package:moleculis/utils/chat_utils.dart';
import 'package:moleculis/utils/locator.dart';
import 'package:moleculis/utils/widget_utils.dart';
import 'package:moleculis/widgets/message_input.dart';

class ChatScreen extends StatefulWidget {
  final Group? group;
  final UserSmall? user;

  const ChatScreen({
    Key? key,
    this.group,
    this.user,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();
  final messageFocus = FocusNode();
  late final ChatCubit chatCubit;
  late final UserSmall? user;
  late final Group? group;
  late final ChatType chatType;
  late final bool isGroup;

  late final String chatId;

  late final List<UserSmall> members;
  late final List<String> usersUsernames;

  @override
  void initState() {
    user = widget.user;
    group = widget.group;
    chatType = user == null ? ChatType.group : ChatType.personal;
    isGroup = chatType == ChatType.group;

    if (isGroup) {
      chatId = ChatUtils.getGroupChatId(group!);
      members = group!.admins..addAll(group!.users);
    } else {
      chatId = ChatUtils.getUserChatId(user!);
      final currentUser = locator<AuthBloc>().state.currentUser!;
      members = [UserSmall.fromUser(currentUser), user!]
        ..sort((a, b) => a.username.compareTo(b.username));
    }
    usersUsernames = members.map((e) => e.username).toList();
    chatCubit = ChatCubit();
    chatCubit.initChatStream(chatId: chatId);
    super.initState();
  }

  @override
  void dispose() {
    chatCubit.close();
    super.dispose();
  }

  void unFocus() => FocusScope.of(context).unfocus();

  void onDeleteMessage(MessageModel message) {
    chatCubit.deleteMessage(chatId: chatId, message: message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar() as PreferredSizeWidget?,
      body: BlocBuilder<ChatCubit, ChatState>(
        bloc: chatCubit,
        builder: (_, state) {
          if (state.isLoading) {
            return Center(child: WidgetUtils.loadingIndicator(context));
          }
          final animateTextInput =
              !messageFocus.hasFocus && (state.messagesGroups?.isEmpty ?? true);
          final bool chatCreated = state.chat != null;
          return Stack(
            children: [
              GestureDetector(
                onTap: unFocus,
                behavior: HitTestBehavior.opaque,
                onPanDown: (_) => unFocus(),
              ),
              SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    messagesListWidget(state),
                    MessageInput(
                      animate: animateTextInput,
                      focusNode: messageFocus,
                      controller: messageController,
                      onSend: () => onSendMessage(chatCreated: chatCreated),
                      onChanged: (text) => setState(() {}),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void onSendMessage({required bool chatCreated}) {
    if (messageController.text.isNotEmpty) {
      final currentUserUsername =
          locator<AuthBloc>().state.currentUser!.username;
      chatCubit.sendMessage(
        chatId: chatId,
        usersUsernames: usersUsernames,
        message: MessageModel.sendMessage(
          creatorId: currentUserUsername,
          text: messageController.text,
          chatId: chatId,
        ),
        chatType: chatType,
        chatCreated: chatCreated,
      );
      messageController.clear();
      FocusScope.of(context).requestFocus(messageFocus);
    }
  }

  Widget messagesListWidget(ChatState chatState) {
    if (chatState.messagesGroups?.isEmpty ?? true) {
      return Expanded(child: NoMessagesView());
    }
    return Flexible(
      child: GestureDetector(
        onTap: unFocus,
        behavior: HitTestBehavior.opaque,
        onPanDown: (_) => unFocus(),
        child: ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(
            horizontal: 19.0,
            vertical: 10.0,
          ),
          reverse: true,
          primary: false,
          itemCount: chatState.messagesGroups!.length,
          itemBuilder: (_, index) {
            final messagesList = chatState.messagesGroups![index];
            final messageCreator = members.firstWhere(
              (element) => element.username == messagesList.groupCreatorId,
            );
            return MessagesGroupWidget(
              messageCreator: messageCreator,
              messagesGroup: messagesList,
              onDelete: onDeleteMessage,
            );
          },
        ),
      ),
    );
  }

  Widget appBar() {
    return WidgetUtils.simpleAppBar(
      context,
      centerTitle: true,
      leading: WidgetUtils.backButton(context),
      title: Text(
        user?.displayName ?? group?.title ?? '',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
