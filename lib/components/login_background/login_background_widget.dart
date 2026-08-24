import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'login_background_model.dart';
export 'login_background_model.dart';

class LoginBackgroundWidget extends StatefulWidget {
  const LoginBackgroundWidget({
    super.key,
    this.child,
  });

  final Widget Function()? child;

  @override
  State<LoginBackgroundWidget> createState() => _LoginBackgroundWidgetState();
}

class _LoginBackgroundWidgetState extends State<LoginBackgroundWidget> {
  late LoginBackgroundModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginBackgroundModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional(-1, -1),
      children: [
        Container(
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).onPrimaryContainer,
            shape: BoxShape.rectangle,
          ),
        ),
        Align(
          alignment: AlignmentDirectional(-1.2, -1.2),
          child: ClipRect(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: 80,
                sigmaY: 80,
              ),
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primary15,
                  borderRadius: BorderRadius.circular(9999),
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: AlignmentDirectional(1.2, 1.2),
          child: ClipRect(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                sigmaX: 100,
                sigmaY: 100,
              ),
              child: Container(
                width: 350,
                height: 350,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondary10,
                  borderRadius: BorderRadius.circular(9999),
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
          ),
        ),
        Builder(builder: (_) {
          return widget.child != null ? widget.child!() : SizedBox.shrink();
        }),
      ],
    );
  }
}