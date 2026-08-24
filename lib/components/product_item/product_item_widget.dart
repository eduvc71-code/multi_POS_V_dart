import 'package:multi_p_o_s/flutter_flow/flutter_flow_theme.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_util.dart';
import 'package:multi_p_o_s/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'product_item_model.dart';
export 'product_item_model.dart';

class ProductItemWidget extends StatefulWidget {
  const ProductItemWidget({
    super.key,
    String? code,
    String? name,
    String? price,
    Color? statusColor,
    String? stock,
  })  : this.code = code ?? 'MOT-001',
        this.name = name ?? 'Aceite Sintético 5W-30',
        this.price = price ?? '85,00',
        this.statusColor = statusColor ?? const Color(0x00000000),
        this.stock = stock ?? '45';

  final String code;
  final String name;
  final String price;
  final Color statusColor;
  final String stock;

  @override
  State<ProductItemWidget> createState() => _ProductItemWidgetState();
}

class _ProductItemWidgetState extends State<ProductItemWidget> {
  late ProductItemModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProductItemModel());
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
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(24),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: FlutterFlowTheme.of(context).alternate,
          width: 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
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
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(12),
                  shape: BoxShape.rectangle,
                ),
                alignment: AlignmentDirectional(0, 0),
                child: Icon(
                  Icons.inventory_2_rounded,
                  color: FlutterFlowTheme.of(context).secondaryText,
                  size: 24,
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
                        widget!.name,
                        'Aceite Sintético 5W-30',
                      ),
                      maxLines: 1,
                      style: FlutterFlowTheme.of(context).bodyLarge.copyWith(
                            fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontWeight: FontWeight.bold,
                            height: 1.5,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Código:',
                          style: FlutterFlowTheme.of(context)
                              .labelSmall
                              .copyWith(
                                fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
                                  fontWeight: FlutterFlowTheme.of(context),
                                height: 1.2,
                              ),
                        ),
                        Text(
                          valueOrDefault<String>(
                            widget!.code,
                            'MOT-001',
                          ),
                          style: FlutterFlowTheme.of(context)
                              .labelSmall
                              .copyWith(
                                fontFamily: GoogleFonts.spaceGrotesk().fontFamily,
                                  fontWeight: FontWeight.w600,
                                height: 1.2,
                              ),
                        ),
                      ].divide(SizedBox(width: 4)),
                    ),
                  ].divide(SizedBox(height: 4)),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    valueOrDefault<String>(
                      'Bs. ${widget!.price}',
                      'Bs. 85,00',
                    ),
                    style: FlutterFlowTheme.of(context).bodyLarge.copyWith(
                          fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontWeight: FontWeight.bold,
                          height: 1.5,
                        ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: valueOrDefault<Color>(
                            widget!.statusColor,
                            FlutterFlowTheme.of(context).success,
                          ),
                          borderRadius: BorderRadius.circular(9999),
                          shape: BoxShape.rectangle,
                        ),
                      ),
                      Text(
                        valueOrDefault<String>(
                          '${widget!.stock} u.',
                          '45 u.',
                        ),
                        style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                              fontFamily: GoogleFonts.poppins().fontFamily,
                                  fontWeight: FlutterFlowTheme.of(context),
                              height: 1.5,
                            ),
                      ),
                    ].divide(SizedBox(width: 4)),
                  ),
                ].divide(SizedBox(height: 4)),
              ),
            ].divide(SizedBox(width: 16)),
          ),
        ),
      ),
    );
  }
}
