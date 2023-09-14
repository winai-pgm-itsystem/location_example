// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UserLocation extends Equatable {
  final double? latitude;

  final double? longitude;
  const UserLocation({
    this.latitude,
    this.longitude,
  });

  factory UserLocation.empty() => const UserLocation(
        latitude: 0,
        longitude: 0,
      );

  @override
  List<Object?> get props => [
        latitude,
        longitude,
      ];

  UserLocation copyWith({
    double? latitude,
    double? longitude,
  }) {
    return UserLocation(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
