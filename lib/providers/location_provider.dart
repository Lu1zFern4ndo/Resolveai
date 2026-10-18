import 'package:flutter/foundation.dart';
import '../core/models/prestador.dart';
import '../core/services/location_service.dart';
import '../core/utils/distance_utils.dart';
import '../core/utils/mock_data.dart';

class LocationProvider extends ChangeNotifier {
  final LocationService _service;

  LocationProvider({LocationService? service})
      : _service = service ?? LocationService();

  double lat = kLatTeresina;
  double lng = kLngTeresina;
  bool carregando = false;


  LocalizacaoException? erro;

  bool usandoGpsReal = false;

  Future<void> atualizar() async {
    carregando = true;
    erro = null;
    notifyListeners();

    try {
      final pos = await _service.getCurrentPosition();
      lat = pos.latitude;
      lng = pos.longitude;
      usandoGpsReal = true;
    } on LocalizacaoException catch (e) {
      erro = e;
      lat = kLatTeresina;
      lng = kLngTeresina;
      usandoGpsReal = false;
    }

    carregando = false;
    notifyListeners();
  }

  Future<void> abrirConfiguracoes() {
    if (erro?.tipo == TipoErroLocalizacao.gpsDesativado) {
      return _service.abrirConfiguracoesGps();
    }
    return _service.abrirConfiguracoesApp();
  }

  List<PrestadorComDistancia> prestadoresProximos(
      List<Prestador> todos, {
        double raioKm = 10,
      }) =>
      filtrarProximos(todos, lat: lat, lng: lng, raioKm: raioKm);
}