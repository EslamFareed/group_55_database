import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  static AuthCubit get(context) => BlocProvider.of(context);

  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  void login(String email, String pass) async {
    emit(LoadingLoginState());
    try {
      var userData =
          await auth.signInWithEmailAndPassword(email: email, password: pass);

      if (userData.user != null) {
        emit(SuccessLoginState());
      } else {
        emit(ErrorLoginState());
      }
    } catch (e) {
      print(e.toString());
      emit(ErrorLoginState());
    }
  }

  void createAccount(String name, String email, String pass) async {
    emit(LoadingCreateAccountState());
    try {
      var userData = await auth.createUserWithEmailAndPassword(
          email: email, password: pass);

      if (userData.user != null) {
        String? token = await FirebaseMessaging.instance.getToken();

        await firestore.collection("users").doc(userData.user!.uid).set({
          "email": email,
          "name": name,
          "token": token,
        });
        emit(SuccessCreateAccountState());
      } else {
        emit(ErrorCreateAccountState());
      }
    } catch (e) {
      print(e.toString());
      emit(ErrorCreateAccountState());
    }
  }
}
