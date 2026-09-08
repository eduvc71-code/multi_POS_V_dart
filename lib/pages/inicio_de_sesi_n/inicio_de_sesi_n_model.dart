import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/components/login_background/login_background_widget.dart';
import 'inicio_de_sesi_n_widget.dart' show InicioDeSesionWidget;
import 'package:flutter/material.dart';

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
