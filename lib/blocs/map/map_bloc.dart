import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:maps_app_lee/blocs/blocs.dart';
import 'package:maps_app_lee/themes/themes.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  //nos creamos una propieda de tipo LocationBloc
  final LocationBloc locationBloc;

  GoogleMapController? _mapController;

  //para limpiar
  StreamSubscription<LocationState>? locationStateSubscription;

  MapBloc({required this.locationBloc}) : super(const MapState()) {
    on<OnMapInitializedEvent>(_onInitMap);

    //detener y seguir el seguimiento
    on<OnStartFollowingUserMapEvent>(_onStartFollwingUSer);
    on<OnStopFollowingUserMapEvent>(
        (event, emit) => emit(state.copyWith(isFollowingUSer: false)));
    on<UpdateUserPolylineEvent>(_onPolylineNewPoint);
    on<OnToggleUserRoute>(
        (event, emit) => emit(state.copyWith(showMyRoute: !state.showMyRoute)));
    //escuchamos el seguimiento
    locationStateSubscription = locationBloc.stream.listen((locationState) {
      if (locationState.lastKnownLocation != null) {
        add(UpdateUserPolylineEvent(locationState.myLocationHistory));
      }
      if (!state.isFollowingUSer) return;
      moveCamera(locationState.lastKnownLocation!);
    });
  }

  void _onInitMap(OnMapInitializedEvent event, Emitter<MapState> emit) {
    _mapController = event.controller;

    _mapController!.setMapStyle(json.encode(uberMapTheme));
    emit(state.copyWith(isMapInitialized: true));
  }

  //reglas para el seguimiento de usuario con el inico
  void _onStartFollwingUSer(
      OnStartFollowingUserMapEvent event, Emitter<MapState> emit) {
    emit(state.copyWith(isFollowingUSer: true));
    if (locationBloc.state.lastKnownLocation == null) return;
    moveCamera(locationBloc.state.lastKnownLocation!);
  }

  //para dibujar nuestra polylines
  void _onPolylineNewPoint(
      UpdateUserPolylineEvent event, Emitter<MapState> emit) {
    //creamo mi id y diseño
    final myRoute = Polyline(
        polylineId: const PolylineId('myRoute'),
        color: Colors.black,
        width: 5,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        points: event.userLocation);
    //el recorrido que tendra en la actulidad
    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['myRoute'] = myRoute;
    emit(state.copyWith(polylines: currentPolylines));
  }

  //para mover la camara en la ubicacion actual
  void moveCamera(LatLng newLocation) {
    //para actulizar la camara
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);

    _mapController?.animateCamera(cameraUpdate);
  }

  @override
  Future<void> close() {
    locationStateSubscription?.cancel();
    return super.close();
  }
}
