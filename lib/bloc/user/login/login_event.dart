import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent{
  final String email;
  final String password;

  LoginButtonPressed({
    @required this.email,
    @required this.password,
  });

  @override
  String toString() => 
    'LoginButtonPressed, {email: $email, password: $password';

}