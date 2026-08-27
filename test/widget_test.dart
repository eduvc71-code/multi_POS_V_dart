import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_p_o_s/main.dart';

void main() {
  testWidgets('muestra la pantalla de inicio de sesión', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1440, 900));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Bienvenido'), findsOneWidget);
    expect(find.text('Iniciar Sesión'), findsOneWidget);
  });

  testWidgets('inicio y dashboard se adaptan a una pantalla móvil',
      (tester) async {
    await tester.binding.setSurfaceSize(const Size(393, 873));
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Iniciar Sesión'));
    await tester.tap(find.text('Iniciar Sesión'));
    await tester.pumpAndSettle();

    expect(find.text('Ventas del Día'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
