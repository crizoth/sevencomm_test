import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dev_test/core/app_colors.dart';
import 'package:flutter_dev_test/modules/login/presentation/cubits/login_cubit.dart';
import 'package:flutter_dev_test/modules/login/presentation/cubits/recover_cubit.dart';
import 'package:flutter_dev_test/modules/login/presentation/pages/home_page.dart';
import 'package:flutter_dev_test/modules/login/presentation/pages/login_page.dart';
import 'package:flutter_dev_test/modules/login/presentation/pages/recover_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (_) => LoginCubit(),
        ),
        BlocProvider<RecoverCubit>(
          create: (context) {
            final loginCubit = context.read<LoginCubit>();
            return RecoverCubit(
              userName: loginCubit.userName ?? '',
              password: loginCubit.password ?? '',
            );
          },
        ),
      ],
      child: MaterialApp(
        title: 'Dev Flutter Test',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginPage(),
          '/recover_secret': (context) => RecoverPage(),
          '/home': (context) => HomePage(),
        },
      ),
    );
  }
}
