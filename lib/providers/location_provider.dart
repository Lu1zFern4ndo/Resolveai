import 'package:flutter/foundation.dart';
import '../core/models/prestador.dart';
import '../core/utils/mock_data.dart';

class LocationProvider extends ChangeNotifier {
  double lat = kLatTeresina;
  double lng = kLngTeresina;
  String? erro;
  bool carregando = false;

  Future<void> atualizar() async {
    carregando = true;
    erro = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 300));
      lat = kLatTeresina;
      lng = kLngTeresina;
    } catch (e) {
      erro = e.toString();
    }

    carregando = false;
    notifyListeners();
  }

  List<Prestador> prestadoresProximos(
      List<Prestador> todos, {
        double raioKm = 10,
      }) {
    return todos;
  }
}