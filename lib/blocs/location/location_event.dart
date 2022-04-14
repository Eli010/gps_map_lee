part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

//nueva ubicacion del usuario
class OnNewUserLocationEvent extends LocationEvent {
  //para una nueva ubicacion
  final LatLng newLocation;
  //siempre recibo la newLocation
  const OnNewUserLocationEvent(this.newLocation);
}

//Inicio del seguimiento de nuestra corderna de usuario
class OnstartFollowingUserEvent extends LocationEvent {}

//dejamos de seguir las coordenaddas de nuestro usuario
class OnStopFollowingUSerEvent extends LocationEvent {}
