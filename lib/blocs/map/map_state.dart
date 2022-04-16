part of 'map_bloc.dart';

class MapState extends Equatable {
  //para saber si tenemos inicializado el mapa
  final bool isMapInitialized;

  //para seguir a un usuario
  final bool isFollowingUSer;
  //para mostrar y ocultar mi polylines
  final bool showMyRoute;

  //para trazar nuestra ruta
  final Map<String, Polyline> polylines;
  //como funciona mi polyline?
  /*
    'mi ruta:{
      id:Polyline Google,
      point:{[lat,lnt],[1234212,1234123],[123213,1312132]},
      width:3,
      color:black
    }
  */

  const MapState({
    this.isMapInitialized = false,
    this.isFollowingUSer = true,
    this.showMyRoute = true,
    Map<String, Polyline>? polylines,
  }) : polylines = polylines ?? const {};

  MapState copyWith(
          {bool? isMapInitialized,
          bool? isFollowingUSer,
          bool? showMyRoute,
          Map<String, Polyline>? polylines}) =>
      MapState(
          isFollowingUSer: isFollowingUSer ?? this.isFollowingUSer,
          isMapInitialized: isMapInitialized ?? this.isMapInitialized,
          showMyRoute: showMyRoute ?? this.showMyRoute,
          polylines: polylines ?? this.polylines);
  @override
  List<Object> get props =>
      [isMapInitialized, isFollowingUSer, showMyRoute, polylines];
}
