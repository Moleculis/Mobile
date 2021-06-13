import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:moleculis/blocs/auth/auth_bloc.dart';
import 'package:moleculis/cubits/chat_cubit/chat_cubit.dart';
import 'package:moleculis/models/chat/chat_model.dart';
import 'package:moleculis/utils/locator.dart';
import 'package:moleculis/widgets/dialogs/bottom_dialog.dart';
import 'package:moleculis/widgets/dialogs/bottom_dialog_button.dart';
import 'package:moleculis/widgets/dialogs/bottom_sheet_switch.dart';

class OptionUtils {
  static void onChatOptionTap(
    BuildContext context, {
    required ChatModel? chat,
  }) {
    final isMutedForCurrentUser = chat?.mutedForUserNames
            ?.contains(locator<AuthBloc>().state.currentUser!.username) ??
        false;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (_) {
        return BottomDialog(
          buttons: [
            if (chat != null)
              BottomDialogButton(
                text: 'mute_messages'.tr(),
                icon: Icons.notifications_none,
                action: BottomSheetSwitch(
                  value: isMutedForCurrentUser,
                  onChanged: (isMuteChat) {
                    if (isMuteChat) {
                      ChatCubit().muteAlbumChat(chat.id);
                    } else {
                      ChatCubit().unMuteAlbumChat(chat.id);
                    }
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
