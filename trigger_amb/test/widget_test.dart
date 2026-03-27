import 'package:flutter_test/flutter_test.dart';
import 'package:trigger_amb/main.dart';

void main() {
  testWidgets('App loads smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const LifeRouteApp());
    expect(find.text('LifeRoute: Driver Center'), findsOneWidget);
  });
}
