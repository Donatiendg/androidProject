import 'package:flutter_bloc/flutter_bloc.dart';

abstract class UserEvent{}

class ConnectionEvent extends UserEvent{}

class DeconectionEvent extends UserEvent{}

class UserState{
  late final bool connected;
  UserState(this.connected);
}

class UserBloc extends Bloc<UserEvent,UserState> {

  bool _connected = false;

  UserBloc() : super(UserState(false)) {
    on<ConnectionEvent>(_onConction);
    on<DeconectionEvent>(_onDeconection);
  }

  Future<void> _onConction(event, emit) async {
    _connected = true;
    emit(UserState(_connected));
  }

  Future<void> _onDeconection(event, emit) async {
    _connected = false;
    emit(UserState(_connected));
  }

}