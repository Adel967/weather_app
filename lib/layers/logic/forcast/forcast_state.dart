part of 'forcast_cubit.dart';

@immutable
abstract class ForcastState extends Equatable{}

class ForcastInitial extends ForcastState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ForcastLoading extends ForcastState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ForcastRefreshing extends ForcastState {

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ForcastLoaded extends ForcastState {

  final ForCast forCast;

  ForcastLoaded(this.forCast);

  @override
  // TODO: implement props
  List<Object?> get props => [this.forCast];
}

class ForcastError extends ForcastState {

  final AppException exception;

  ForcastError(this.exception);

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
