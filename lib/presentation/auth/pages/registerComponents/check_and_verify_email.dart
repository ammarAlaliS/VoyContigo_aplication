import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickcar_aplication/common/widgets/buttom/basic_buttom.dart';
import 'package:quickcar_aplication/presentation/auth/bloc/cubit/user_cubit.dart';
import 'package:quickcar_aplication/presentation/auth/bloc/state/user_state.dart';
import 'package:quickcar_aplication/presentation/auth/pages/funtions/show_bottom_sheet.dart';

class CheckAndVerifyEmail extends StatelessWidget {
  const CheckAndVerifyEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        return BasicButton(
          onPressed: () {
            showBottomSheetCheck(context); 
          },
          title: "Verificar correo",
          height: 50,
          icon: Icons.mail,
        );
      },
    );
  }
}
