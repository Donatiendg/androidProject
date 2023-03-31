import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

abstract class UserEvent{}

class LogInEvent extends UserEvent{
  final String mail;
  final String password;

  LogInEvent(this.mail, this.password);
}

class RegisterEvent extends UserEvent{
  final String name;
  final String mail;
  final String password;
  final String confirmPassword;

  RegisterEvent(this.name, this.mail, this.password, this.confirmPassword);
}

class ForgottenUserEvent extends UserEvent{
  final String mail;

  ForgottenUserEvent(this.mail);
}

class LogOutEvent extends UserEvent{}

abstract class UserState{}

class Loading extends UserState{}

class Success extends UserState{
  final User? user;

  Success(this.user);
}

class ErrorState extends UserState{
  final String error;
  ErrorState(this.error);
}

class SuccessLogOut extends UserState{}

class UserBloc extends Bloc<UserEvent, UserState> {
  User? user;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  UserBloc() : super(Loading()){
    on<LogInEvent>(_connectionUser);
    on<RegisterEvent>(_registerUser);
    on<ForgottenUserEvent>(_forgottenUser);
    on<LogOutEvent>(_deconectionUser);
  }

  Future<void> _connectionUser(event, emit) async {
    emit(Loading());
    try{
      final userCredential = await auth.signInWithEmailAndPassword(
        email: event.mail,
        password: event.password,
      );
      user = userCredential.user;
      emit(Success(user));
    } on FirebaseAuthException catch (e) {
      emit(ErrorState(e.code));
    }
  }

  Future<void> _registerUser(event, emit) async {
    emit(Loading());
    if(event.password != event.confirmPassword){
      emit(ErrorState("les mots de passe ne sont pas identiques"));
    }else{
      try{
        final userCredential = await auth.createUserWithEmailAndPassword(
          email: event.mail,
          password: event.password,
        );
        final databaseReference = FirebaseDatabase.instance.reference();
        await databaseReference.child('users').child(userCredential.user!.uid).set({
          "ID": userCredential.user?.email,
          "wishlist": [],
          "likes": [],
        });
        user = userCredential.user;
        emit(Success(user));
      } on FirebaseAuthException catch (e) {
        emit(ErrorState(e.code));
      }
    }
  }

  Future<void> _forgottenUser(event, emit) async {
    emit(Loading());
    try{
      final auth = FirebaseAuth.instance;
      await auth.sendPasswordResetEmail(email: event.mail);
      emit(Success(user));
    } on FirebaseAuthException catch (e) {
      emit(ErrorState(e.code));
    }
  }

  Future<void> _deconectionUser(event, emit) async {
    emit(Loading());

    auth.signOut();

    emit(SuccessLogOut());
  }
}