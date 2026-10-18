import 'package:geolocator/geolocator.dart';
import '../models/prestador.dart';

class PrestadorComDistancia {
  final Prestador prestador;
  final double distanciaKm;
  const PrestadorComDistancia(this.prestador, this.distanciaKm);


  String get distanciaFormatada {
    if (distanciaKm < 1) return '${(distanciaKm * 1000).round()} m';
    return '${distanciaKm.toStringAsFixed(1).replaceAll('.', ',')} km';
  }
}

double distanciaKm(double lat1, double lng1, double lat2, double lng2) =>
    Geolocator.distanceBetween(lat1, lng1, lat2, lng2) / 1000;

List<PrestadorComDistancia> filtrarProximos(
    List<Prestador> todos, {
      required double lat,
      required double lng,
      double raioKm = 10,
    }) {
  final lista = todos
      .map((p) => PrestadorComDistancia(
    p,
    distanciaKm(lat, lng, p.lat, p.lng),
  ))
      .where((e) => e.distanciaKm <= raioKm)
      .toList()
    ..sort((a, b) => a.distanciaKm.compareTo(b.distanciaKm));
  return lista;
}