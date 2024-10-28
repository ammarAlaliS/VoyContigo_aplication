import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickcar_aplication/core/configs/bloc/scroll_cubit.dart';
import 'package:quickcar_aplication/presentation/screen/pages/home/components/custom_scroll.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScrollControllerCubit(),
      child: const Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        body: ScrollableContent(
          child:  Center(child: Text('Message Page')),
        ),
      ),
    );
  }
}