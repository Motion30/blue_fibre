import 'package:blue_fibre/business_logic/auth/repo/authentication_repo.dart';
import 'package:blue_fibre/business_logic/local_db/hive_methods.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

class ServiceLocator {
  static void setup() {
    getIt.registerLazySingleton<AuthenticationRepo>(() => AuthenticationRepo());
    getIt.registerLazySingleton<HiveMethods>(() => HiveMethods());
  }
}
