import 'package:blue_fibre/business_logic/auth/repo/authentication_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

final Provider<AuthenticationRepo> loginProvider =
    Provider<AuthenticationRepo>((ProviderReference ref) {
  return GetIt.instance.get<AuthenticationRepo>();
});
