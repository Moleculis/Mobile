import 'package:get_it/get_it.dart';
import 'package:moleculis/blocs/auth/auth_bloc.dart';
import 'package:moleculis/blocs/notifications/notifications_bloc.dart';
import 'package:moleculis/services/apis/auth_service.dart';
import 'package:moleculis/services/apis/chats_service.dart';
import 'package:moleculis/services/apis/events_service.dart';
import 'package:moleculis/services/apis/groups_service.dart';
import 'package:moleculis/services/apis/notifications_service.dart';
import 'package:moleculis/services/apis/user_service.dart';
import 'package:moleculis/services/auth_service_impl.dart';
import 'package:moleculis/services/chats_service_impl.dart';
import 'package:moleculis/services/events_service_impl.dart';
import 'package:moleculis/services/groups_service_impl.dart';
import 'package:moleculis/services/http_helper.dart';
import 'package:moleculis/services/notifications_service_impl.dart';
import 'package:moleculis/services/user_service_impl.dart';
import 'package:moleculis/storage/shared_pref_manager.dart';

final GetIt locator = GetIt.instance;

void setupServiceLocator() {
  // Managers
  locator.registerSingleton<SharedPrefManager>(SharedPrefManager());

  locator.registerSingleton<HttpHelper>(HttpHelper());

  // Services
  locator.registerSingleton<UserService>(UserServiceImpl());
  locator.registerSingleton<AuthService>(AuthServiceImpl());
  locator.registerSingleton<EventsService>(EventsServiceImpl());
  locator.registerSingleton<GroupsService>(GroupsServiceImpl());
  locator.registerSingleton<ChatsService>(ChatsServiceImpl());
  locator.registerSingleton<NotificationsService>(NotificationsServiceImpl());

  // Blocs (must be at the bottom of the setupServiceLocator)
  locator.registerSingleton<AuthBloc>(AuthBloc());
  locator.registerSingleton<NotificationsBloc>(NotificationsBloc());
}
