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
    // Generar iniciales dinámicas
    final words = widget.name.trim().split(' ');
    String initials = 'MP';
    if (words.length >= 2) {
      initials = '${words[0][0]}${words[1][0]}'.toUpperCase();
    } else if (words.isNotEmpty && words[0].isNotEmpty) {
      initials = words[0].substring(0, words[0].length >= 2 ? 2 : 1).toUpperCase();
    }

    return Container(
      decoration: BoxDecoration(
        color: widget.isActive
            ? FlutterFlowTheme.of(context).primary10
            : FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(16),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: widget.isActive
              ? FlutterFlowTheme.of(context).primary
              : FlutterFlowTheme.of(context).alternate,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: widget.isActive
                    ? FlutterFlowTheme.of(context).primary
                    : FlutterFlowTheme.of(context).secondaryBackground,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                initials,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: FlutterFlowTheme.of(context).titleSmall.copyWith(
                          fontFamily: "Urbanist",
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    widget.type,
                    style: FlutterFlowTheme.of(context).labelSmall.copyWith(
                          fontFamily: "Space Grotesk",
                          color: Colors.black54,
                          fontSize: 11,
                        ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).success,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                'ACTIVA',
                style: FlutterFlowTheme.of(context).labelSmall.copyWith(
                      fontFamily: "Space Grotesk",
                      color: FlutterFlowTheme.of(context).onSuccess,
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
