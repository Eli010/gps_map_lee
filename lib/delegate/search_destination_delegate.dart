import 'package:flutter/material.dart';
import 'package:maps_app_lee/models/models.dart';

class SearchDestinationDelegate extends SearchDelegate<SearchResult> {
  SearchDestinationDelegate() : super(searchFieldLabel: 'Buscar ...');
  //las acciones ue hacemos "boton de limpiar"
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            //borramos lo que estamos escribiendo
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  //boton de regresar
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        final result = SearchResult(cancel: true);
        close(context, result);
      },
    );
  }

  //muestra los resultado hecho
  @override
  Widget buildResults(BuildContext context) {
    return const Text('Build Result');
  }

  //aqui obtenemos los cosas que queremos buscar
  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(
            Icons.location_on_outlined,
            color: Colors.black,
          ),
          title: const Text(
            'Colocar la ubicación manualmente',
            style:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
          ),
          onTap: () {
            //TODO: regresar algo
            final result = SearchResult(cancel: false, manual: true);
            close(context, result);
          },
        )
      ],
    );
  }
}
