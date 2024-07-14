import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;

  const Failure({this.message});

  @override
  List<Object> get props => [];
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure({String? message}) : super(message: message);
}

class BlockResquestFailure extends Failure {
  const BlockResquestFailure({String? message}) : super(message: message);
}

class UnauthorisedFailure extends Failure {
  const UnauthorisedFailure({String? message}) : super(message: message);
}
