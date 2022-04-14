import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  //creamos una propiedad de tipo streamSubscription
  StreamSubscription? positionStream;

  LocationBloc() : super(const LocationState()) {
    //evento para obtener una nueva ubicacion
    on<OnNewUserLocationEvent>((event, emit) {
      emit(state.copyWith(lastKnownLocation: event.newLocation,
          //con los tres puntos le digo que continue despues de eso
          myLocationHistory: [...state.myLocationHistory, event.newLocation]));
    });

    //evento para iniciar el seguimiendo de nuestro usuario
    on<OnstartFollowingUserEvent>(
        (event, emit) => emit(state.copyWith(followingUser: true)));

    //event para dejar de seguir la ubicacion de mi usuario
    on<OnStopFollowingUSerEvent>(
        (event, emit) => emit(state.copyWith(followingUser: false)));
  }

  //obtenemos la posicion actual con este metodo
  Future getCurrentPosition() async {
    //nos creamos una variable que tendra nuestra posicion actual
    final position = await Geolocator.getCurrentPosition();
    // print('position: $position');

    //obtenemos la nueva posicion
    add(OnNewUserLocationEvent(LatLng(position.latitude, position.longitude)));
  }

  //metodo para el seguimiento del usuario
  void startFollowingUser() {
    add(OnstartFollowingUserEvent());
    // print('startFolleingUser');
    positionStream = Geolocator.getPositionStream().listen((event) {
      //solo obtenemos el valor del evento en una variable
      final position = event;

      //desde aqui enviamos nuestro evento de  nuevo localizacion de usuario
      add(OnNewUserLocationEvent(
          LatLng(position.latitude, position.longitude)));
      // print('next postion changed: $position');
    });
  }

  void stopFollowingUser() {
    add(OnStopFollowingUSerEvent());
    positionStream?.cancel();
    // print('stopFollowingUser');
  }

  @override
  Future<void> close() {
    stopFollowingUser();
    return super.close();
  }
}
