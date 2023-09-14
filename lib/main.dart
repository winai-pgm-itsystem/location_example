import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_example/bloc/user_location.dart';

import 'bloc/location_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocationBloc>(
          create: (BuildContext context) =>
              LocationBloc()..add(const ListenLocationEvent()),
        ),
      ],
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Location'),
          ),
          body: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LocationWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        if (state.userLocation == UserLocation.empty()) {
          return const Text('กำลังค้นหาที่อยู่ของ user');
        } else if (state.userLocation != UserLocation.empty()) {
          return Text(
              'lat: ${state.userLocation.latitude} lon: ${state.userLocation.longitude}');
        }
        return const SizedBox();
      },
    );
  }
}
