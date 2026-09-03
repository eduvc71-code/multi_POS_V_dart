import 'package:multi_p_o_s/flutter_flow/flutter_flow_icon_button.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/pages/panel_principal/panel_principal_widget.dart';
import 'package:multi_p_o_s/database/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import 'gesti_n_de_caja_model.dart';
export 'gesti_n_de_caja_model.dart';

@Preview()
Widget previewGestionDeCaja() {
  return const GestionDeCajaWidget();
}

class GestionDeCajaWidget extends StatefulWidget {
  const GestionDeCajaWidget({super.key});

  static String routeName = 'GestionDeCaja';
  static String routePath = '/gestionDeCaja';

  @override
  State<GestionDeCajaWidget> createState() => _GestionDeCajaWidgetState();
}

class _GestionDeCajaWidgetState extends State<GestionDeCajaWidget> {
  late GestionDeCajaModel _model;
  Map<String, dynamic>? _sesionActiva;
  List<Map<String, dynamic>> _movimientos = [];
  bool _isLoading = true;

  double _montoInicial = 0.0;
  double _totalIngresos = 0.0;
  double _totalEgresos = 0.0;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => GestionDeCajaModel());
    _loadCajaData();
  }

  Future<void> _loadCajaData() async {
    final sesion = await DatabaseHelper.instance.getCajaSesionActiva();
    final movs = await DatabaseHelper.instance.readAllMovimientosCaja();

    double ing = 0.0;
    double egr = 0.0;
    double inicial = 0.0;

    if (sesion != null) {
      inicial = (sesion['monto_inicial'] as num?)?.toDouble() ?? 0.0;
      for (var m in movs) {
        final double monto = (m['monto'] as num?)?.toDouble() ?? 0.0;
        final String tipo = (m['tipo'] as String? ?? '').toUpperCase();
        if (tipo.contains('INGRESO') || tipo.contains('VENTA')) {
          ing += monto;
        } else if (tipo.contains('EGRESO') || tipo.contains('GASTO')) {
          egr += monto;
        }
      }
    }

    if (mounted) {
      setState(() {
        _sesionActiva = sesion;
        _movimientos = movs;
        _montoInicial = inicial;
        _totalIngresos = ing;
        _totalEgresos = egr;
        _isLoading = false;
      });
    }
  }

  double get _montoEsperado => _montoInicial + _totalIngresos - _totalEgresos;

  Future<void> _handleAbrirCaja() async {
    final montoCtrl = TextEditingController(text: '100.00');

    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.lock_open_rounded, color: Color(0xFF0066FF)),
            SizedBox(width: 8),
            Text('Apertura de Caja', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Ingrese el saldo inicial en efectivo para abrir el turno:', style: TextStyle(fontSize: 12)),
            const SizedBox(height: 12),
            TextField(
              controller: montoCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Saldo Inicial (Bs.) *',
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogCtx, false), child: const Text('Cancelar')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: FlutterFlowTheme.of(context).primary,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(dialogCtx, true),
            child: const Text('Abrir Turno'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final monto = double.tryParse(montoCtrl.text) ?? 0.0;
      try {
        await DatabaseHelper.instance.abrirCajaSesion(monto);
        await _loadCajaData();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Caja abierta con monto inicial de Bs. ${monto.toStringAsFixed(2)}'),
              backgroundColor: FlutterFlowTheme.of(context).success,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e'), backgroundColor: FlutterFlowTheme.of(context).error),
          );
        }
      }
    }
  }

  Future<void> _handleCerrarCaja() async {
    if (_sesionActiva == null) return;
    final int sesionId = _sesionActiva!['id'];
    final conteoCtrl = TextEditingController(text: _montoEsperado.toStringAsFixed(2));

    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogCtx) => StatefulBuilder(
        builder: (dialogCtx, setStateDialog) {
          final double conteo = double.tryParse(conteoCtrl.text) ?? 0.0;
          final double diferencia = conteo - _montoEsperado;

          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: const Row(
              children: [
                Icon(Icons.lock_clock_rounded, color: Colors.orange),
                SizedBox(width: 8),
                Text('Arqueo y Cierre de Caja', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Efectivo Esperado: Bs. ${_montoEsperado.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                const SizedBox(height: 12),
                TextField(
                  controller: conteoCtrl,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    labelText: 'Conteo Físico en Efectivo (Bs.) *',
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                  onChanged: (_) => setStateDialog(() {}),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: diferencia == 0 ? const Color(0x1A10B981) : (diferencia > 0 ? const Color(0x1A0066FF) : const Color(0x1AEF4444)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        diferencia == 0 ? 'Caja Cuadrada' : (diferencia > 0 ? 'Sobrante:' : 'Faltante:'),
                        style: TextStyle(fontWeight: FontWeight.bold, color: diferencia == 0 ? Colors.green.shade800 : (diferencia > 0 ? Colors.blue.shade800 : Colors.red)),
                      ),
                      Text(
                        'Bs. ${diferencia.abs().toStringAsFixed(2)}',
                        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15, color: diferencia == 0 ? Colors.green.shade800 : (diferencia > 0 ? Colors.blue.shade800 : Colors.red)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(dialogCtx, false), child: const Text('Cancelar')),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white),
                onPressed: () => Navigator.pop(dialogCtx, true),
                child: const Text('Confirmar Cierre'),
              ),
            ],
          );
        },
      ),
    );

    if (confirm == true) {
      final finalMonto = double.tryParse(conteoCtrl.text) ?? _montoEsperado;
      try {
        await DatabaseHelper.instance.cerrarCajaSesion(sesionId, finalMonto);
        await _loadCajaData();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Caja cerrada y arqueada exitosamente'),
              backgroundColor: FlutterFlowTheme.of(context).success,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al cerrar caja: $e'), backgroundColor: FlutterFlowTheme.of(context).error),
          );
        }
      }
    }
  }

  Future<void> _handleRegistrarMovimiento(bool esIngreso) async {
    if (_sesionActiva == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Debe abrir la caja para registrar movimientos')),
      );
      return;
    }

    final conceptoCtrl = TextEditingController();
    final montoCtrl = TextEditingController();

    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(esIngreso ? Icons.add_circle_outline_rounded : Icons.remove_circle_outline_rounded, color: esIngreso ? Colors.green : Colors.red),
            const SizedBox(width: 8),
            Text(esIngreso ? 'Registrar Ingreso' : 'Registrar Egreso / Gasto', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: conceptoCtrl,
              decoration: InputDecoration(
                labelText: esIngreso ? 'Concepto del Ingreso *' : 'Motivo del Egreso / Gasto *',
                border: const OutlineInputBorder(),
                isDense: true,
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: montoCtrl,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Monto (Bs.) *',
                border: OutlineInputBorder(),
                isDense: true,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogCtx, false), child: const Text('Cancelar')),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: esIngreso ? Colors.green : Colors.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(dialogCtx, true),
            child: Text(esIngreso ? 'Guardar Ingreso' : 'Guardar Egreso'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final concepto = conceptoCtrl.text.trim();
      final monto = double.tryParse(montoCtrl.text) ?? 0.0;

      if (concepto.isNotEmpty && monto > 0) {
        await DatabaseHelper.instance.createMovimientoCaja(
          tipo: esIngreso ? 'INGRESO_MANUAL' : 'EGRESO_MANUAL',
          monto: monto,
          descripcion: concepto,
        );
        await _loadCajaData();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${esIngreso ? "Ingreso" : "Egreso"} registrado por Bs. ${monto.toStringAsFixed(2)}'),
              backgroundColor: FlutterFlowTheme.of(context).success,
            ),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isCashOpen = _sesionActiva != null;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // CABECERA
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  border: Border(bottom: BorderSide(color: FlutterFlowTheme.of(context).alternate)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        FlutterFlowIconButton(
                          borderRadius: 8,
                          buttonSize: 36,
                          fillColor: Colors.transparent,
                          icon: Icon(Icons.arrow_back_rounded, color: FlutterFlowTheme.of(context).primaryText, size: 20),
                          onPressed: () => context.goNamed(PanelPrincipalWidget.routeName),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Gestión de Caja', style: FlutterFlowTheme.of(context).titleMedium.copyWith(fontWeight: FontWeight.bold)),
                            Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: isCashOpen ? Colors.green : Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  isCashOpen ? 'Turno Abierto · Inicial: Bs. ${_montoInicial.toStringAsFixed(2)}' : 'Caja Cerrada · Sin turno activo',
                                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isCashOpen ? Colors.orange : FlutterFlowTheme.of(context).primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: isCashOpen ? _handleCerrarCaja : _handleAbrirCaja,
                      icon: Icon(isCashOpen ? Icons.lock_clock_rounded : Icons.lock_open_rounded, size: 16),
                      label: Text(isCashOpen ? 'Cerrar Caja' : 'Abrir Caja', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                    ),
                  ],
                ),
              ),

              // CUERPO PRINCIPAL
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // HERO CARD - EFECTIVO ESPERADO
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: FlutterFlowTheme.of(context).alternate),
                                boxShadow: const [BoxShadow(blurRadius: 4, color: Color(0x11000000), offset: Offset(0, 2))],
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    isCashOpen ? 'EFECTIVO ESPERADO EN CAJA' : 'CAJA CERRADA',
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.0,
                                      color: isCashOpen ? Colors.grey.shade700 : Colors.red,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Bs. ${isCashOpen ? _montoEsperado.toStringAsFixed(2) : "0,00"}',
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.w900,
                                      color: FlutterFlowTheme.of(context).primary,
                                    ),
                                  ),
                                  if (isCashOpen) ...[
                                    const Divider(height: 24, thickness: 0.5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Column(
                                          children: [
                                            const Text('Ingresos / Ventas', style: TextStyle(fontSize: 10, color: Colors.grey)),
                                            Text('Bs. ${_totalIngresos.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.green)),
                                          ],
                                        ),
                                        Container(width: 1, height: 28, color: Colors.grey.shade300),
                                        Column(
                                          children: [
                                            const Text('Egresos / Gastos', style: TextStyle(fontSize: 10, color: Colors.grey)),
                                            Text('Bs. ${_totalEgresos.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.red)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ] else ...[
                                    const SizedBox(height: 16),
                                    ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: FlutterFlowTheme.of(context).primary,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                      ),
                                      onPressed: _handleAbrirCaja,
                                      icon: const Icon(Icons.lock_open_rounded, size: 18),
                                      label: const Text('Abrir Turno de Caja'),
                                    ),
                                  ],
                                ],
                              ),
                            ),

                            if (isCashOpen) ...[
                              const SizedBox(height: 16),

                              // BOTONES DE ACCIÓN (INGRESO / EGRESO)
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.green.shade800,
                                        side: BorderSide(color: Colors.green.shade400, width: 1.5),
                                        padding: const EdgeInsets.symmetric(vertical: 12),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      ),
                                      onPressed: () => _handleRegistrarMovimiento(true),
                                      icon: const Icon(Icons.add_circle_outline_rounded, size: 18),
                                      label: const Text('+ Ingreso Efectivo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.red.shade800,
                                        side: BorderSide(color: Colors.red.shade400, width: 1.5),
                                        padding: const EdgeInsets.symmetric(vertical: 12),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      ),
                                      onPressed: () => _handleRegistrarMovimiento(false),
                                      icon: const Icon(Icons.remove_circle_outline_rounded, size: 18),
                                      label: const Text('- Egreso / Gasto', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              // MOVIMIENTOS DEL DÍA
                              Text(
                                'Movimientos del Día',
                                style: FlutterFlowTheme.of(context).titleSmall.copyWith(
                                      fontFamily: "Urbanist",
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 8),

                              Container(
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: FlutterFlowTheme.of(context).alternate),
                                ),
                                child: _movimientos.isEmpty
                                    ? const Padding(
                                        padding: EdgeInsets.all(24.0),
                                        child: Center(
                                          child: Text('No hay movimientos de caja registrados hoy', style: TextStyle(color: Colors.grey, fontSize: 12)),
                                        ),
                                      )
                                    : ListView.separated(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: _movimientos.length,
                                        separatorBuilder: (_, __) => const Divider(height: 1, thickness: 0.5),
                                        itemBuilder: (ctx, index) {
                                          final m = _movimientos[index];
                                          final String tipo = (m['tipo'] as String? ?? 'INGRESO').toUpperCase();
                                          final double monto = (m['monto'] as num?)?.toDouble() ?? 0.0;
                                          final String desc = m['descripcion'] ?? 'Movimiento de Caja';
                                          final String fechaRaw = m['fecha'] ?? '';
                                          final String hora = fechaRaw.length >= 16 ? fechaRaw.substring(11, 16) : '--:--';

                                          final bool esIngreso = tipo.contains('INGRESO') || tipo.contains('VENTA');

                                          return ListTile(
                                            dense: true,
                                            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                                            leading: CircleAvatar(
                                              radius: 16,
                                              backgroundColor: esIngreso ? const Color(0x1A10B981) : const Color(0x1AEF4444),
                                              child: Icon(
                                                esIngreso ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded,
                                                color: esIngreso ? Colors.green : Colors.red,
                                                size: 16,
                                              ),
                                            ),
                                            title: Text(desc, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                            subtitle: Text(hora, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                                            trailing: Text(
                                              '${esIngreso ? "+" : "-"} Bs. ${monto.toStringAsFixed(2)}',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                                color: esIngreso ? Colors.green.shade800 : Colors.red.shade800,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                              ),
                            ],
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
