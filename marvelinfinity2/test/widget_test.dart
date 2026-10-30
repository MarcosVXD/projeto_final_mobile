import 'package:flutter_test/flutter_test.dart';
import 'package:marvelinfinity/main.dart';

void main() {
  testWidgets('Marvel Infinity inicia na Splash Screen', (tester) async {
    await tester.pumpWidget(const MarvelInfinityApp());
    expect(find.byType(SplashScreen), findsOneWidget);
  });
}
