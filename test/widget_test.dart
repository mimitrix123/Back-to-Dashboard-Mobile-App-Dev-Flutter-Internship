import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_internship_portfolio/main.dart';

void main() {
  testWidgets('home screen shows internship title', (tester) async {
    await tester.pumpWidget(const InternshipApp());
    expect(find.text('Flutter Internship Portfolio'), findsOneWidget);
    expect(find.text('Week 1'), findsOneWidget);
  });
}
