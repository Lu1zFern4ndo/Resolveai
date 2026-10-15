import 'categoria_servico.dart';

class Prestador {
  final String id;
  final String nome;
  final String telefone;
  final CategoriaServico categoria;
  final double lat;
  final double lng;
  final double avaliacao; // 0 a 5

  const Prestador({
    required this.id,
    required this.nome,
    required this.telefone,
    required this.categoria,
    required this.lat,
    required this.lng,
    this.avaliacao = 0,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'nome': nome,
    'telefone': telefone,
    'categoria': categoria.name,
    'lat': lat,
    'lng': lng,
    'avaliacao': avaliacao,
  };

  factory Prestador.fromMap(Map<String, dynamic> map) => Prestador(
    id: map['id'] as String,
    nome: map['nome'] as String,
    telefone: map['telefone'] as String,
    categoria: CategoriaServico.fromName(map['categoria'] as String?),
    lat: (map['lat'] as num).toDouble(),
    lng: (map['lng'] as num).toDouble(),
    avaliacao: (map['avaliacao'] as num?)?.toDouble() ?? 0,
  );
}