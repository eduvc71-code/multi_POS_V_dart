import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:multi_p_o_s/database/database_helper.dart';
import 'flutter_flow/flutter_flow_localizations.dart';
import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Configuración para Edge-to-Edge (detrás de los botones nativos)
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  
  // Habilitar modo Edge-to-Edge
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  
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

class AppInitializerWidget extends StatefulWidget {
  const AppInitializerWidget({super.key});

  @override
  State<AppInitializerWidget> createState() => _AppInitializerWidgetState();
}

class _AppInitializerWidgetState extends State<AppInitializerWidget> {
  @override
  void initState() {
    super.initState();
    _checkAppState();
  }

  Future<void> _checkAppState() async {
    try {
      final dbHelper = DatabaseHelper.instance;
      final hasCompany = await dbHelper.hasAnyCompany();

      if (!mounted) return;

      if (!hasCompany) {
        // No hay empresa registrada en este dispositivo -> Ir al registro
        context.goNamed(RegistroDeNegocioWidget.routeName);
      } else {
        // Ya hay una empresa registrada -> Iniciar SIEMPRE en Login para probar roles (admin, cajero, vendedor)
        context.goNamed(InicioDeSesionWidget.routeName);
      }
    } catch (e) {
      if (mounted) {
        context.goNamed(InicioDeSesionWidget.routeName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      errorBuilder: (context, state) => const AppInitializerWidget(),
      routes: [
        GoRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => const AppInitializerWidget(),
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
