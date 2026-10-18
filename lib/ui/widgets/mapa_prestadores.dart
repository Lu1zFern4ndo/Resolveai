import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../core/utils/distance_utils.dart';

class MapaPrestadores extends StatelessWidget {
  final LatLng centro;
  final List<PrestadorComDistancia> prestadores;
  final void Function(PrestadorComDistancia)? aoTocarPrestador;

  const MapaPrestadores({
    super.key,
    required this.centro,
    required this.prestadores,
    this.aoTocarPrestador,
  });

  @override
  Widget build(BuildContext context) {
    final marcadores = prestadores.map((item) {
      final p = item.prestador;
      return Marker(
        markerId: MarkerId(p.id),
        position: LatLng(p.lat, p.lng),
        infoWindow: InfoWindow(
          title: p.nome,
          snippet: '${p.categoria.nome} • ${item.distanciaFormatada}',
          onTap: aoTocarPrestador == null ? null : () => aoTocarPrestador!(item),
        ),
      );
    }).toSet();

    return GoogleMap(
      key: ValueKey('${centro.latitude},${centro.longitude}'),
      initialCameraPosition: CameraPosition(target: centro, zoom: 13),
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      markers: marcadores,
    );
  }
}