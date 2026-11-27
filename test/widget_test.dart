import 'package:absurd_app/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AbsurdApp smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const AbsurdApp());
    expect(find.text('ABSURD'), findsOneWidget);
  });
}
