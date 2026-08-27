import 'package:multi_p_o_s/components/login_background/login_background_widget.dart';
import 'package:multi_p_o_s/components/login_background_child/login_background_child_widget.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_widgets.dart';
import 'inicio_de_sesi_n_widget.dart' show InicioDeSesionWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class InicioDeSesionModel extends FlutterFlowModel<InicioDeSesionWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for LoginBackground.
  late LoginBackgroundModel loginBackgroundModel;

  @override
  void initState(BuildContext context) {
    loginBackgroundModel = createModel(context, () => LoginBackgroundModel());
  }

  @override
  void dispose() {
    loginBackgroundModel.dispose();
  }
}
