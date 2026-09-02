import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import 'settings_tile_model.dart';
export 'settings_tile_model.dart';

@Preview()
Widget previewSettingsTile() {
  return const SettingsTileWidget(
    title: 'Mi Perfil',
    subtitle: 'Gestiona tu información personal',
    icon: Icon(Icons.person_outline_rounded, color: Color(0xFF0066FF), size: 24),
    iconBg: Color(0x330066FF),
  );
}

class SettingsTileWidget extends StatefulWidget {
  const SettingsTileWidget({
    super.key,
    this.icon,
    Color? iconBg,
    String? subtitle,
    String? target,
    String? title,
  })  : iconBg = iconBg ?? const Color(0x00000000),
        subtitle = subtitle ?? 'Subtitle',
        target = target ?? 'Target',
        title = title ?? 'Title';

  final Widget? icon;
  final Color iconBg;
  final String subtitle;
  final String target;
  final String title;

  @override
  State<SettingsTileWidget> createState() => _SettingsTileWidgetState();
}

class _SettingsTileWidgetState extends State<SettingsTileWidget> {
  late SettingsTileModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SettingsTileModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        GoRouter.of(context).pushNamed(widget.target);
      },
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(16),
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
                  color: valueOrDefault<Color>(
                    widget.iconBg,
                    FlutterFlowTheme.of(context).primary20,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  shape: BoxShape.rectangle,
                ),
                alignment: const AlignmentDirectional(0, 0),
                child: widget.icon,
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: FlutterFlowTheme.of(context).bodyLarge.copyWith(
                            fontFamily: "Urbanist",
                            color: FlutterFlowTheme.of(context).primaryText,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            height: 1.4,
                          ),
                    ),
                    Text(
                      widget.subtitle,
                      style: FlutterFlowTheme.of(context).labelSmall.copyWith(
                            fontFamily: "Space Grotesk",
                            color: Colors.black,
                            letterSpacing: 0.0,
                            fontWeight: FlutterFlowTheme.of(context).labelSmall.fontWeight,
                            height: 1.2,
                          ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: Colors.black,
                size: 24,
              ),
            ].divide(const SizedBox(width: 16)),
          ),
        ),
      ),
    );
  }
}