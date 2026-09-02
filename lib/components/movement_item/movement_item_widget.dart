import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

import 'movement_item_model.dart';
export 'movement_item_model.dart';

class MovementItemWidget extends StatefulWidget {
  const MovementItemWidget({
    super.key,
    String? amount,
    String? time,
    Color? tone,
    String? type,
  })  : amount = amount ?? '+ Bs. 150,00',
        time = time ?? '10:45 AM',
        tone = tone ?? const Color(0x00000000),
        type = type ?? 'Venta #1024';

  final String amount;
  final String time;
  final Color tone;
  final String type;

  @override
  State<MovementItemWidget> createState() => _MovementItemWidgetState();
}

class _MovementItemWidgetState extends State<MovementItemWidget> {
  late MovementItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MovementItemModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: valueOrDefault<Color>(
                        widget.tone,
                        FlutterFlowTheme.of(context).success,
                      ),
                      borderRadius: BorderRadius.circular(9999),
                      shape: BoxShape.rectangle,
                    ),
                    child: Icon(
                      Icons.arrow_downward_rounded,
                      color: valueOrDefault<Color>(
                        widget.tone,
                        FlutterFlowTheme.of(context).success,
                      ),
                      size: 20,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          valueOrDefault<String>(
                            widget.type,
                            'Venta #1024',
                          ),
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .copyWith(
                                fontFamily: "Poppins",
                                color: FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                height: 1.5,
                              ),
                        ),
                        Text(
                          valueOrDefault<String>(
                            widget.time,
                            '10:45 AM',
                          ),
                          style: FlutterFlowTheme.of(context)
                              .labelSmall
                              .copyWith(
                                fontFamily: "Space Grotesk",
                                color: Colors.black,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                                height: 1.2,
                              ),
                        ),
                      ].divide(const SizedBox(height: 4)),
                    ),
                  ),
                  Text(
                    valueOrDefault<String>(
                      widget.amount,
                      '+ Bs. 150,00',
                    ),
                    style: FlutterFlowTheme.of(context).titleSmall.copyWith(
                          fontFamily: "Urbanist",
                          color: widget.tone,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.bold,
                          fontStyle:
                              FlutterFlowTheme.of(context).titleSmall.fontStyle,
                          height: 1.4,
                        ),
                  ),
                ].divide(const SizedBox(width: 16)),
              ),
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
    );
  }
}
