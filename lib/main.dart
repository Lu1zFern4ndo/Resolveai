import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/utils/mock_data.dart';
import 'providers/chamado_provider.dart';
import 'providers/location_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocationProvider()..atualizar()),
        ChangeNotifierProvider(create: (_) => ChamadoProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ResolveAí',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const TelaTeste(),
    );
  }
}

class TelaTeste extends StatelessWidget {
  const TelaTeste({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = context.watch<LocationProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('ResolveAí - Teste')),
      body: loc.carregando
          ? const Center(child: CircularProgressIndicator())
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Posição: ${loc.lat}, ${loc.lng}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: prestadoresMock.length,
              itemBuilder: (_, i) {
                final p = prestadoresMock[i];
                return ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(p.nome),
                  subtitle: Text(p.categoria.nome),
                  trailing: Text('⭐ ${p.avaliacao}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}