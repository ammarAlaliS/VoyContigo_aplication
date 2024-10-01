// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quickcar_aplication/core/configs/theme/app_theme.dart';
import 'package:quickcar_aplication/firebase_options.dart';
import 'package:quickcar_aplication/presentation/auth/bloc/cubit/user_cubit.dart';
import 'package:quickcar_aplication/presentation/choice_mode/bloc/theme_cubit.dart';
import 'package:quickcar_aplication/presentation/pages/splash.dart';
import 'package:quickcar_aplication/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await initializeDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => UserCubit()), 
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, mode) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'QuickCar',
          themeMode: mode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: SplashPage(),
        ),
      ),
    );
  }
}
