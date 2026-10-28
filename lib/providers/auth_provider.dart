import 'package:flutter/foundation.dart';
import '../core/models/usuario.dart';

class AuthProvider extends ChangeNotifier {
  final Map<String, ({String senha, Usuario usuario})> _contas = {
    'cliente@teste.com': (
    senha: '123456',
    usuario: const Usuario(
      id: 'u1',
      nome: 'Cliente Teste',
      email: 'cliente@teste.com',
      tipo: TipoUsuario.cliente,
    ),
    ),
    'prestador@teste.com': (
    senha: '123456',
    usuario: const Usuario(
      id: 'p3', // mesmo id de um prestador do mock
      nome: 'Carlos Pereira',
      email: 'prestador@teste.com',
      tipo: TipoUsuario.prestador,
    ),
    ),
  };

  Usuario? usuario;
  String? erro;
  bool carregando = false;

  bool get logado => usuario != null;

  Future<bool> entrar(String email, String senha) async {
    carregando = true;
    erro = null;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500)); // simula rede

    final conta = _contas[email.trim().toLowerCase()];
    if (conta == null || conta.senha != senha) {
      erro = 'E-mail ou senha incorretos.';
      carregando = false;
      notifyListeners();
      return false;
    }

    usuario = conta.usuario;
    carregando = false;
    notifyListeners();
    return true;
  }

  Future<bool> cadastrar({
    required String nome,
    required String email,
    required String senha,
    required TipoUsuario tipo,
  }) async {
    carregando = true;
    erro = null;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    final chave = email.trim().toLowerCase();

    if (nome.trim().isEmpty || !chave.contains('@')) {
      erro = 'Preencha nome e um e-mail válido.';
    } else if (senha.length < 6) {
      erro = 'A senha deve ter pelo menos 6 caracteres.';
    } else if (_contas.containsKey(chave)) {
      erro = 'Este e-mail já está cadastrado.';
    }

    if (erro != null) {
      carregando = false;
      notifyListeners();
      return false;
    }

    final novo = Usuario(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      nome: nome.trim(),
      email: chave,
      tipo: tipo,
    );
    _contas[chave] = (senha: senha, usuario: novo);
    usuario = novo;

    carregando = false;
    notifyListeners();
    return true;
  }

  void sair() {
    usuario = null;
    erro = null;
    notifyListeners();
  }
}