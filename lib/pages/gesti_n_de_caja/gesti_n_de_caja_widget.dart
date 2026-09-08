import 'package:multi_p_o_s/flutter_flow/flutter_flow_icon_button.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/pages/panel_principal/panel_principal_widget.dart';
import 'package:multi_p_o_s/services/supabase_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:pluto_grid/pluto_grid.dart';

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
    final prefs = await SharedPreferences.getInstance();
    final empresaId = prefs.getInt('empresa_id') ?? 1;

    try {
      final sesion = await SupabaseService.instance.getCajaAbierta(empresaId);
      final movs = await SupabaseService.instance.fetchMovimientosCaja(
        empresaId,
        cajaSesionId: sesion != null ? (sesion['id'] as num).toInt() : null,
      );

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
    } catch (e) {
      debugPrint('Error al cargar datos de caja desde Supabase: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
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
        final prefs = await SharedPreferences.getInstance();
        final empresaId = prefs.getInt('empresa_id') ?? 1;
        final usuarioId = prefs.getInt('usuario_id');

        await SupabaseService.instance.abrirCaja(
          empresaId: empresaId,
          usuarioId: usuarioId,
          montoInicial: monto,
        );
        await _loadCajaData();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Caja abierta con monto inicial de ${formatBs(monto)}'),
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
                Text('Efectivo Esperado: ${formatBs(_montoEsperado)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
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
        await SupabaseService.instance.cerrarCaja(
          cajaSesionId: sesionId,
          montoFinal: finalMonto,
        );
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
        final prefs = await SharedPreferences.getInstance();
        final empresaId = prefs.getInt('empresa_id') ?? 1;
        final usuarioId = prefs.getInt('usuario_id');
        final int? cajaSesionId = _sesionActiva != null ? (_sesionActiva!['id'] as num).toInt() : null;

        await SupabaseService.instance.insertMovimientoCaja(
          empresaId: empresaId,
          usuarioId: usuarioId,
          cajaSesionId: cajaSesionId,
          tipo: esIngreso ? 'INGRESO_MANUAL' : 'EGRESO_MANUAL',
          monto: monto,
          descripcion: concepto,
        );
        await _loadCajaData();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${esIngreso ? "Ingreso" : "Egreso"} registrado por ${formatBs(monto)}'),
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

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        context.goNamed(PanelPrincipalWidget.routeName);
      },
      child: GestureDetector(
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
                    Expanded(
                      child: Row(
                        children: [
                          FlutterFlowIconButton(
                            borderRadius: 8,
                            buttonSize: 36,
                            fillColor: Colors.transparent,
                            icon: Icon(Icons.arrow_back_rounded, color: FlutterFlowTheme.of(context).primaryText, size: 20),
                            onPressed: () => context.goNamed(PanelPrincipalWidget.routeName),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Gestión de Caja', style: FlutterFlowTheme.of(context).titleMedium.copyWith(fontWeight: FontWeight.bold), overflow: TextOverflow.ellipsis),
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
                                    Expanded(
                                      child: Text(
                                        isCashOpen ? 'Turno Abierto · Inicial: ${formatBs(_montoInicial)}' : 'Caja Cerrada · Sin turno activo',
                                        style: const TextStyle(fontSize: 11, color: Colors.grey),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
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
                    : Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // HERO CARD - EFECTIVO ESPERADO (MINIMIZADO)
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: FlutterFlowTheme.of(context).alternate),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        isCashOpen ? Icons.account_balance_wallet_rounded : Icons.lock_outline_rounded,
                                        size: 20,
                                        color: isCashOpen ? FlutterFlowTheme.of(context).primary : Colors.red,
                                      ),
                                      const SizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            isCashOpen ? 'EFECTIVO ESPERADO' : 'CAJA CERRADA',
                                            style: TextStyle(
                                              fontSize: 9,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.5,
                                              color: isCashOpen ? Colors.grey.shade700 : Colors.red,
                                            ),
                                          ),
                                          Text(
                                            isCashOpen ? formatBs(_montoEsperado) : 'Bs. 0,00',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w900,
                                              color: FlutterFlowTheme.of(context).primaryText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  if (isCashOpen)
                                    Row(
                                      children: [
                                        const Text('Ing: ', style: TextStyle(fontSize: 11, color: Colors.grey)),
                                        Text(formatBs(_totalIngresos), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.green)),
                                        const SizedBox(width: 8),
                                        const Text('Egr: ', style: TextStyle(fontSize: 11, color: Colors.grey)),
                                        Text(formatBs(_totalEgresos), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.red)),
                                      ],
                                    )
                                  else
                                    TextButton.icon(
                                      style: TextButton.styleFrom(
                                        foregroundColor: FlutterFlowTheme.of(context).primary,
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        minimumSize: Size.zero,
                                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      onPressed: _handleAbrirCaja,
                                      icon: const Icon(Icons.lock_open_rounded, size: 14),
                                      label: const Text('Abrir Turno', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                                    ),
                                ],
                              ),
                            ),

                            if (isCashOpen) ...[
                              const SizedBox(height: 8),

                              // BOTONES DE ACCIÓN (INGRESO / EGRESO)
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.green.shade800,
                                        side: BorderSide(color: Colors.green.shade400, width: 1.5),
                                        padding: const EdgeInsets.symmetric(vertical: 8),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                      ),
                                      onPressed: () => _handleRegistrarMovimiento(true),
                                      icon: const Icon(Icons.add_circle_outline_rounded, size: 16),
                                      label: const Text('+ Ingreso Efectivo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: OutlinedButton.icon(
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.red.shade800,
                                        side: BorderSide(color: Colors.red.shade400, width: 1.5),
                                        padding: const EdgeInsets.symmetric(vertical: 8),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                      ),
                                      onPressed: () => _handleRegistrarMovimiento(false),
                                      icon: const Icon(Icons.remove_circle_outline_rounded, size: 16),
                                      label: const Text('- Egreso / Gasto', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
                                    ),
                                  ),
                                ],
                              ),
                            ],

                            const SizedBox(height: 12),

                            // MOVIMIENTOS DEL DÍA CON PLUTOGRID
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Movimientos del Día',
                                  style: FlutterFlowTheme.of(context).titleSmall.copyWith(
                                        fontFamily: "Urbanist",
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  '${_movimientos.length} registros',
                                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(color: FlutterFlowTheme.of(context).alternate),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: PlutoGrid(
                                    columns: [
                                      PlutoColumn(
                                        title: 'Hora',
                                        field: 'hora',
                                        type: PlutoColumnType.text(),
                                        width: 80,
                                        enableRowChecked: false,
                                        enableEditingMode: false,
                                        enableSorting: false,
                                      ),
                                      PlutoColumn(
                                        title: 'Tipo',
                                        field: 'tipo',
                                        type: PlutoColumnType.text(),
                                        width: 90,
                                        enableEditingMode: false,
                                        renderer: (rendererContext) {
                                          final tipo = rendererContext.cell.value.toString();
                                          final esIngreso = tipo.contains('INGRESO') || tipo.contains('VENTA');
                                          return Text(
                                            tipo,
                                            style: TextStyle(
                                              color: esIngreso ? Colors.green.shade700 : Colors.red.shade700,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          );
                                        },
                                      ),
                                      PlutoColumn(
                                        title: 'Descripción',
                                        field: 'descripcion',
                                        type: PlutoColumnType.text(),
                                        width: 150,
                                        enableEditingMode: false,
                                      ),
                                      PlutoColumn(
                                        title: 'Monto (Bs)',
                                        field: 'monto',
                                        type: PlutoColumnType.number(format: '#,##0.00'),
                                        width: 100,
                                        textAlign: PlutoColumnTextAlign.right,
                                        titleTextAlign: PlutoColumnTextAlign.right,
                                        enableEditingMode: false,
                                      ),
                                    ],
                                    rows: _movimientos.map((m) {
                                      final String tipo = (m['tipo'] as String? ?? 'INGRESO').toUpperCase();
                                      final double monto = (m['monto'] as num?)?.toDouble() ?? 0.0;
                                      final String desc = m['descripcion'] ?? 'Movimiento';
                                      final String fechaRaw = m['fecha'] ?? '';
                                      final String hora = fechaRaw.length >= 16 ? fechaRaw.substring(11, 16) : '--:--';

                                      return PlutoRow(cells: {
                                        'hora': PlutoCell(value: hora),
                                        'tipo': PlutoCell(value: tipo),
                                        'descripcion': PlutoCell(value: desc),
                                        'monto': PlutoCell(value: monto),
                                      });
                                    }).toList(),
                                    configuration: const PlutoGridConfiguration(
                                      style: PlutoGridStyleConfig(
                                        gridBorderColor: Colors.transparent,
                                        columnTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                        cellTextStyle: TextStyle(fontSize: 13),
                                        rowHeight: 40,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
}
