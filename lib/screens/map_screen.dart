import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:maps_app_lee/blocs/blocs.dart';
import 'package:maps_app_lee/views/views.dart';
import 'package:maps_app_lee/widgets/widgets.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  //nos creams una propieda de tipo LocationBloc
  late LocationBloc locationBloc;
  @override
  void initState() {
    super.initState();
    final locationBloc = BlocProvider.of<LocationBloc>(context);

    //con esto muestro mi posicion actual
    // locationBloc.getCurrentPosition();

    //ecuchamos en seguimiento de nuestro usuario
    locationBloc.startFollowingUser();
  }

  @override
  void dispose() {
    locationBloc.stopFollowingUser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, locationState) {
        if (locationState.lastKnownLocation == null) {
          return const Center(
            child: Text('Espere por favor...'),
          );
        }
        return BlocBuilder<MapBloc, MapState>(builder: (context, mapState) {
          Map<String, Polyline> polylines = Map.from(mapState.polylines);
          if (!mapState.showMyRoute) {
            polylines.removeWhere((key, value) => key == 'myRoute');
          }
          return SingleChildScrollView(
            child: Stack(children: [
              MapView(
                  initialLocation: locationState.lastKnownLocation!,
                  polylines: polylines.values.toSet())
            ]),
          );
        });
        //aqui mostramos nuestra mapa
        // final CameraPosition initialCameraPisition =
        //     CameraPosition(target: state.lastKnownLocation!, zoom: 15);
        // return GoogleMap(initialCameraPosition: initialCameraPisition);

        /*
      MOSTRAMOS NUESTRA LOCALIZACIONES LONGITUS LATITUD
       return Center(
         child: Text(
             '${state.lastKnownLocation?.latitude}, ${state.lastKnownLocation?.longitude}'),
       );*/
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: const [
          BtnToggleUserRoute(),
          BtnFollowUse(),
          BtnCurrentLocation()
        ],
      ),
    );
  }
}
