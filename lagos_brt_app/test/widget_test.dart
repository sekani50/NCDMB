import 'package:flutter_test/flutter_test.dart';
import 'package:lagos_brt_app/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const LagosBRTApp());
    expect(find.byType(LagosBRTApp), findsOneWidget);
  });
}
