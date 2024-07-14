import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failure.dart';

typedef Callback<T> = Function(T);

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params, {Callback? callback});
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

class ListingsParams extends Equatable {
  final int? page;
  final int? count;

  ListingsParams({this.page, this.count});

  @override
  // List<Object> get props => [];
  List get props => [];
}
