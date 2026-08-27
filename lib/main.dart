import 'package:flutter/material.dart';
import 'flutter_flow/flutter_flow_localizations.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();

  static MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<MyAppState>()!;
}

class MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;

  @override
  void initState() {
    super.initState();
    _appStateNotifier = AppStateNotifier.instance;
    _router = createRouter(_appStateNotifier);
  }

  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MultiPOS',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', ''),
        Locale('en', ''),
      ],
      theme: ThemeData(brightness: Brightness.light),
      themeMode: _themeMode,
      routerConfig: _router,
    );
  }
}

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();
  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  bool showSplashImage = true;

  void stopShowSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, state) => const InicioDeSesionWidget(),
      routes: [
        GoRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => const InicioDeSesionWidget(),
        ),
        GoRoute(
          name: 'InicioDeSesion',
          path: '/inicioDeSesion',
          builder: (context, _) => const InicioDeSesionWidget(),
        ),
        GoRoute(
          name: 'RegistroDeNegocio',
          path: '/registroDeNegocio',
          builder: (context, _) => const RegistroDeNegocioWidget(),
        ),
        GoRoute(
          name: 'PanelPrincipal',
          path: '/panelPrincipal',
          builder: (context, _) => const PanelPrincipalWidget(),
        ),
        GoRoute(
          name: 'PuntoDeVenta',
          path: '/puntoDeVenta',
          builder: (context, _) => const PuntoDeVentaWidget(),
        ),
        GoRoute(
          name: 'GestionDeCaja',
          path: '/gestionDeCaja',
          builder: (context, _) => const GestionDeCajaWidget(),
        ),
        GoRoute(
          name: 'InventarioDeProductos',
          path: '/inventarioDeProductos',
          builder: (context, _) => const InventarioDeProductosWidget(),
        ),
        GoRoute(
          name: 'HistorialDeVentas',
          path: '/historialDeVentas',
          builder: (context, _) => const HistorialDeVentasWidget(),
        ),
        GoRoute(
          name: 'ClientesYCreditos',
          path: '/clientesYCreditos',
          builder: (context, _) => const ClientesYCreditosWidget(),
        ),
        GoRoute(
          name: 'ReportesYMetricas',
          path: '/reportesYMetricas',
          builder: (context, _) => const ReportesYMetricasWidget(),
        ),
        GoRoute(
          name: 'ConfiguracionYEmpresas',
          path: '/configuracionYEmpresas',
          builder: (context, _) => const ConfiguracionYEmpresasWidget(),
        ),
      ],
    );
