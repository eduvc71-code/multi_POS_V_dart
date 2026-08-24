import 'package:multi_p_o_s/components/login_background/login_background_widget.dart';
import 'package:multi_p_o_s/components/login_background_child/login_background_child_widget.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'inicio_de_sesi_n_model.dart';
export 'inicio_de_sesi_n_model.dart';

class InicioDeSesiNWidget extends StatefulWidget {
  const InicioDeSesiNWidget({super.key});

  static String routeName = 'InicioDeSesiN';
  static String routePath = '/inicioDeSesiN';

  @override
  State<InicioDeSesiNWidget> createState() => _InicioDeSesiNWidgetState();
}

class _InicioDeSesiNWidgetState extends State<InicioDeSesiNWidget> {
  late InicioDeSesiNModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InicioDeSesiNModel());
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
        body: wrapWithModel(
          model: _model.loginBackgroundModel,
          updateCallback: () => safeSetState(() {}),
          child: LoginBackgroundWidget(
            child: () => LoginBackgroundChildWidget(),
          ),
        ),
      ),
    );
  }
}
