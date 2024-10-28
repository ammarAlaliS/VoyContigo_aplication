import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickcar_aplication/core/configs/bloc/manage_status_bar_color.dart';
import 'package:quickcar_aplication/presentation/choice_mode/pages/choice_mode.dart';
import 'package:quickcar_aplication/presentation/root/pages/root.dart';
import 'package:quickcar_aplication/presentation/widgets/logo.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  static const int splashDuration = 2;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 100), () {
      context.read<StatusBarCubit>().setLightMode();
    });

    redirect();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<StatusBarCubit, StatusBarState>(
      listener: (context, state) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: state.statusBarColor,
          systemNavigationBarColor: state.systemNavigationBarColor,
          statusBarIconBrightness: state.statusBarIconBrightness,
          systemNavigationBarIconBrightness: state.systemNavigationBarIconBrightness,
        ));
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 219, 255, 238),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Logo(), // Asegúrate de que Logo() esté definido
                  ),
                ),
                SizedBox(height: 40),
                CircularProgressIndicator(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black.withOpacity(0.7),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> redirect() async {
    await Future.delayed(Duration(seconds: splashDuration));

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        await user.getIdToken(true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context) => RootPage()),
        );
      } catch (e) {
        await FirebaseAuth.instance.signOut();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context) => ChoiceMode()),
        );
      }
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext context) => ChoiceMode()),
      );
    }
  }
}
