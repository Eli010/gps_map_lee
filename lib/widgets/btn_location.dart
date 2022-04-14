import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maps_app_lee/blocs/blocs.dart';
import 'package:maps_app_lee/ui/ui.dart';

class BtnCurrentLocation extends StatelessWidget {
  const BtnCurrentLocation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //para nuestro LocationBloc
    final locationBloc = BlocProvider.of<LocationBloc>(context);

    //para nuestro bloc map
    final mapBloc = BlocProvider.of<MapBloc>(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
          backgroundColor: Colors.white,
          maxRadius: 25,
          child: IconButton(
            icon: const Icon(
              Icons.my_location_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              //la ultima ubicacion conocida
              final userLocation = locationBloc.state.lastKnownLocation;
              if (userLocation == null) {
                final snackBar = CustomSnackbar(message: 'No hay Ubicaion');
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                return;
              }

              mapBloc.moveCamera(userLocation);
            },
          )),
    );
  }
}
