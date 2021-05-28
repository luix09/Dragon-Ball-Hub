import 'package:dragonballhub/authentication_widget.dart';
import 'package:dragonballhub/custom_widgets/dart/login_widgets.dart';
import 'package:dragonballhub/logger.dart';
import 'package:dragonballhub/main.dart';
import 'package:dragonballhub/screens/pre_login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Widget test', () {
    testWidgets('Check Authentication widget', (WidgetTester tester) async {
      await tester.pumpWidget(ProviderScope(observers: [Logger()], child: MyApp()));
      expect(find.byType(AuthenticationWidget), findsOneWidget);
      await tester.pumpWidget(MaterialApp(home: PreLoginScreen()));
      expect(find.text("Welcome to DragonBall Hub"), findsOneWidget);
      expect(find.byType(MyBlinkingButton), findsOneWidget);
      await tester.tap(find.byType(MyBlinkingButton));
      await tester.pumpAndSettle();
      expect(find.byType(TopCenterBallLogo), findsOneWidget);
    });
  });
}