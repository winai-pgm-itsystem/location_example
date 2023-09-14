part of 'location_bloc.dart';

final class LocationState extends Equatable {
  LocationState({
    this.status = LocationStatus.initial,
    UserLocation? userLocation,
  }) : userLocation = userLocation ?? UserLocation.empty();

  final LocationStatus status;
  final UserLocation userLocation;

  LocationState copyWith({
    LocationStatus? status,
    UserLocation? userLocation,
  }) {
    return LocationState(
      status: status ?? this.status,
      userLocation: userLocation ?? this.userLocation,
    );
  }

  @override
  List<Object?> get props => [
        status,
        userLocation,
      ];
}

enum LocationStatus {
  initial,
  loading,
  error,
  success,
}
