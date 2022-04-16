part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitializedEvent extends MapEvent {
  //para controlar nuestro mapa
  final GoogleMapController controller;

  const OnMapInitializedEvent(this.controller);
}

//me creo el vento para dejar de seguir
class OnStopFollowingUserMapEvent extends MapEvent {}

//me creo otro evento para seguir
class OnStartFollowingUserMapEvent extends MapEvent {}

//para trazar  o dibujar nuestro polylines
class UpdateUserPolylineEvent extends MapEvent {
  //la longitud y latitud
  final List<LatLng> userLocation;
  const UpdateUserPolylineEvent(this.userLocation);
}

//para mostrar u ocultar mi plylines
class OnToggleUserRoute extends MapEvent {}
