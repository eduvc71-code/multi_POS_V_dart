import 'package:multi_p_o_s/flutter_flow/flutter_flow_charts.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_icon_button.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_widgets.dart';
import 'package:multi_p_o_s/components/button/button_widget.dart';
import 'package:multi_p_o_s/components/metric_card/metric_card_widget.dart';
import 'package:multi_p_o_s/components/pie_chart/pie_chart_widget.dart';
import 'package:multi_p_o_s/components/bottom_nav/bottom_nav_widget.dart';
import 'package:multi_p_o_s/components/bottom_nav_child4/bottom_nav_child4_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:fl_chart/fl_chart.dart';

import 'reportes_y_m_tricas_model.dart';
export 'reportes_y_m_tricas_model.dart';

@Preview()
Widget previewReportesYMetricas() {
  return const ReportesYMetricasWidget();
}

class ReportesYMetricasWidget extends StatefulWidget {
  const ReportesYMetricasWidget({super.key});

  static String routeName = 'ReportesYMetricas';
  static String routePath = '/reportesYMetricas';

  @override
  State<ReportesYMetricasWidget> createState() => _ReportesYMetricasWidgetState();
}

class _ReportesYMetricasWidgetState extends State<ReportesYMetricasWidget> {
  late ReportesYMetricasModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReportesYMetricasModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                shape: BoxShape.rectangle,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Reportes y Métricas',
                                style: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .copyWith(
                                  fontFamily: "Urbanist",
                                  color: FlutterFlowTheme.of(context)
                                      .primaryText,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w800,
                                  height: 1.25,
                                ),
                              ),
                              Text(
                                'Análisis de rendimiento del negocio',
                                style: FlutterFlowTheme.of(context)
                                    .bodySmall
                                    .copyWith(
                                  fontFamily: "Poppins",
                                  color: Colors.black,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                  height: 1.4,
                                ),
                              ),
                            ].divide(const SizedBox(height: 4)),
                          ),
                          FlutterFlowIconButton(
                            borderRadius: 24,
                            buttonSize: 40,
                            fillColor: FlutterFlowTheme.of(context).primary10,
                            icon: Icon(
                              Icons.download_rounded,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 24,
                            ),
                            onPressed: () {
                              debugPrint('IconButton pressed ...');
                            },
                          ),
                        ],
                      ),
                    ),
                  Container(
                    height: 1,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).alternate,
                      shape: BoxShape.rectangle,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                primary: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24),
                    child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(9999),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16, 4, 16, 4),
                                child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.calendar_today_rounded,
                                            color: Colors.black,
                                            size: 18,
                                          ),
                                          Text(
                                            'Últimos 30 días',
                                            style: FlutterFlowTheme.of(context)
                                                .labelLarge
                                                .copyWith(
                                              fontFamily: "Space Grotesk",
                                              color: FlutterFlowTheme.of(
                                                  context)
                                                  .primaryText,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .labelLarge
                                                  .fontWeight,
                                              height: 1.3,
                                            ),
                                          ),
                                        ].divide(const SizedBox(width: 8)),
                                      ),
                                      wrapWithModel(
                                        model: _model.buttonModel1,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: ButtonWidget(
                                          iconPresent: false,
                                          iconEndPresent: false,
                                          content: 'Cambiar',
                                          variant: 'ghost',
                                          size: 'small',
                                          fullWidth: false,
                                          loading: false,
                                          disabled: false,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: wrapWithModel(
                                    model: _model.metricCardModel1,
                                    updateCallback: () => safeSetState(() {}),
                                    child: MetricCardWidget(
                                      delta: '+12.5%',
                                      icon: Icon(
                                        Icons.payments_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 20,
                                      ),
                                      label: 'Ventas Totales',
                                      tone:
                                      FlutterFlowTheme.of(context).primary,
                                      value: 'Bs. 42.850',
                                      isUp: true,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: wrapWithModel(
                                    model: _model.metricCardModel2,
                                    updateCallback: () => safeSetState(() {}),
                                    child: MetricCardWidget(
                                      delta: '+8.2%',
                                      icon: Icon(
                                        Icons.insights_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        size: 20,
                                      ),
                                      label: 'Rentabilidad',
                                      tone: FlutterFlowTheme.of(context)
                                          .secondary,
                                      value: 'Bs. 12.400',
                                      isUp: true,
                                    ),
                                  ),
                                ),
                              ].divide(const SizedBox(width: 16)),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(24),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Ventas por Periodo',
                                            style: FlutterFlowTheme.of(context)
                                                .titleMedium
                                                .copyWith(
                                              fontFamily: "Urbanist",
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              height: 1.4,
                                            ),
                                          ),
                                          Icon(
                                            Icons.more_horiz_rounded,
                                            color: Colors.black,
                                            size: 24,
                                          ),
                                        ],
                                      ),
                                      Container(
                                        height: 200,
                                        child: Container(
                                          height: 200,
                                          child: FlutterFlowLineChart(
                                            data: [
                                              FFLineChartData(
                                                xData: [
                                                  0.0,
                                                  1.0,
                                                  2.0,
                                                  3.0,
                                                  4.0,
                                                  5.0,
                                                  6.0
                                                ],
                                                yData: [
                                                  1200.0,
                                                  1800.0,
                                                  1500.0,
                                                  2200.0,
                                                  2800.0,
                                                  2400.0,
                                                  3100.0
                                                ],
                                                settings: LineChartBarData(
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .primary,
                                                  barWidth: 3,
                                                  isCurved: true,
                                                  belowBarData: BarAreaData(
                                                    show: true,
                                                    color: FlutterFlowTheme.of(
                                                        context)
                                                        .primary10,
                                                  ),
                                                ),
                                              )
                                            ],
                                            chartStylingInfo: ChartStylingInfo(
                                              backgroundColor:
                                              Colors.transparent,
                                              showBorder: false,
                                            ),
                                            axisBounds: AxisBounds(
                                              minX: 0,
                                              minY: 0,
                                              maxX: 6,
                                              maxY: 3720,
                                            ),
                                            xLabels: [
                                              'Sem 1',
                                              'Sem 2',
                                              'Sem 3',
                                              'Sem 4',
                                              'Sem 5',
                                              'Sem 6',
                                              'Sem 7'
                                            ],
                                            xAxisLabelInfo: AxisLabelInfo(
                                              showLabels: true,
                                              labelTextStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodySmall
                                                  .copyWith(
                                                fontFamily: "Poppins",
                                                color: Colors.black,
                                                fontSize: 10,
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                FlutterFlowTheme.of(
                                                    context)
                                                    .bodySmall
                                                    .fontWeight,
                                                height: 1,
                                              ),
                                              reservedSize: 28,
                                            ),
                                            yAxisLabelInfo: AxisLabelInfo(
                                              reservedSize: 0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ].divide(const SizedBox(height: 16)),
                                  ),
                                ),
                              ),
                            Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(24),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        'Ventas por Categoria',
                                        style: FlutterFlowTheme.of(context)
                                            .titleMedium
                                            .copyWith(
                                          fontFamily: "Urbanist",
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.bold,
                                          height: 1.4,
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.pieChartModel,
                                        updateCallback: () =>
                                            safeSetState(() {}),
                                        child: PieChartWidget(
                                          centerValue: '',
                                          centerValuePresent: false,
                                          centerLabel: '',
                                          centerLabelPresent: false,
                                          data: '45,25,15,10,5',
                                          labels:
                                          'Ferretería,Autopartes,Tienda,Farmacia,Otros',
                                          colors:
                                          '#0066FF,#FF2D87,#FFE500,#00C853,#9C27B0',
                                          animate: false,
                                          startAngle: -90.0,
                                          variant: 'donut',
                                          size: 'medium',
                                          legend: 'right',
                                          legendValue: 'percent',
                                          ring: 'thick',
                                          gap: 'normal',
                                        ),
                                      ),
                                    ].divide(const SizedBox(height: 16)),
                                  ),
                                ),
                              ),
                            Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(24),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Productos más vendidos',
                                            style: FlutterFlowTheme.of(context)
                                                .titleMedium
                                                .copyWith(
                                              fontFamily: "Urbanist",
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              height: 1.4,
                                            ),
                                          ),
                                          wrapWithModel(
                                            model: _model.buttonModel2,
                                            updateCallback: () =>
                                                safeSetState(() {}),
                                            child: ButtonWidget(
                                              iconPresent: false,
                                              iconEndPresent: false,
                                              content: 'Ver todos',
                                              variant: 'ghost',
                                              size: 'small',
                                              fullWidth: false,
                                              loading: false,
                                              disabled: false,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .accent20,
                                                  borderRadius:
                                                  BorderRadius.circular(12),
                                                  shape: BoxShape.rectangle,
                                                ),
                                                alignment:
                                                const AlignmentDirectional(0, 0),
                                                child: Icon(
                                                  Icons.construction_rounded,
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .onAccent,
                                                  size: 24,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Column(
                                                  mainAxisSize:
                                                  MainAxisSize.min,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Taladro Percutor 1/2',
                                                      maxLines: 1,
                                                      style: FlutterFlowTheme
                                                          .of(context)
                                                          .bodyMedium
                                                          .copyWith(
                                                        fontFamily: "Poppins",
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        height: 1.5,
                                                      ),
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      '84 unidades vendidas',
                                                      style:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .labelSmall
                                                          .copyWith(
                                                        fontFamily: "Space Grotesk",
                                                        color: Colors.black,
                                                        letterSpacing:
                                                        0.0,
                                                        fontWeight: FlutterFlowTheme.of(
                                                            context)
                                                            .labelSmall
                                                            .fontWeight,
                                                        height: 1.2,
                                                      ),
                                                    ),
                                                  ].divide(const SizedBox(height: 4)),
                                                ),
                                              ),
                                              Text(
                                                'Bs. 12.600',
                                                style: FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .copyWith(
                                                  fontFamily: "Poppins",
                                                  color:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .primaryText,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  height: 1.5,
                                                ),
                                              ),
                                            ].divide(const SizedBox(width: 16)),
                                          ),
                                          Divider(
                                            height: 16,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                            color: FlutterFlowTheme.of(context)
                                                .alternate,
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .primary20,
                                                  borderRadius:
                                                  BorderRadius.circular(12),
                                                  shape: BoxShape.rectangle,
                                                ),
                                                alignment:
                                                const AlignmentDirectional(0, 0),
                                                child: Icon(
                                                  Icons
                                                      .settings_input_component_rounded,
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .onPrimary,
                                                  size: 24,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Column(
                                                  mainAxisSize:
                                                  MainAxisSize.min,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Aceite Sintético 5W30',
                                                      maxLines: 1,
                                                      style: FlutterFlowTheme
                                                          .of(context)
                                                          .bodyMedium
                                                          .copyWith(
                                                        fontFamily: "Poppins",
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        height: 1.5,
                                                      ),
                                                      overflow:
                                                      TextOverflow.ellipsis,
                                                    ),
                                                    Text(
                                                      '62 unidades vendidas',
                                                      style:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .labelSmall
                                                          .copyWith(
                                                        fontFamily: "Space Grotesk",
                                                        color: Colors.black,
                                                        letterSpacing:
                                                        0.0,
                                                        fontWeight: FlutterFlowTheme.of(
                                                            context)
                                                            .labelSmall
                                                            .fontWeight,
                                                        height: 1.2,
                                                      ),
                                                    ),
                                                  ].divide(const SizedBox(height: 4)),
                                                ),
                                              ),
                                              Text(
                                                'Bs. 9.300',
                                                style: FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .copyWith(
                                                  fontFamily: "Poppins",
                                                  color:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .primaryText,
                                                  letterSpacing: 0.0,
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  height: 1.5,
                                                ),
                                              ),
                                            ].divide(const SizedBox(width: 16)),
                                          ),
                                        ].divide(const SizedBox(height: 16)),
                                      ),
                                    ].divide(const SizedBox(height: 16)),
                                  ),
                                ),
                              ),
                            Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).primary5,
                                borderRadius: BorderRadius.circular(24),
                                shape: BoxShape.rectangle,
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).primary20,
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(24),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        borderRadius:
                                        BorderRadius.circular(9999),
                                        shape: BoxShape.rectangle,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Icon(
                                          Icons.description_rounded,
                                          color:
                                          FlutterFlowTheme.of(context)
                                              .onPrimary,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Exportar Informe Profesional',
                                            style: FlutterFlowTheme.of(
                                                context)
                                                .titleSmall
                                                .copyWith(
                                              fontFamily: "Urbanist",
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              height: 1.4,
                                            ),
                                          ),
                                          Text(
                                            'PDF con gráficos y tablas detalladas',
                                            style:
                                            FlutterFlowTheme.of(context)
                                                .labelSmall
                                                .copyWith(
                                              fontFamily: "Space Grotesk",
                                              color:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .primaryText,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .labelSmall
                                                  .fontWeight,
                                              height: 1.2,
                                            ),
                                          ),
                                        ].divide(const SizedBox(height: 4)),
                                      ),
                                    ),
                                    wrapWithModel(
                                      model: _model.buttonModel3,
                                      updateCallback: () =>
                                          safeSetState(() {}),
                                      child: ButtonWidget(
                                        iconPresent: false,
                                        iconEndPresent: false,
                                        content: 'Generar',
                                        variant: 'primary',
                                        size: 'medium',
                                        fullWidth: false,
                                        loading: false,
                                        disabled: false,
                                      ),
                                    ),
                                  ].divide(const SizedBox(width: 16)),
                                ),
                              ),
                            ),
                          ].divide(const SizedBox(height: 24)),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(0, 1),
              child: wrapWithModel(
                  model: _model.bottomNavModel,
                  updateCallback: () => safeSetState(() {}),
                  child: BottomNavWidget(
                    child: () => const BottomNavChild4Widget(),
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}
