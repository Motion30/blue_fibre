import 'package:blue_fibre/bloc_list.dart';
import 'package:blue_fibre/business_logic/auth/model/login_user_model.dart';
import 'package:blue_fibre/utils/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'business_logic/auth/repo/authentication_repo.dart';

class BlueFiberApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocList(),
      child: StreamProvider<LoginUserModel>.value(
        value: AuthenticationRepo().userStream,
        child: MaterialApp(
          title: 'Blue Fiber',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            backgroundColor: Colors.white,
            scaffoldBackgroundColor: Colors.white,
            primaryColor: const Color.fromRGBO(0, 125, 239, 1),
          ),
          onGenerateRoute: AppRouter.generateRoute,
          initialRoute: '/',
        ),
      ),
    );
  }
}
