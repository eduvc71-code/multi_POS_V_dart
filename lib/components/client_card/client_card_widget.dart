import 'package:multi_p_o_s/flutter_flow/flutter_flow_icon_button.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

import 'client_card_model.dart';
export 'client_card_model.dart';

class ClientCardWidget extends StatefulWidget {
  const ClientCardWidget({
    super.key,
    String? debt,
    String? name,
    bool? isOverdue,
  })  : debt = debt ?? 'Bs. 450,00',
        name = name ?? 'Carlos Rodríguez',
        isOverdue = isOverdue ?? false;

  final String debt;
  final String name;
  final bool isOverdue;

  @override
  State<ClientCardWidget> createState() => _ClientCardWidgetState();
}

class _ClientCardWidgetState extends State<ClientCardWidget> {
  late ClientCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClientCardModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(24),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primary10,
                shape: BoxShape.circle,
              ),
              alignment: const AlignmentDirectional(0, 0),
              child: Text(
                'JD',
                textAlign: TextAlign.center,
                maxLines: 1,
                style: FlutterFlowTheme.of(context).labelMedium.copyWith(
                      fontFamily: "Space Grotesk",
                      color: FlutterFlowTheme.of(context).primary,
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                      overflow: TextOverflow.clip,
                    ),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    valueOrDefault<String>(
                      widget.name,
                      'Carlos Rodríguez',
                    ),
                    style: FlutterFlowTheme.of(context).bodyLarge.copyWith(
                          fontFamily: "Poppins",
                          color: FlutterFlowTheme.of(context).primaryText,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                        ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Deuda:',
                        style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                              fontFamily: "Poppins",
                              color: FlutterFlowTheme.of(context).secondaryText,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context).bodySmall.fontWeight,
                              height: 1.4,
                            ),
                      ),
                      Text(
                        valueOrDefault<String>(
                          widget.debt,
                          'Bs. 450,00',
                        ),
                        style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                              fontFamily: "Poppins",
                              color: widget.isOverdue
                                  ? FlutterFlowTheme.of(context).error
                                  : FlutterFlowTheme.of(context).primaryText,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                              height: 1.4,
                            ),
                      ),
                    ].divide(const SizedBox(width: 4)),
                  ),
                ].divide(const SizedBox(height: 4)),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FlutterFlowIconButton(
                  borderRadius: 9999,
                  buttonSize: 40,
                  fillColor: FlutterFlowTheme.of(context).primary10,
                  icon: Icon(
                    Icons.qr_code_2_rounded,
                    color: FlutterFlowTheme.of(context).primary,
                    size: 24,
                  ),
                  onPressed: () {
                    debugPrint('IconButton pressed ...');
                  },
                ),
                Text(
                  'Ver detalle',
                  style: FlutterFlowTheme.of(context).labelSmall.copyWith(
                        fontFamily: "Space Grotesk",
                        color: FlutterFlowTheme.of(context).secondaryText,
                        letterSpacing: 0.0,
                        fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                        height: 1.2,
                      ),
                ),
              ].divide(const SizedBox(height: 8)),
            ),
          ].divide(const SizedBox(width: 16)),
        ),
      ),
    );
  }
}