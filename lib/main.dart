import 'package:flutter/material.dart';
import 'flutter_flow/flutter_flow_localizations.dart';
import 'package:provider/provider.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],
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
      errorBuilder: (context, state) => InicioDeSesiNWidget(),
      routes: [
        GoRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) => InicioDeSesiNWidget(),
        ),
        GoRoute(
          name: 'InicioDeSesiN',
          path: '/inicioDeSesiN',
          builder: (context, _) => InicioDeSesiNWidget(),
        ),
        GoRoute(
          name: 'RegistroDeNegocio',
          path: '/registroDeNegocio',
          builder: (context, _) => RegistroDeNegocioWidget(),
        ),
        GoRoute(
          name: 'PanelPrincipal',
          path: '/panelPrincipal',
          builder: (context, _) => PanelPrincipalWidget(),
        ),
        GoRoute(
          name: 'PuntoDeVenta',
          path: '/puntoDeVenta',
          builder: (context, _) => PuntoDeVentaWidget(),
        ),
        GoRoute(
          name: 'GestiNDeCaja',
          path: '/gestiNDeCaja',
          builder: (context, _) => GestiNDeCajaWidget(),
        ),
        GoRoute(
          name: 'InventarioDeProductos',
          path: '/inventarioDeProductos',
          builder: (context, _) => InventarioDeProductosWidget(),
        ),
        GoRoute(
          name: 'HistorialDeVentas',
          path: '/historialDeVentas',
          builder: (context, _) => HistorialDeVentasWidget(),
        ),
        GoRoute(
          name: 'ClientesYCrDitos',
          path: '/clientesYCrDitos',
          builder: (context, _) => ClientesYCrDitosWidget(),
        ),
        GoRoute(
          name: 'ReportesYMTricas',
          path: '/reportesYMTricas',
          builder: (context, _) => ReportesYMTricasWidget(),
        ),
        GoRoute(
          name: 'ConfiguraciNYEmpresas',
          path: '/configuraciNYEmpresas',
          builder: (context, _) => ConfiguraciNYEmpresasWidget(),
        ),
      ],
    );
