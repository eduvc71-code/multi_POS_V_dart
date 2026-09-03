import 'package:multi_p_o_s/flutter_flow/flutter_flow_icon_button.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/components/button/button_widget.dart';
import 'package:multi_p_o_s/components/business_card/business_card_widget.dart';
import 'package:multi_p_o_s/components/settings_tile/settings_tile_widget.dart';
import 'package:multi_p_o_s/components/bottom_nav/bottom_nav_widget.dart';
import 'package:multi_p_o_s/components/bottom_nav_child5/bottom_nav_child5_widget.dart';
import 'package:multi_p_o_s/pages/inicio_de_sesi_n/inicio_de_sesi_n_widget.dart';
import 'package:multi_p_o_s/pages/panel_principal/panel_principal_widget.dart';
import 'package:multi_p_o_s/database/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

import 'configuraci_n_y_empresas_model.dart';
export 'configuraci_n_y_empresas_model.dart';

@Preview()
Widget previewConfiguracionYEmpresas() {
  return const ConfiguracionYEmpresasWidget();
}

class ConfiguracionYEmpresasWidget extends StatefulWidget {
  const ConfiguracionYEmpresasWidget({super.key});

  static String routeName = 'ConfiguracionYEmpresas';
  static String routePath = '/configuracionYEmpresas';

  @override
  State<ConfiguracionYEmpresasWidget> createState() =>
      _ConfiguracionYEmpresasWidgetState();
}

