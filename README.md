# ResolveAí

Aplicativo Flutter que conecta clientes a prestadores de serviços domésticos
(encanadores, eletricistas, técnicos). Trabalho final de Programação para
Dispositivos Móveis, UESPI.

## Recursos avançados implementados

- **Geolocalização** (`geolocator`): posição do cliente e filtro de prestadores por raio
- **Mapa** (`google_maps_flutter`): prestadores como marcadores
- **Câmera** (`image_picker` + `flutter_image_compress`): foto do problema com compressão
- **Notificações locais** (`flutter_local_notifications`): aviso quando chega uma proposta

## Como rodar

1. Instale o Flutter e rode `flutter doctor`
2. Clone o repositório e rode `flutter pub get`
3. Crie uma chave do **Maps SDK for Android** no Google Cloud
4. No arquivo `android/local.properties` (não versionado), adicione:

   ```properties
   MAPS_API_KEY=SUA_CHAVE_AQUI
   ```

5. Rode `flutter run` com um celular ou emulador Android

Se a chave estiver restrita por pacote e SHA-1, cada desenvolvedor deve rodar
`cd android; ./gradlew signingReport` e adicionar o próprio SHA-1 à chave no
Google Cloud. Sem isso, o mapa fica cinza.

## Estrutura

```
lib/
├── core/
│   ├── models/     Usuario, Prestador, Chamado, Proposta, CategoriaServico
│   ├── services/   LocationService, CameraService, NotificationService
│   └── utils/      distance_utils, mock_data
├── providers/      AuthProvider, LocationProvider, ChamadoProvider, FotoProvider
└── ui/
    ├── screens/    telas
    └── widgets/    MapaPrestadores
```

## Como usar cada recurso (guia para telas)

| Necessidade | Como usar |
|---|---|
| Login | `context.read<AuthProvider>().entrar(email, senha)` devolve `true`/`false`; mensagem de erro em `auth.erro` |
| Cadastro | `context.read<AuthProvider>().cadastrar(nome:, email:, senha:, tipo:)` |
| Usuário logado | `context.watch<AuthProvider>().usuario` (`ehCliente` / `ehPrestador`) |
| Sair | `context.read<AuthProvider>().sair()` |
| Posição atual e erro de GPS | `context.watch<LocationProvider>()` (`lat`, `lng`, `erro`, `carregando`, `atualizar()`) |
| Prestadores próximos | `loc.prestadoresProximos(lista, raioKm: 10)` devolve `PrestadorComDistancia` |
| Mapa | `MapaPrestadores(centro: LatLng(...), prestadores: ...)` |
| Foto no formulário | `context.read<FotoProvider>().capturar(OrigemFoto.camera)`; exibir com `Image.file(foto)` |
| Criar chamado | `context.read<ChamadoProvider>().criarChamado(Chamado(...))` |
| Chamados para o prestador | `ChamadoProvider.chamadosAbertos` |
| Receber proposta + notificar | `ChamadoProvider.adicionarProposta(...)` já dispara a notificação |
| Propostas de um chamado | `ChamadoProvider.propostasDo(chamadoId)` |
| Aceitar proposta | `ChamadoProvider.aceitarProposta(propostaId)` |

## Contas de teste

O login é fictício (em memória). Contas já cadastradas:

| Tipo | E-mail | Senha |
|---|---|---|
| Cliente | `cliente@teste.com` | `123456` |
| Prestador | `prestador@teste.com` | `123456` |

Novas contas criadas pelo cadastro existem apenas enquanto o app está aberto.

## Divisão de trabalho

- **Dev A:** `core/`, `providers/`, configuração Android
- **Dev B:** `ui/` (login, cadastro, formulário de chamado, telas do cliente e do prestador)

Regra: o Dev B altera apenas `lib/ui/`. Mudanças em `core/` ou `providers/`
são combinadas com o Dev A. As telas `tela_teste_*.dart` são provisórias e
servem de exemplo de uso.

## Observações técnicas

- `permission_handler` foi removido por exigir `compileSdk` 37, incompatível com o
  Android Gradle Plugin 9.1. Cada pacote pede a própria permissão.
- Dados de prestadores são fictícios (`mock_data.dart`), centrados em Teresina-PI.
- Os dados vivem apenas em memória: ao fechar o app, chamados e propostas se perdem.