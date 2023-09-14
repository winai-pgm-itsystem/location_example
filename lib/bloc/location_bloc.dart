import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import 'package:location_example/bloc/user_location.dart';
part 'location_state.dart';
part 'location_event.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationSettings locationSettings = const LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );
  late StreamSubscription<Position> _subscription;

  LocationBloc() : super(LocationState()) {
    on<ListenLocationEvent>(_listenLocation);
    on<UpdateLocationEvent>(_updateLocation);
  }

  _listenLocation(
    ListenLocationEvent event,
    Emitter<LocationState> emit,
  ) async {
    _subscription =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position? position) {
      if (position != null) {
        final userLocation = UserLocation(
            latitude: position.latitude, longitude: position.longitude);

        add(UpdateLocationEvent(userLocation));
      }
    });
  }

  _updateLocation(
    UpdateLocationEvent event,
    Emitter<LocationState> emit,
  ) =>
      emit(state.copyWith(userLocation: event.userLocation));

  @override
  Future<void> close() {
    _subscription.cancel();
    return super.close();
  }
}
