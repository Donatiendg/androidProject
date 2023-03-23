import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

abstract class TrueUserEvent{}

class LogInEvent extends TrueUserEvent{
  final String mail;
  final String password;

  LogInEvent(this.mail, this.password);
}

class RegisterEvent extends TrueUserEvent{
  final String name;
  final String mail;
  final String password;

  RegisterEvent(this.name, this.mail, this.password);
}

class ForgottenUserEvent extends TrueUserEvent{
  final String mail;

  ForgottenUserEvent(this.mail);
}

class LogOutEvent extends TrueUserEvent{}

abstract class TrueUserState{}

class Loading extends TrueUserState{}

class Success extends TrueUserState{
  final User? user;

  Success(this.user);
}

class Error extends TrueUserState{
  final String error;
  Error(this.error);
}

class SuccessLogOut extends TrueUserState{}

class TrueUserBloc extends Bloc<TrueUserEvent, TrueUserState> {
  User? user;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  TrueUserBloc() : super(Loading()){
    on<LogInEvent>(_connectionUser);
    on<RegisterEvent>(_registerUser);
    on<ForgottenUserEvent>(_forgottenUser);
    on<LogOutEvent>(_deconectionUser);
  }

  Future<void> _connectionUser(event, emit) async {
    emit(Loading());

    final userCredential = await auth.signInWithEmailAndPassword(
      email: event.mail,
      password: event.password,
    );

    if(userCredential.runtimeType == UserCredential){
      user = userCredential.user;
      emit(Success(user));
    }else{
      emit(Error("Erreur d'authentication"));
    }
  }

  Future<void> _registerUser(event, emit) async {
    emit(Loading());

    final userCredential = await auth.createUserWithEmailAndPassword(
      email: event.mail,
      password: event.password,
    );
    await db.collection("users").doc(userCredential.user?.uid).set({
      "ID": userCredential.user?.email,
      "wishlist": [],
      "likes": [],
    });

    if(userCredential.runtimeType == UserCredential){
      user = userCredential.user;
      emit(Success(user));
    }else{
      emit(Error("Erreur d'authentication"));
    }
  }

  Future<void> _forgottenUser(event, emit) async {
    try {
      final auth = FirebaseAuth.instance;
      await auth.sendPasswordResetEmail(email: event.mail);
    } catch (e) {
      throw Exception("Une erreur est survenue lors de l'envoie du mail. Veuillez réessayer plus tard.");
    }
    //emit(UserPage(, null));
  }

  Future<void> _deconectionUser(event, emit) async {
    emit(Loading());

    auth.signOut();

    emit(SuccessLogOut());
  }
}