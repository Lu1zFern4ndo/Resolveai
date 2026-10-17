import 'package:geolocator/geolocator.dart';

enum TipoErroLocalizacao { gpsDesativado, permissaoNegada, permissaoNegadaParaSempre, timeout }

class LocalizacaoException implements Exception {
  final TipoErroLocalizacao tipo;
  final String mensagem;
  const LocalizacaoException(this.tipo, this.mensagem);

  @override
  String toString() => mensagem;
}

class LocationService {
  Future<Position> getCurrentPosition() async {
    final gpsLigado = await Geolocator.isLocationServiceEnabled();
    if (!gpsLigado) {
      throw const LocalizacaoException(
        TipoErroLocalizacao.gpsDesativado,
        'GPS desativado. Ative a localização do aparelho.',
      );
    }

    var permissao = await Geolocator.checkPermission();
    if (permissao == LocationPermission.denied) {
      permissao = await Geolocator.requestPermission();
    }

    if (permissao == LocationPermission.deniedForever) {
      throw const LocalizacaoException(
        TipoErroLocalizacao.permissaoNegadaParaSempre,
        'Permissão negada permanentemente. Libere nas configurações do app.',
      );
    }
    if (permissao == LocationPermission.denied) {
      throw const LocalizacaoException(
        TipoErroLocalizacao.permissaoNegada,
        'Permissão de localização negada.',
      );
    }

    try {
      return await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 15),
        ),
      );
    } on Exception {
      throw const LocalizacaoException(
        TipoErroLocalizacao.timeout,
        'Não foi possível obter a localização. Tente novamente.',
      );
    }
  }
  Future<bool> abrirConfiguracoesApp() => Geolocator.openAppSettings();
  Future<bool> abrirConfiguracoesGps() => Geolocator.openLocationSettings();
}