class _ConfiguracionYEmpresasWidgetState
    extends State<ConfiguracionYEmpresasWidget> {
  late ConfiguracionYEmpresasModel _model;
  Map<String, dynamic>? _empresaActiva;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ConfiguracionYEmpresasModel());
    _loadEmpresaActiva();
  }

  Future<void> _loadEmpresaActiva() async {
    final empresa = await DatabaseHelper.instance.getEmpresaActiva();
    if (mounted) {
      setState(() {
        _empresaActiva = empresa;
      });
    }
  }

  Future<void> _showEmpleadosDialog() async {
    List<Map<String, dynamic>> usuarios = await DatabaseHelper.instance.readAllUsuarios();

    if (!mounted) return;

    await showDialog(
      context: context,
      builder: (dialogCtx) {
        bool isAddingNew = false;
        bool isEditing = false;
        int? editingUserId;

        final nombreCtrl = TextEditingController();
        final usernameCtrl = TextEditingController();
        final passwordCtrl = TextEditingController();
        String rol = 'Cajero';

        bool canVender = true;
        bool canAddInventory = false;
        bool canDeleteInventory = false;
        bool canEditStock = false;
        bool canViewReportes = false;

        return StatefulBuilder(
          builder: (dialogCtx, setStateDialog) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              title: Row(
                children: [
                  Icon(
                    isAddingNew ? Icons.person_add_rounded : (isEditing ? Icons.edit_rounded : Icons.people_alt_rounded),
                    color: const Color(0xFF0066FF),
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      isAddingNew
                          ? 'Nuevo Colaborador'
                          : (isEditing ? 'Editar Colaborador' : 'Gestión de Colaboradores'),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              content: SizedBox(
                width: double.maxFinite,
                child: SingleChildScrollView(
                  child: AnimatedCrossFade(
                    duration: const Duration(milliseconds: 250),
                    crossFadeState: (isAddingNew || isEditing)
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    firstChild: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: FlutterFlowTheme.of(context).primary,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            onPressed: () {
                              setStateDialog(() {
                                isAddingNew = true;
                                isEditing = false;
                                nombreCtrl.clear();
                                usernameCtrl.text = 'cajero1';
                                passwordCtrl.text = '12345678';
                                rol = 'Cajero';
                                canVender = true;
                                canAddInventory = false;
                                canDeleteInventory = false;
                                canEditStock = false;
                                canViewReportes = false;
                              });
                            },
                            icon: const Icon(Icons.person_add_rounded, size: 20),
                            label: const Text('Crear Colaborador', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ),
                        const SizedBox(height: 12),
                        usuarios.isEmpty
                            ? const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text('No hay colaboradores registrados.', style: TextStyle(color: Colors.grey)),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: usuarios.length,
                                itemBuilder: (ctx, index) {
                                  final u = usuarios[index];
                                  final int uId = u['id'];
                                  final String uNombre = u['nombre'] ?? '';
                                  final String uRol = u['rol'] ?? 'cajero';
                                  final bool activo = (u['activo'] ?? 1) == 1;

                                  Color roleColor = Colors.blue;
                                  if (uRol == 'admin') roleColor = const Color(0xFF6200EA);
                                  if (uRol == 'cajero') roleColor = Colors.green;

                                  String roleLabel = uRol.toUpperCase();
                                  if (uRol == 'admin') roleLabel = 'ADMINISTRADOR';

                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 8),
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: FlutterFlowTheme.of(context).alternate),
                                    ),
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                                      leading: CircleAvatar(
                                        radius: 18,
                                        backgroundColor: roleColor.withValues(alpha: 0.15),
                                        child: Icon(Icons.person_rounded, color: roleColor, size: 18),
                                      ),
                                      title: Text(uNombre, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                      subtitle: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: roleColor.withValues(alpha: 0.15),
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                              roleLabel,
                                              style: TextStyle(color: roleColor, fontSize: 9, fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          Expanded(
                                            child: Text(
                                              '@${u['username']}',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(fontSize: 11, color: Colors.grey),
                                            ),
                                          ),
                                        ],
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Switch(
                                            value: activo,
                                            activeColor: FlutterFlowTheme.of(context).primary,
                                            onChanged: (val) async {
                                              await DatabaseHelper.instance.updateUsuarioStatus(uId, val);
                                              final updated = await DatabaseHelper.instance.readAllUsuarios();
                                              setStateDialog(() {
                                                usuarios = updated;
                                              });
                                            },
                                          ),
                                          if (uRol != 'admin') ...[
                                            IconButton(
                                              constraints: const BoxConstraints(),
                                              padding: const EdgeInsets.all(4),
                                              icon: const Icon(Icons.edit_rounded, color: Colors.blue, size: 18),
                                              onPressed: () {
                                                setStateDialog(() {
                                                  isEditing = true;
                                                  isAddingNew = false;
                                                  editingUserId = uId;
                                                  nombreCtrl.text = uNombre;
                                                  usernameCtrl.text = u['username'] ?? '';
                                                  passwordCtrl.text = u['password'] ?? '';
                                                  rol = uRol == 'admin' ? 'Administrador' : (uRol == 'vendedor' ? 'Vendedor' : 'Cajero');
                                                  canVender = true;
                                                  canAddInventory = uRol == 'vendedor' || uRol == 'admin';
                                                  canDeleteInventory = uRol == 'admin';
                                                  canEditStock = uRol == 'admin';
                                                  canViewReportes = uRol == 'admin';
                                                });
                                              },
                                            ),
                                            IconButton(
                                              constraints: const BoxConstraints(),
                                              padding: const EdgeInsets.all(4),
                                              icon: const Icon(Icons.delete_outline_rounded, color: Colors.red, size: 18),
                                              onPressed: () async {
                                                await DatabaseHelper.instance.deleteUsuario(uId);
                                                final updated = await DatabaseHelper.instance.readAllUsuarios();
                                                setStateDialog(() {
                                                  usuarios = updated;
                                                });
                                              },
                                            ),
                                          ],
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ],
                    ),
                    secondChild: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: nombreCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Nombre Completo del Colaborador *',
                            isDense: true,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: usernameCtrl,
                          enabled: !isEditing,
                          decoration: const InputDecoration(
                            labelText: 'Nombre de Usuario *',
                            isDense: true,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: passwordCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Contraseña Provisional *',
                            helperText: 'El colaborador la cambiará al iniciar sesión',
                            isDense: true,
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text('Rol de Trabajo:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: rol,
                              isExpanded: true,
                              items: const [
                                DropdownMenuItem(value: 'Administrador', child: Text('Administrador (Acceso Total)')),
                                DropdownMenuItem(value: 'Cajero', child: Text('Cajero (Solo Punto de Venta)')),
                                DropdownMenuItem(value: 'Vendedor', child: Text('Vendedor (Punto de Venta + Añadir Productos)')),
                              ],
                              onChanged: (val) {
                                if (val != null) {
                                  setStateDialog(() {
                                    rol = val;
                                    if (rol == 'Administrador') {
                                      canVender = true;
                                      canAddInventory = true;
                                      canDeleteInventory = true;
                                      canEditStock = true;
                                      canViewReportes = true;
                                    } else if (rol == 'Vendedor') {
                                      canVender = true;
                                      canAddInventory = true;
                                      canDeleteInventory = false;
                                      canEditStock = false;
                                      canViewReportes = false;
                                    } else {
                                      canVender = true;
                                      canAddInventory = false;
                                      canDeleteInventory = false;
                                      canEditStock = false;
                                      canViewReportes = false;
                                    }
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text('Módulos y Permisos Autorizados:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        CheckboxListTile(
                          title: const Text('Módulo Punto de Venta (Vender)', style: TextStyle(fontSize: 11)),
                          value: canVender,
                          dense: true,
                          activeColor: const Color(0xFF0066FF),
                          onChanged: (val) => setStateDialog(() => canVender = val ?? true),
                        ),
                        CheckboxListTile(
                          title: const Text('Adicionar Productos al Inventario (Escáner/Manual)', style: TextStyle(fontSize: 11)),
                          subtitle: const Text('Permitido para Vendedor y Administrador', style: TextStyle(fontSize: 9, color: Colors.grey)),
                          value: canAddInventory,
                          dense: true,
                          activeColor: const Color(0xFF0066FF),
                          onChanged: (val) => setStateDialog(() => canAddInventory = val ?? false),
                        ),
                        CheckboxListTile(
                          title: const Text('Eliminar Productos del Inventario', style: TextStyle(fontSize: 11)),
                          subtitle: const Text('Restringido únicamente a Administrador/Dueño', style: TextStyle(fontSize: 9, color: Colors.grey)),
                          value: canDeleteInventory,
                          dense: true,
                          activeColor: const Color(0xFF0066FF),
                          enabled: rol == 'Administrador',
                          onChanged: (val) => setStateDialog(() => canDeleteInventory = val ?? false),
                        ),
                        CheckboxListTile(
                          title: const Text('Editar Precios o Modificar Stock Manualmente', style: TextStyle(fontSize: 11)),
                          subtitle: const Text('Restringido únicamente a Administrador/Dueño', style: TextStyle(fontSize: 9, color: Colors.grey)),
                          value: canEditStock,
                          dense: true,
                          activeColor: const Color(0xFF0066FF),
                          enabled: rol == 'Administrador',
                          onChanged: (val) => setStateDialog(() => canEditStock = val ?? false),
                        ),
                        CheckboxListTile(
                          title: const Text('Ver Reportes y Configuración', style: TextStyle(fontSize: 11)),
                          value: canViewReportes,
                          dense: true,
                          activeColor: const Color(0xFF0066FF),
                          enabled: rol == 'Administrador',
                          onChanged: (val) => setStateDialog(() => canViewReportes = val ?? false),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              actions: [
                if (isAddingNew || isEditing) ...[
                  TextButton(
                    onPressed: () {
                      setStateDialog(() {
                        isAddingNew = false;
                        isEditing = false;
                      });
                    },
                    child: const Text('Volver a la Lista'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: FlutterFlowTheme.of(context).primary,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () async {
                      final usernameVal = usernameCtrl.text.trim();
                      final passwordVal = passwordCtrl.text.trim();
                      final nombreVal = nombreCtrl.text.trim();

                      if (usernameVal.isEmpty || passwordVal.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Por favor ingrese usuario y contraseña')),
                        );
                        return;
                      }

                      final roleCode = rol == 'Administrador' ? 'admin' : (rol == 'Cajero' ? 'cajero' : 'vendedor');

                      try {
                        if (isEditing && editingUserId != null) {
                          await DatabaseHelper.instance.updateUsuario(
                            usuarioId: editingUserId!,
                            nombre: nombreVal,
                            password: passwordVal,
                            rol: roleCode,
                          );
                        } else {
                          final Map<String, bool> permisos = {
                            'can_vender': canVender,
                            'can_add_inventory': canAddInventory,
                            'can_delete_inventory': canDeleteInventory,
                            'can_edit_stock': canEditStock,
                            'can_view_reportes': canViewReportes,
                          };

                          await DatabaseHelper.instance.createUsuarioWithPermissions(
                            username: usernameVal,
                            password: passwordVal,
                            nombre: nombreVal.isEmpty ? usernameVal : nombreVal,
                            rol: roleCode,
                            permisos: permisos,
                          );
                        }

                        final updated = await DatabaseHelper.instance.readAllUsuarios();
                        setStateDialog(() {
                          usuarios = updated;
                          isAddingNew = false;
                          isEditing = false;
                        });
                      } catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: $e')),
                          );
                        }
                      }
                    },
                    child: Text(isEditing ? 'Guardar Cambios' : 'Guardar Colaborador'),
                  ),
                ] else ...[
                  TextButton(
                    onPressed: () => Navigator.pop(dialogCtx),
                    child: const Text('Cerrar'),
                  ),
                ],
              ],
            );
          },
        );
      },
    );
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
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Padding(
                padding: const EdgeInsets.all(24.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // BLOQUE 1: CABECERA
                      Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).secondaryBackground,
                          shape: BoxShape.rectangle,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(16, 24, 16, 24),
                              child: Container(
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          FlutterFlowIconButton(
                                            borderRadius: 8,
                                            buttonSize: 40,
                                            fillColor: Colors.transparent,
                                            icon: const Icon(Icons.arrow_back_rounded, size: 24),
                                            onPressed: () async {
                                              context.goNamed(PanelPrincipalWidget.routeName);
                                            },
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Configuración',
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: FlutterFlowTheme.of(context)
                                                      .headlineMedium
                                                      .copyWith(
                                                        fontFamily: "Urbanist",
                                                        color: FlutterFlowTheme.of(
                                                          context,
                                                        ).primaryText,
                                                        letterSpacing: 0.0,
                                                        fontWeight: FontWeight.bold,
                                                        height: 1.25,
                                                      ),
                                                ),
                                                Text(
                                                  'Gestión de MultiPOS y Empresas',
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: FlutterFlowTheme.of(context).bodySmall
                                                      .copyWith(
                                                        fontFamily: "Poppins",
                                                        color: Colors.black,
                                                        letterSpacing: 0.0,
                                                        height: 1.4,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    FlutterFlowIconButton(
                                      borderRadius: 8,
                                      buttonSize: 40,
                                      fillColor: Colors.transparent,
                                      icon: Icon(
                                        Icons.help_outline_rounded,
                                        color: FlutterFlowTheme.of(context).primaryText,
                                        size: 24,
                                      ),
                                      onPressed: () {
                                        debugPrint('IconButton pressed ...');
                                      },
                                    ),
                                  ],
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
                      ),
                      const Spacer(flex: 1),
                      // BLOQUE 2: CUERPO
                      Expanded(
                        flex: 3,
                        child: SingleChildScrollView(
                          primary: false,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            'Mi Empresa',
                                            style: FlutterFlowTheme.of(context)
                                                .titleLarge
                                                .copyWith(
                                                  fontFamily: "Urbanist",
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                  height: 1.3,
                                                ),
                                          ),
                                        ],
                                      ),
                                      wrapWithModel(
                                        model: _model.businessCardModel1,
                                        updateCallback: () => safeSetState(() {}),
                                        child: BusinessCardWidget(
                                          name: _empresaActiva?['nombre'] ?? 'Mi Empresa Activa',
                                          type: _empresaActiva?['tipo'] ?? 'Comercial',
                                          isActive: true,
                                        ),
                                      ),
                                    ].divide(const SizedBox(height: 16)),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        'Equipo y Seguridad',
                                        style: FlutterFlowTheme.of(context).titleLarge
                                            .copyWith(
                                              fontFamily: "Urbanist",
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              height: 1.3,
                                            ),
                                      ),
                                      wrapWithModel(
                                        model: _model.settingsTileModel1,
                                        updateCallback: () => safeSetState(() {}),
                                        child: SettingsTileWidget(
                                          icon: const Icon(
                                            Icons.people_rounded,
                                            color: Colors.black,
                                            size: 24,
                                          ),
                                          iconBg: FlutterFlowTheme.of(
                                            context,
                                          ).primary20,
                                          subtitle: 'Gestionar colaboradores y roles',
                                          title: 'Colaboradores',
                                          onTap: _showEmpleadosDialog,
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.settingsTileModel2,
                                        updateCallback: () => safeSetState(() {}),
                                        child: SettingsTileWidget(
                                          icon: const Icon(
                                            Icons.security_rounded,
                                            color: Colors.black,
                                            size: 24,
                                          ),
                                          iconBg: FlutterFlowTheme.of(
                                            context,
                                          ).secondary20,
                                          subtitle:
                                              'Registro de movimientos críticos',
                                          target: 'Target',
                                          title: 'Auditoría',
                                        ),
                                      ),
                                    ].divide(const SizedBox(height: 16)),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        'Aplicación',
                                        style: FlutterFlowTheme.of(context).titleLarge
                                            .copyWith(
                                              fontFamily: "Urbanist",
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              height: 1.3,
                                            ),
                                      ),
                                      wrapWithModel(
                                        model: _model.settingsTileModel3,
                                        updateCallback: () => safeSetState(() {}),
                                        child: SettingsTileWidget(
                                          icon: const Icon(
                                            Icons.print_rounded,
                                            color: Colors.black,
                                            size: 24,
                                          ),
                                          iconBg: FlutterFlowTheme.of(
                                            context,
                                          ).accent20,
                                          subtitle: 'Configurar Bluetooth/Red',
                                          target: 'Target',
                                          title: 'Impresora y Tickets',
                                        ),
                                      ),
                                      wrapWithModel(
                                        model: _model.settingsTileModel4,
                                        updateCallback: () => safeSetState(() {}),
                                        child: const SettingsTileWidget(
                                          icon: Icon(
                                            Icons.description_rounded,
                                            color: Colors.black,
                                            size: 24,
                                          ),
                                          iconBg: Color(0x3300C2FF),
                                          subtitle: 'Configuración fiscal',
                                          target: 'Target',
                                          title: 'Impuestos y NIT',
                                        ),
                                      ),
                                    ].divide(const SizedBox(height: 16)),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(
                                        context,
                                      ).surfaceVariant30,
                                      borderRadius: BorderRadius.circular(24),
                                      shape: BoxShape.rectangle,
                                      border: Border.all(
                                        color: FlutterFlowTheme.of(context).alternate,
                                        width: 1,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(24),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(context).tertiary,
                                                  shape: BoxShape.circle,
                                                ),
                                                alignment: const AlignmentDirectional(0, 0),
                                                child: const Text(
                                                  'MP',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    _empresaActiva?['nombre'] ?? 'Mi Empresa',
                                                    style: FlutterFlowTheme.of(context).titleMedium.copyWith(
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                  ),
                                                  const Text(
                                                    'Sesión Activa',
                                                    style: TextStyle(fontSize: 12, color: Colors.grey),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          const Divider(height: 16, thickness: 1),
                                          InkWell(
                                            onTap: () async {
                                              final prefs = await SharedPreferences.getInstance();
                                              await prefs.clear();
                                              if (context.mounted) {
                                                context.goNamed(InicioDeSesionWidget.routeName);
                                              }
                                            },
                                            child: wrapWithModel(
                                              model: _model.buttonModel2,
                                              updateCallback: () => safeSetState(() {}),
                                              child: ButtonWidget(
                                                icon: Icon(
                                                  Icons.logout_rounded,
                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                  size: 24,
                                                ),
                                                iconPresent: true,
                                                iconEndPresent: false,
                                                content: 'Cerrar Sesión',
                                                variant: 'destructive',
                                                size: 'medium',
                                                fullWidth: true,
                                                loading: false,
                                                disabled: false,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: const AlignmentDirectional(0, 0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'MultiPOS v2.4.0',
                                          style: FlutterFlowTheme.of(context).labelSmall.copyWith(
                                                fontFamily: "Space Grotesk",
                                                color: Colors.black,
                                                height: 1.2,
                                              ),
                                        ),
                                        Text(
                                          'Hecho con ❤️ para tu negocio',
                                          style: FlutterFlowTheme.of(context).labelSmall.copyWith(
                                                fontFamily: "Space Grotesk",
                                                color: Colors.black,
                                                height: 1.2,
                                              ),
                                        ),
                                      ].divide(const SizedBox(height: 4)),
                                    ),
                                  ),
                                ].divide(const SizedBox(height: 24)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(flex: 1),
                      // BLOQUE 3: FOOTER
                      Align(
                        alignment: const AlignmentDirectional(0, 1),
                        child: Container(
                          child: wrapWithModel(
                            model: _model.bottomNavModel,
                            updateCallback: () => safeSetState(() {}),
                            child: BottomNavWidget(child: () => const BottomNavChild5Widget()),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
