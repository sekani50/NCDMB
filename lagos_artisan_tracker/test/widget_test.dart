import 'package:flutter_test/flutter_test.dart';
import 'package:lagos_artisan_tracker/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const LagosArtisanApp());
    expect(find.byType(LagosArtisanApp), findsOneWidget);
  });
}
