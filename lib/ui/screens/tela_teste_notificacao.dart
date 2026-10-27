import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/models/chamado.dart';
import '../../core/models/categoria_servico.dart';
import '../../core/models/proposta.dart';
import '../../core/services/notification_service.dart';
import '../../providers/chamado_provider.dart';

class TelaTesteNotificacao extends StatelessWidget {
  const TelaTesteNotificacao({super.key});

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<ChamadoProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Teste de notificação')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OutlinedButton.icon(
              onPressed: () async {
                final ok = await NotificationService.instance.pedirPermissao();
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(ok
                      ? 'Permissão concedida'
                      : 'Permissão negada'),
                ));
              },
              icon: const Icon(Icons.notifications_active),
              label: const Text('Pedir permissão'),
            ),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: () {
                final p = context.read<ChamadoProvider>();
                final agora = DateTime.now();
                final id = agora.millisecondsSinceEpoch.toString();

                p.criarChamado(Chamado(
                  id: id,
                  titulo: 'Infiltração no banheiro',
                  descricao: 'Mancha de umidade no teto',
                  categoria: CategoriaServico.pedreiro,
                  lat: -5.0892,
                  lng: -42.8019,
                  criadoEm: agora,
                ));

                // Simula o prestador respondendo depois de 3 segundos.
                Future.delayed(const Duration(seconds: 3), () {
                  p.adicionarProposta(Proposta(
                    id: 'prop_$id',
                    chamadoId: id,
                    prestadorId: 'p3',
                    prestadorNome: 'Carlos Pereira',
                    valor: 180,
                    mensagem: 'Posso ir amanhã cedo.',
                    criadaEm: DateTime.now(),
                  ));
                });
              },
              icon: const Icon(Icons.send),
              label: const Text('Simular: criar chamado + proposta (3s)'),
            ),
            const SizedBox(height: 16),
            Text('Chamados: ${prov.chamados.length}'),
            Expanded(
              child: ListView(
                children: [
                  for (final c in prov.chamados)
                    ListTile(
                      title: Text(c.titulo),
                      subtitle: Text(
                          'Status: ${c.status.name} • propostas: ${prov.propostasDo(c.id).length}'),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}