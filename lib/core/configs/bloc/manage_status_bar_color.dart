import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class StatusBarCubit extends Cubit<StatusBarState> {
  StatusBarCubit() : super(StatusBarState.transparent());

  void setLightMode() {
    emit(StatusBarState.light());
  }

  void setDarkMode() {
    emit(StatusBarState.dark());
  }
}

class StatusBarState {
  final Color statusBarColor;
  final Color systemNavigationBarColor;
  final Brightness statusBarIconBrightness;
  final Brightness systemNavigationBarIconBrightness;

  StatusBarState({
    required this.statusBarColor,
    required this.systemNavigationBarColor,
    required this.statusBarIconBrightness,
    required this.systemNavigationBarIconBrightness,
  });

  factory StatusBarState.transparent() {
    return StatusBarState(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    );
  }

  factory StatusBarState.light() {
    return StatusBarState(
      statusBarColor: Color.fromARGB(255, 219, 255, 238),
      systemNavigationBarColor: Color.fromARGB(255, 219, 255, 238),
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    );
  }

  factory StatusBarState.dark() {
    return StatusBarState(
      statusBarColor: Colors.black,
      systemNavigationBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    );
  }
}
