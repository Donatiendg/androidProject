import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

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
      await auth.signInWithEmailAndPassword(
        email: event.mail,
        password: event.password,
      );
      userState = Interface.homePage;
      emit(UserState(userState));
    } catch (e) {
      print("Une erreur est survenue lors de l'authentification. Veuillez réessayer plus tard.");
    }
  }

  Future<void> _registerUser(event, emit) async {
    try {
      final UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: event.mail,
        password: event.password,
      );
      await db.collection("users").doc(userCredential.user?.uid).set({
        "ID": userCredential.user?.email,
        "wishlist": [],
        "likes": [],
      });
      userState = Interface.connectionPage;
      emit(UserState(userState));
    } catch (e) {
      print("Une erreur est survenue lors de l'enregistrement. Veuillez réessayer plus tard : $e");
    }
  }

  Future<void> _deconectionUser(event, emit) async {
    auth.signOut();
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