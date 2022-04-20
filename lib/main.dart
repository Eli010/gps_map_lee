import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app_lee/blocs/blocs.dart';

import 'package:maps_app_lee/screens/screens.dart';
import 'package:maps_app_lee/services/services.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (BuildContext context) => GpsBloc()),
    BlocProvider(create: (BuildContext context) => LocationBloc()),
    BlocProvider(
        create: (BuildContext context) =>
            MapBloc(locationBloc: BlocProvider.of<LocationBloc>(context))),
    BlocProvider(
        create: (BuildContext context) =>
            SearchBloc(trafficService: TrafficService()))
  ], child: const MapsApp()));
}

class MapsApp extends StatelessWidget {
  const MapsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Maps App Lee',
        home: LoadingScreen());
  }
}
