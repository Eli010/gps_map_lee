import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maps_app_lee/blocs/blocs.dart';

class BtnFollowUse extends StatelessWidget {
  const BtnFollowUse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //para nuestro bloc map
    final mapBloc = BlocProvider.of<MapBloc>(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
          backgroundColor: Colors.white,
          maxRadius: 25,
          child: BlocBuilder<MapBloc, MapState>(
            builder: (context, state) {
              return IconButton(
                  icon: Icon(
                    state.isFollowingUSer
                        ? Icons.directions_run
                        : Icons.hail_rounded,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    mapBloc.add(OnStartFollowingUserMapEvent());
                  });
            },
          )),
    );
  }
}
