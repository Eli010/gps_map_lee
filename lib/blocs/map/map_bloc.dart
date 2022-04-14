import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app_lee/themes/themes.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  GoogleMapController? _mapController;
  MapBloc() : super(const MapState()) {
    on<OnMapInitializedEvent>(_onInitMap);
  }

  void _onInitMap(OnMapInitializedEvent event, Emitter<MapState> emit) {
    _mapController = event.controller;

    _mapController!.setMapStyle(json.encode(uberMapTheme));
    emit(state.copyWith(isMapInitialized: true));
  }

  //para mover la camara en la ubicacion actual
  void moveCamera(LatLng newLocation) {
    //para actulizar la camara
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);

    _mapController?.animateCamera(cameraUpdate);
  }
}