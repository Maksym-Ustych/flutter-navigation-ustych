import 'package:flutter_test/flutter_test.dart';

import 'package:college_library_app/main.dart';

void main() {
  testWidgets(
    'Library app starts on catalog',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const LibraryApp(),
      );

      await tester.pumpAndSettle();

      expect(
        find.text('Каталог'),
        findsWidgets,
      );

      expect(
        find.text('Мої книги'),
        findsOneWidget,
      );

      expect(
        find.text('Профіль'),
        findsOneWidget,
      );
    },
  );
}