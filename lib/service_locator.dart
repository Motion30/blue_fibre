import 'package:blue_fibre/business_logic/auth/repo/authentication_repo.dart';
import 'package:blue_fibre/business_logic/feed/repo/comment_repo.dart';
import 'package:blue_fibre/business_logic/feed/repo/get_feeds_repo.dart';
import 'package:blue_fibre/business_logic/feed/repo/update_post_details_repo.dart';
import 'package:blue_fibre/business_logic/feed/repo/upload_feed_repo.dart';
import 'package:blue_fibre/business_logic/local_db/hive_methods.dart';
import 'package:blue_fibre/utils/media_class.dart';
import 'package:blue_fibre/utils/navigator_class.dart';
import 'package:get_it/get_it.dart';

import 'business_logic/cloud_messaging/init_notification_class.dart';
import 'business_logic/notification/repo/notification_repo.dart';

final GetIt getIt = GetIt.instance;

class ServiceLocator {
  static void setup() {
    getIt.registerLazySingleton<AuthenticationRepo>(() => AuthenticationRepo());
    getIt.registerLazySingleton<HiveMethods>(() => HiveMethods());
    getIt.registerLazySingleton<NavigatorClass>(() => NavigatorClass());
    getIt.registerLazySingleton<MediaHelper>(() => MediaHelper());
    getIt.registerLazySingleton<UploadFeedRepo>(() => UploadFeedRepo());
    getIt.registerLazySingleton<GetFeedRepo>(() => GetFeedRepo());
    getIt.registerLazySingleton<UpdatePostInfoRepo>(() => UpdatePostInfoRepo());
    getIt.registerLazySingleton<CommentRepo>(() => CommentRepo());
    getIt.registerLazySingleton<NotificationClass>(() => NotificationClass());
    getIt.registerLazySingleton<NotificationRepo>(() => NotificationRepo());
  }
}
