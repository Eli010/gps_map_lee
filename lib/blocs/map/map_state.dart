part of 'map_bloc.dart';

class MapState extends Equatable {
  //para saber si tenemos inicializado el mapa
  final bool isMapInitialized;

  //para seguir a un usuario
  final bool followingUSer;

  const MapState({this.isMapInitialized = false, this.followingUSer = false});

  MapState copyWith({bool? isMapInitialized, bool? followingUSer}) => MapState(
      followingUSer: followingUSer ?? this.followingUSer,
      isMapInitialized: isMapInitialized ?? this.isMapInitialized);
  @override
  List<Object> get props => [isMapInitialized, followingUSer];
}
