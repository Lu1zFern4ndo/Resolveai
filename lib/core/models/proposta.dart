enum StatusProposta { pendente, aceita, recusada }

class Proposta {
  final String id;
  final String chamadoId;
  final String prestadorId;
  final String prestadorNome;
  final double valor;
  final String mensagem;
  final StatusProposta status;
  final DateTime criadaEm;

  const Proposta({
    required this.id,
    required this.chamadoId,
    required this.prestadorId,
    required this.prestadorNome,
    required this.valor,
    required this.criadaEm,
    this.mensagem = '',
    this.status = StatusProposta.pendente,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'chamadoId': chamadoId,
    'prestadorId': prestadorId,
    'prestadorNome': prestadorNome,
    'valor': valor,
    'mensagem': mensagem,
    'status': status.name,
    'criadaEm': criadaEm.toIso8601String(),
  };

  factory Proposta.fromMap(Map<String, dynamic> map) => Proposta(
    id: map['id'] as String,
    chamadoId: map['chamadoId'] as String,
    prestadorId: map['prestadorId'] as String,
    prestadorNome: map['prestadorNome'] as String,
    valor: (map['valor'] as num).toDouble(),
    mensagem: map['mensagem'] as String? ?? '',
    status: StatusProposta.values.firstWhere(
          (s) => s.name == map['status'],
      orElse: () => StatusProposta.pendente,
    ),
    criadaEm: DateTime.parse(map['criadaEm'] as String),
  );
}