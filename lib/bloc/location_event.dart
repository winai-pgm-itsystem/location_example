part of 'location_bloc.dart';

sealed class LocationEvent extends Equatable {
  const LocationEvent();
}

final class ListenLocationEvent extends LocationEvent {
  const ListenLocationEvent();

  @override
  List<Object> get props => [];
}

final class UpdateLocationEvent extends LocationEvent {
  final UserLocation userLocation;
  const UpdateLocationEvent(this.userLocation);

  @override
  List<Object> get props => [userLocation];
}
