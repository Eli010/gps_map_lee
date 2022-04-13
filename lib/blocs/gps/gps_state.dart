part of 'gps_bloc.dart';

class GpsState extends Equatable {
  //si esta activo
  final bool isGpsEnabled;
  // si esta tienes los permisos otorgados
  final bool isGpsPermissionGranted;

  //aqui comprobamos si todo esta bien
  bool get isAllGranted => isGpsEnabled && isGpsPermissionGranted;

  //mi contructor con argumentos nombrandos
  const GpsState(
      {required this.isGpsEnabled, required this.isGpsPermissionGranted});

  GpsState copyWith(
          {bool? isGpsEnabled, bool? isGpsPermissionGranted}) =>
      GpsState(
          isGpsEnabled: isGpsEnabled ?? this.isGpsEnabled,
          isGpsPermissionGranted:
              isGpsPermissionGranted ?? this.isGpsPermissionGranted);

  @override
  List<Object> get props => [isGpsEnabled, isGpsPermissionGranted];

  //aqui agregamos algo solo para mostrar en nuestro terminal
  @override
  String toString() =>
      '[isGpsEnabled: $isGpsEnabled, isGpsPermissionGranted: $isGpsPermissionGranted]';
}

// class GpsInitial extends GpsState {}
