import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

import 'business_card_model.dart';
export 'business_card_model.dart';

class BusinessCardWidget extends StatefulWidget {
  const BusinessCardWidget({
    super.key,
    String? name,
    String? type,
    bool? isActive,
    this.isActiveSlot,
  })  : name = name ?? 'Ferretería El Tornillo',
        type = type ?? 'Ferretería',
        isActive = isActive ?? true;

  final String name;
  final String type;
  final bool isActive;
  final Widget Function()? isActiveSlot;

  @override
  State<BusinessCardWidget> createState() => _BusinessCardWidgetState();
}

class _BusinessCardWidgetState extends State<BusinessCardWidget> {
  late BusinessCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BusinessCardModel());
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
        color: valueOrDefault<Color>(
          valueOrDefault<bool>(
            widget.isActive,
            true,
          )
              ? FlutterFlowTheme.of(context).primary10
              : FlutterFlowTheme.of(context).secondaryBackground,
          FlutterFlowTheme.of(context).primary10,
        ),
        borderRadius: BorderRadius.circular(24),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: valueOrDefault<Color>(
            valueOrDefault<bool>(
              widget.isActive,
              true,
            )
                ? FlutterFlowTheme.of(context).primary
                : FlutterFlowTheme.of(context).alternate,
            FlutterFlowTheme.of(context).primary,
          ),
          width: valueOrDefault<double>(
            valueOrDefault<bool>(
              widget.isActive,
              true,
            )
                ? 2.0
                : 2.0,
            2.0,
          ),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: valueOrDefault<Color>(
                    valueOrDefault<bool>(
                      widget.isActive,
                      true,
                    )
                        ? FlutterFlowTheme.of(context).primary
                        : FlutterFlowTheme.of(context).secondaryBackground,
                    FlutterFlowTheme.of(context).primary,
                  ),
                  shape: BoxShape.circle,
                ),
                alignment: AlignmentDirectional(0, 0),
                child: Text(
                  'MN',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: FlutterFlowTheme.of(context).labelMedium.copyWith(
                        fontFamily: "Space Grotesk",
                        color: valueOrDefault<Color>(
                          valueOrDefault<bool>(
                            widget.isActive,
                            true,
                          )
                              ? FlutterFlowTheme.of(context).onPrimary
                              : FlutterFlowTheme.of(context).primaryText,
                          FlutterFlowTheme.of(context).onPrimary,
                        ),
                        fontSize: 18.24,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w600,
                        fontStyle:
                            FlutterFlowTheme.of(context).labelMedium.fontStyle,
                        height: 1.3,
                        overflow: TextOverflow.clip,
                      ),
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
                        widget.name,
                        'Ferretería El Tornillo',
                      ),
                      style: FlutterFlowTheme.of(context).titleMedium.copyWith(
                            fontFamily: "Urbanist",
                            color: FlutterFlowTheme.of(context).primaryText,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            height: 1.4,
                          ),
                    ),
                    Text(
                      valueOrDefault<String>(
                        widget.type,
                        'Ferretería',
                      ),
                      style: FlutterFlowTheme.of(context).labelSmall.copyWith(
                            fontFamily: "Space Grotesk",
                            color: FlutterFlowTheme.of(context).secondaryText,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                            height: 1.2,
                          ),
                    ),
                  ].divide(SizedBox(height: 4)),
                ),
              ),
              Builder(builder: (_) {
                return widget.isActiveSlot != null
                    ? widget.isActiveSlot!()
                    : SizedBox.shrink();
              }),
              Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).success,
                  borderRadius: BorderRadius.circular(9999),
                  shape: BoxShape.rectangle,
                ),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 4, 16, 4),
                  child: Container(
                    child: Text(
                      'ACTIVA',
                      style: FlutterFlowTheme.of(context).labelSmall.copyWith(
                            fontFamily: "Space Grotesk",
                            color: FlutterFlowTheme.of(context).onSuccess,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                    ),
                  ),
                ),
              ),
            ].divide(SizedBox(width: 16)),
          ),
        ),
      ),
    );
  }
}
