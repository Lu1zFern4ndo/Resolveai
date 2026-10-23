import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/services/camera_service.dart';
import '../../providers/foto_provider.dart';

class TelaTesteCamera extends StatelessWidget {
  const TelaTesteCamera({super.key});

  @override
  Widget build(BuildContext context) {
    final fotoProv = context.watch<FotoProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Teste da câmera')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: FilledButton.icon(
                    onPressed: fotoProv.carregando
                        ? null
                        : () => fotoProv.capturar(OrigemFoto.camera),
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Tirar foto'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: fotoProv.carregando
                        ? null
                        : () => fotoProv.capturar(OrigemFoto.galeria),
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Galeria'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (fotoProv.carregando)
              const Center(child: CircularProgressIndicator()),
            if (fotoProv.erro != null)
              Text(
                fotoProv.erro!.mensagem,
                style: const TextStyle(color: Colors.red),
              ),
            if (fotoProv.foto != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  fotoProv.foto!,
                  height: 280,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Text('Tamanho após compressão: ${fotoProv.tamanho}'),
              TextButton.icon(
                onPressed: fotoProv.remover,
                icon: const Icon(Icons.delete_outline),
                label: const Text('Remover foto'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}