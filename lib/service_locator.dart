import 'package:blue_fibre/business_logic/auth/repo/authentication_repo.dart';
import 'package:blue_fibre/business_logic/feed/repo/feed_repo.dart';
import 'package:blue_fibre/business_logic/local_db/hive_methods.dart';
import 'package:blue_fibre/utils/media_class.dart';
import 'package:blue_fibre/utils/navigator_class.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

class ServiceLocator {
  static void setup() {
    getIt.registerLazySingleton<AuthenticationRepo>(() => AuthenticationRepo());
    getIt.registerLazySingleton<HiveMethods>(() => HiveMethods());
    getIt.registerLazySingleton<NavigatorClass>(() => NavigatorClass());
    getIt.registerLazySingleton<MediaHelper>(() => MediaHelper());
    getIt.registerLazySingleton<FeedRepo>(() => FeedRepo());
  }
}
