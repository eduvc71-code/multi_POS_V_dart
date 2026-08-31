import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_widgets.dart';
import 'package:multi_p_o_s/components/button/button_widget.dart';
import 'package:multi_p_o_s/components/business_card/business_card_widget.dart';
import 'package:multi_p_o_s/components/settings_tile/settings_tile_widget.dart';
import 'package:multi_p_o_s/components/bottom_nav/bottom_nav_widget.dart';
import 'configuraci_n_y_empresas_widget.dart' show ConfiguracionYEmpresasWidget;
import 'package:flutter/material.dart';

class ConfiguracionYEmpresasModel
    extends FlutterFlowModel<ConfiguracionYEmpresasWidget> {
  ///  State fields for stateful widgets in this page.

  // Model for Button.
  late ButtonModel buttonModel1;
  // Model for BusinessCard.
  late BusinessCardModel businessCardModel1;
  // Model for BusinessCard.
  late BusinessCardModel businessCardModel2;
  // Model for SettingsTile.
  late SettingsTileModel settingsTileModel1;
  // Model for SettingsTile.
  late SettingsTileModel settingsTileModel2;
  // Model for SettingsTile.
  late SettingsTileModel settingsTileModel3;
  // Model for SettingsTile.
  late SettingsTileModel settingsTileModel4;
  // Model for Button.
  late ButtonModel buttonModel2;
  // Model for BottomNav.
  late BottomNavModel bottomNavModel;

  @override
  void initState(BuildContext context) {
    buttonModel1 = createModel(context, () => ButtonModel());
    businessCardModel1 = createModel(context, () => BusinessCardModel());
    businessCardModel2 = createModel(context, () => BusinessCardModel());
    settingsTileModel1 = createModel(context, () => SettingsTileModel());
    settingsTileModel2 = createModel(context, () => SettingsTileModel());
    settingsTileModel3 = createModel(context, () => SettingsTileModel());
    settingsTileModel4 = createModel(context, () => SettingsTileModel());
    buttonModel2 = createModel(context, () => ButtonModel());
    bottomNavModel = createModel(context, () => BottomNavModel());
  }

  @override
  void dispose() {
    buttonModel1.dispose();
    businessCardModel1.dispose();
    businessCardModel2.dispose();
    settingsTileModel1.dispose();
    settingsTileModel2.dispose();
    settingsTileModel3.dispose();
    settingsTileModel4.dispose();
    buttonModel2.dispose();
    bottomNavModel.dispose();
  }
}
