import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maps_app_lee/blocs/blocs.dart';

class MapView extends StatelessWidget {
  //
  final LatLng initialLocation;

  //para el uso de nuestro Polylines
  final Set<Polyline> polylines;

  const MapView(
      {Key? key, required this.initialLocation, required this.polylines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapBloc = BlocProvider.of<MapBloc>(context);

    final CameraPosition initialCameraPosition =
        CameraPosition(target: initialLocation, zoom: 15);

    final size = MediaQuery.of(context).size;
    return SizedBox(
        width: size.width,
        height: size.height,
        child: Listener(
          onPointerMove: (pointerMoveEvent) =>
              // print('OnStaopfollingUserMapEvent'),
              mapBloc.add(OnStopFollowingUserMapEvent()),
          child: GoogleMap(
            initialCameraPosition: initialCameraPosition,
            compassEnabled: false,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            polylines: polylines,
            onCameraMove: (position) => mapBloc.mapCenter = position.target,
            onMapCreated: (controller) =>
                mapBloc.add(OnMapInitializedEvent(controller)),
          ),
        ));
  }
}
