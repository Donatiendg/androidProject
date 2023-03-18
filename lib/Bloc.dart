import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'FireClass.dart';

abstract class UserEvent{}

class ConnectionUserEvent extends UserEvent{
  final String mail;
  final String password;

  ConnectionUserEvent(this.mail, this.password);
}

class RegisterUserEvent extends UserEvent{
  final String name;
  final String mail;
  final String password;

  RegisterUserEvent(this.name, this.mail, this.password);
}

class DeconectionUserEvent extends UserEvent{}

class ForgottenUserEvent extends UserEvent{
  final String mail;

  ForgottenUserEvent(this.mail);
}

class RegisterPageEvent extends UserEvent{}

class ForgottenPageEvent extends UserEvent{}

class HomePageEvent extends UserEvent{}

class UserState{
  late final Interface userState;
  UserState(this.userState);
}

enum Interface{
  connectionPage,
  registerPage,
  forgottenPage,
  homePage
}

class UserBloc extends Bloc<UserEvent,UserState> {

  Interface userState = Interface.connectionPage;

  UserBloc() : super(UserState(Interface.connectionPage)) {
    on<ConnectionUserEvent>(_connectionUser);
    on<RegisterUserEvent>(_registerUser);
    on<DeconectionUserEvent>(_deconectionUser);
    on<ForgottenUserEvent>(_forgottenUser);
    on<RegisterPageEvent>(_registerPage);
    on<ForgottenPageEvent>(_forgottenPage);
    on<HomePageEvent>(_homePage);
  }

  Future<void> _connectionUser(event, emit) async {
    try {
      User? user = await RegisterAuthentification.signInUsingEmailPassword(
        email: event.mail,
        password: event.password,
      );
      if (user != null) {
        userState = Interface.homePage;
        emit(UserState(userState));
      } else {
        print("L'authentification a échoué. Veuillez vérifier vos identifiants.");
      }
    } catch (e) {
      print("Une erreur est survenue lors de l'authentification. Veuillez réessayer plus tard.");
    }
  }

  Future<void> _registerUser(event, emit) async {
    try {
      User? user = await RegisterAuthentification.registerUsingEmailPassword(
          name: event.name,
          email: event.mail,
          password: event.password);
      if (user != null) {
        DatabaseReference ref = FirebaseDatabase.instance.ref("users");

        await ref.update({
          "ID": user.uid,
          "123/age": 19,
          "123/address/line1": "1 Mountain View",
        });
      }
    } catch (e) {
      print("Une erreur est survenue lors de l'enregistrement. Veuillez réessayer plus tard.");
    }
    userState = Interface.connectionPage;
    emit(UserState(userState));
  }

  Future<void> _deconectionUser(event, emit) async {
    userState = Interface.connectionPage;
    emit(UserState(userState));
  }

  Future<void> _forgottenUser(event, emit) async {
    try {
      final auth = FirebaseAuth.instance;
      await auth.sendPasswordResetEmail(email: event.mail);
    } catch (e) {
      print("Une erreur est survenue lors de l'envoie du mail. Veuillez réessayer plus tard.");
    }
    userState = Interface.connectionPage;
    emit(UserState(userState));
  }

  Future<void> _registerPage(event, emit) async {
    userState = Interface.registerPage;
    emit(UserState(userState));
  }

  Future<void> _forgottenPage(event, emit) async {
    userState = Interface.forgottenPage;
    emit(UserState(userState));
  }

  Future<void> _homePage(event, emit) async {
    userState = Interface.homePage;
    emit(UserState(userState));
  }
}