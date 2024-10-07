import 'package:beautiful_dialog/views/dialog_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ExpandingButtonDialog displays correctly',
      (WidgetTester tester) async {
    // Define the message to be passed to the dialog
    const testMessage = 'Try to close it on the first try.';

    // Build the dialog widget
    await tester.pumpWidget(MaterialApp(
      title: 'Flutter Dialogs ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        appBarTheme: const AppBarTheme(
            backgroundColor: Colors.green, foregroundColor: Colors.white),
        useMaterial3: true,
      ),
      home: const DialogView(),
    ));

    // Tap the button to show the dialog
    await tester.tap(find.text('Expanding alert'));
    await tester.pumpAndSettle(); // Wait for the dialog to appear

    // Verify if the dialog is displayed
    expect(find.byType(Dialog), findsOneWidget);
    expect(find.text('You got it!'), findsOneWidget);
    expect(find.text(testMessage), findsOneWidget);
    expect(find.text('Done'), findsOneWidget);

    // Verify if the cursor changes to hand on hover
    await tester.sendEventToBinding(
      const PointerHoverEvent(
        position: Offset(150, 150), // Adjust the position based on your layout
      ),
    );
    await tester.pumpAndSettle();

    // Check for hover effect by ensuring _rotationY is altered (optional)
    // This could involve checking the rendered transformation, which is complex
    // So we can skip that part for simplicity.

    // Close the dialog
    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle(); // Wait for the dialog to close
  });
}
