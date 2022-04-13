import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app_lee/blocs/gps/gps_bloc.dart';

class GpsAccessScreen extends StatelessWidget {
  const GpsAccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: BlocBuilder<GpsBloc, GpsState>(builder: (context, state) {
        return !state.isGpsEnabled
            ? const _EnableGpsMessage()
            : const _AccessButton();
      })
          // _AccessButton()
          //  _EnableGpsMessage(),
          ),
    );
  }
}

class _AccessButton extends StatelessWidget {
  const _AccessButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Es necesario el GPS'),
        MaterialButton(
            child: const Text(
              'Solicitar Acceso',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            color: Colors.black,
            shape: const StadiumBorder(),
            onPressed: () {
              //dos formar de llamar nuestro bloc
              final gpsBloc = BlocProvider.of<GpsBloc>(context);
              // final gpsBloc = context.read<GpsBloc>();
              gpsBloc.askGpsAccess();
            })
      ],
    );
  }
}

class _EnableGpsMessage extends StatelessWidget {
  const _EnableGpsMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text('Debe habilitar el GPS');
  }
}