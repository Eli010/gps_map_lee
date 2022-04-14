part of 'location_bloc.dart';

class LocationState extends Equatable {
  //para el segumiento al usuario
  final bool followingUser;

  //para ultima ubicacion
  final LatLng? lastKnownLocation;

  //guardar mi historial
  final List<LatLng> myLocationHistory;

  const LocationState(
      {this.followingUser = false, this.lastKnownLocation, myLocationHistory})
      : myLocationHistory = myLocationHistory ?? const [];

  LocationState copyWith({
    //para el segumiento al usuario
    bool? followingUser,

    //para ultima ubicacion
    LatLng? lastKnownLocation,

    //guardar mi historial
    List<LatLng>? myLocationHistory,
  }) =>
      LocationState(
          followingUser: followingUser ?? this.followingUser,
          lastKnownLocation: lastKnownLocation ?? this.lastKnownLocation,
          myLocationHistory: myLocationHistory ?? this.myLocationHistory);

  @override
  List<Object?> get props =>
      [followingUser, lastKnownLocation, myLocationHistory];
}
