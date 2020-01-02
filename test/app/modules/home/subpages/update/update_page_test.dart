import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:dio_custom/app/modules/home/subpages/update/update_page.dart';

main() {
  testWidgets('UpdatePage has title', (WidgetTester tester) async {
    await tester.pumpWidget(buildTestableWidget(UpdatePage(title: 'Update')));
    final titleFinder = find.text('Update');
    expect(titleFinder, findsOneWidget);
  });
}
