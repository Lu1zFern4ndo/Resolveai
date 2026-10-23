import 'dart:io';
import 'package:flutter/foundation.dart';
import '../core/services/camera_service.dart';

class FotoProvider extends ChangeNotifier {
  final CameraService _service;

  FotoProvider({CameraService? service})
      : _service = service ?? CameraService();

  File? foto;
  String? tamanho;
  bool carregando = false;
  CameraException? erro;

  Future<void> capturar(OrigemFoto origem) async {
    carregando = true;
    erro = null;
    notifyListeners();

    try {
      final arquivo = await _service.capturar(origem: origem);
      // null = usuário cancelou: mantém a foto anterior.
      if (arquivo != null) {
        foto = arquivo;
        tamanho = await CameraService.tamanhoLegivel(arquivo);
      }
    } on CameraException catch (e) {
      erro = e;
    }

    carregando = false;
    notifyListeners();
  }

  void remover() {
    foto = null;
    tamanho = null;
    erro = null;
    notifyListeners();
  }
}