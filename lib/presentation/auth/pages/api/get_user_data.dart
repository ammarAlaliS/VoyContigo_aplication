import 'package:firebase_auth/firebase_auth.dart';
import 'package:quickcar_aplication/data/sources/userData/auth_get_user_data_firebase_services.dart';
import 'package:quickcar_aplication/presentation/auth/bloc/state/user_state.dart';

Future<UserState?> getUserData() async {
  // Get the currently authenticated user
  final user = FirebaseAuth.instance.currentUser;
  final userService = AuthGetUserDataFirebaseServicesImpl();

  if (user != null) {
    String id = user.uid; // Get the user ID

    try {
      final result = await userService.getUserState(id);
      return result.fold(
        (exception) {
          // Log the error and return null if an error occurs
          print('Error fetching user data: ${exception.toString()}');
          return null;
        },
        (userState) {
          // Log the user details and return the user state
          return userState;
        },
      );
    } catch (e) {
      // Catch any unexpected errors
      print('Unexpected error: $e');
      return null;
    }
  } else {
    // If no user is authenticated, log an error
    print('Error: No authenticated user');
    return null;
  }
}
