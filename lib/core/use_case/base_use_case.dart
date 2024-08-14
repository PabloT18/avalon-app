import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failures/failures.dart';

abstract class BaseUseCase<T, P> {
  const BaseUseCase();
  Future<Either<Failure, T>> call({required P param});
}

class NoParams extends Equatable {
  const NoParams();
  @override
  List<Object> get props => [];
}
