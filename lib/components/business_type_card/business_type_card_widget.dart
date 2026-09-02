import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

import 'business_type_card_model.dart';
export 'business_type_card_model.dart';

class BusinessTypeCardWidget extends StatefulWidget {
  const BusinessTypeCardWidget({
    super.key,
    Color? color,
    this.icon,
    String? title,
    bool? selected,
    this.onTap,
  })  : color = color ?? const Color(0x00000000),
        title = title ?? 'Tienda',
        selected = selected ?? true;

  final Color color;
  final Widget? icon;
  final String title;
  final bool selected;
  final VoidCallback? onTap;

  @override
  State<BusinessTypeCardWidget> createState() => _BusinessTypeCardWidgetState();
}

class _BusinessTypeCardWidgetState extends State<BusinessTypeCardWidget> {
  late BusinessTypeCardModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BusinessTypeCardModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isSelected = widget.selected;
    final Color cardColor = widget.color == const Color(0x00000000)
        ? FlutterFlowTheme.of(context).primary
        : widget.color;

    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected
              ? cardColor.withValues(alpha: 0.08)
              : FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(16),
          shape: BoxShape.rectangle,
          border: Border.all(
            color: isSelected
                ? cardColor
                : FlutterFlowTheme.of(context).alternate,
            width: isSelected ? 2.0 : 1.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: cardColor.withValues(alpha: isSelected ? 0.2 : 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: widget.icon ?? Icon(
                  Icons.storefront_rounded,
                  color: cardColor,
                  size: 24,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                valueOrDefault<String>(widget.title, 'Tienda'),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: FlutterFlowTheme.of(context).labelMedium.copyWith(
                      fontFamily: "Space Grotesk",
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                      color: isSelected
                          ? cardColor
                          : FlutterFlowTheme.of(context).primaryText,
                      fontSize: 12,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
