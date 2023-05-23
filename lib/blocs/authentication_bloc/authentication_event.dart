part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticateWithEmailAndPassword extends AuthenticationEvent {
  final String email;
  final String password;

  const AuthenticateWithEmailAndPassword(this.password, this.email);

  @override
  List<Object> get props => [email, password];
}


