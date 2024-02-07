part of 'location_cubit.dart';

@immutable
abstract class LocationState extends Equatable {}

class LocationInitial extends LocationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LocationLoading extends LocationState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class LocationLoaded extends LocationState {

  List<Location> locations = [];

  LocationLoaded(this.locations);

  @override
  // TODO: implement props
  List<Object?> get props => [this.locations];
}
