import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:todo_app/main.dart' as app;

void main() {
  group('TODO app testing', () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets('Create new task test', (tester) async {
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 5));

      final unlockFinder = find.byKey(const Key('unlock'));

      await tester.tap(unlockFinder);
      await tester.pumpAndSettle();

      final floatButtonFinder = find.byType(FloatingActionButton).first;
      final addButtonFinder = find.byKey(const Key('addTask'));
      final titleFinder = find.byKey(const Key('titleK'));
      await tester.tap(floatButtonFinder);
      await tester.pumpAndSettle();
      await tester.enterText(titleFinder, 'Task test1');
      await tester.pumpAndSettle();
      await tester.tap(addButtonFinder);
      //await to see test result
      await tester.pumpAndSettle(const Duration(seconds: 10));
    });
  });
}
