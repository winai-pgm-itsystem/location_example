import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:location_example/bloc/user_location.dart';
part 'location_state.dart';
part 'location_event.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  late StreamSubscription _subscription;

  LocationBloc() : super(LocationState()) {
    on<ListenLocationEvent>(_listenLocation);
    on<UpdateLocationEvent>(_updateLocation);
  }

  _listenLocation(
    ListenLocationEvent event,
    Emitter<LocationState> emit,
  ) async {
    _subscription = Location().onLocationChanged.listen((LocationData current) {
      if (current.latitude != null && current.longitude != null) {
        final userLocation = UserLocation(
            latitude: current.latitude, longitude: current.longitude);

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
