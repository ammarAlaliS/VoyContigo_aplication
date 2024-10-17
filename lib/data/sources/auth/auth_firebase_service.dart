import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:quickcar_aplication/data/models/auth/create_user_request.dart';
import 'package:quickcar_aplication/data/models/auth/sign_in_user_request.dart';
import 'package:quickcar_aplication/data/sources/utils/is_valid_email.dart';
import 'package:quickcar_aplication/domain/handleException/sign_in_exception.dart';

abstract class AuthFirebaseService {
  Future<Either<Exception, String>> signup(CreateUserRequest createUserRequest);
  Future<Either<Exception, String>> uploadImages(String folder, File imageFile);
  Future<Either<SignInException, String>> signin(CreateSignInUserRequest createSignInUserRequest);
  Future<Either<Exception, void>> signout();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {

  @override
  Future<Either<Exception, String>> signup(CreateUserRequest createUserRequest) async {
    try {
      // Validar si el correo y la contraseña cumplen con las reglas
      if (!isValidEmail(createUserRequest.email)) {
        return Left(Exception('El correo electrónico no es válido.'));
      }

      if (createUserRequest.password.length < 6) {
        return Left(Exception('La contraseña es demasiado corta.'));
      }

      // Crear usuario en Firebase Auth
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserRequest.email,
        password: createUserRequest.password,
      );

      // Enviar correo de verificación
      await userCredential.user?.sendEmailVerification();

      // Informar al usuario que debe verificar su correo electrónico
      return const Right("Se ha enviado un enlace de verificación a tu correo. Por favor, verifica tu correo. Cuenta creada exitosamente");
      
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'weak-password':
          message = 'La contraseña es muy débil.';
          break;
        case 'email-already-in-use':
          message = 'El correo electrónico ya está en uso.';
          break;
        default:
          message = 'Error en la autenticación: ${e.message}';
      }
      return Left(Exception(message));
    } catch (error) {
      return Left(Exception("Error inesperado: ${error.toString()}"));
    }
  }

  // Método para verificar el correo electrónico
  Future<Either<Exception, String>> verifyEmail(CreateUserRequest createUserRequest) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Verificar si el correo electrónico ha sido verificado
        await user.reload(); // Asegúrate de que la información del usuario esté actualizada
        if (user.emailVerified) {
          // Si el correo está verificado, crear documento en Firestore
          await createUserDocument(user, createUserRequest);
          return const Right("Usuario creado exitosamente.");
        } else {
          return Left(Exception("El correo electrónico no está verificado. Por favor verifica tu correo."));
        }
      } else {
        return Left(Exception("No hay usuario autenticado."));
      }
    } catch (error) {
      return Left(Exception("Error al verificar el correo: ${error.toString()}"));
    }
  }

  // Método para crear el documento en Firestore
  Future<void> createUserDocument(User user, CreateUserRequest createUserRequest) async {
    final firestore = FirebaseFirestore.instance;

    await firestore.collection('users').doc(user.uid).set({
      'firstName': createUserRequest.name,
      'lastName': createUserRequest.lastName,
      'email': createUserRequest.email,
      'profileImgUrl': createUserRequest.profileImgUrl.isNotEmpty 
          ? createUserRequest.profileImgUrl 
          : 'https://firebasestorage.googleapis.com/v0/b/quickarapp.appspot.com/o/profile_images%2Fuser.png?alt=media&token=3662df30-188b-46b9-9bf2-8dd294efda10',  
      'presentationImgUrl': createUserRequest.presentationImgUrl.isNotEmpty 
          ? createUserRequest.presentationImgUrl 
          : 'https://firebasestorage.googleapis.com/v0/b/quickarapp.appspot.com/o/portal_images%2Fhyundai-motor-group-bfLoXCRijvQ-unsplash.jpg?alt=media&token=519ae5ac-a8cc-432d-b0bc-5435801c8629',
      'userDescription': createUserRequest.userDescription,
      'role': createUserRequest.role.name,
      'isActive': true,
      'isVerified': true,
    });
  }

  @override
  Future<Either<Exception, String>> uploadImages(String folder, File imageFile) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child(folder)
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

      // Subir la imagen
      await ref.putFile(imageFile);

      // Obtener la URL de descarga
      final imageUrl = await ref.getDownloadURL();
      return Right(imageUrl);
    } catch (e) {
      return Left(Exception("Error al subir la imagen: $e"));
    }
  }

  @override
  Future<Either<SignInException, String>> signin(CreateSignInUserRequest createSignInUserRequest) async {
    try {
      // Validar el formato del correo antes de realizar el inicio de sesión
      if (!isValidEmail(createSignInUserRequest.email)) {
        return Left(SignInException('El correo electrónico no es válido.'));
      }
       
      // Intentar la autenticación con Firebase
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: createSignInUserRequest.email,
          password: createSignInUserRequest.password);

      return const Right("Inicio de sesión exitoso");
  
    } on FirebaseAuthException catch (e) {
      // Manejo de errores específicos de Firebase
      return Left(SignInException(_handleSignInException(e)));
    } on PlatformException catch (e) {
      return Left(SignInException('Error de la plataforma: ${e.message}'));
    } catch (e) {
      return Left(SignInException('Error desconocido: ${e.toString()}'));
    }
  }

  // Método para manejar excepciones de inicio de sesión
  String _handleSignInException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No existe un usuario con este correo electrónico.';
      case 'wrong-password':
        return 'La contraseña es incorrecta.';
      case 'invalid-email':
        return 'El correo electrónico no es válido.';
      case 'too-many-requests':
        return 'Demasiados intentos fallidos. Intenta de nuevo más tarde.';
      case 'user-disabled':
        return 'El usuario ha sido deshabilitado.';
      case 'invalid-credential':
        return 'Las credenciales proporcionadas son incorrectas o han expirado.';
      default:
        return 'Ha ocurrido un error inesperado. Intenta de nuevo más tarde.';
    }
  }

  @override
  Future<Either<Exception, void>> signout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return const Right(null);
    } catch (e) {
      return Left(Exception("Error al cerrar sesión: $e"));
    }
  }
}
