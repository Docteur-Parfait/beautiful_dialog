import 'package:beautiful_dialog/views/dialog_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Tests the ExpandingButtonDialog in DialogView for correct display and interaction.
void main() {
  testWidgets('ExpandingButtonDialog displays and responds as expected',
      (WidgetTester tester) async {
    // The message shown within the dialog after expansion.
    const dialogMessage = 'Try to close it on the first try.';

    // Build the test app with DialogView as the home screen.
    await tester.pumpWidget(
      MaterialApp(
        title: 'Flutter Dialogs',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
          ),
          useMaterial3: true,
        ),
        home: const DialogView(),
      )
    );

    // Tap the button to display the expanding dialog
    await tester.tap(find.text('Expanding alert'));
    await tester.pumpAndSettle(); // Wait for dialog animation to finish

    // Assert: Dialog window is shown
    expect(find.byType(Dialog), findsOneWidget);

    // Assert: Dialog contains expected widgets and text
    expect(find.text('You got it!'), findsOneWidget);
    expect(find.text(dialogMessage), findsOneWidget);
    expect(find.text('Done'), findsOneWidget);

    // Simulate hover to check cursor effect
    await tester.sendEventToBinding(const PointerHoverEvent(
      position: Offset(200, 200),
    ));
    await tester.pumpAndSettle();

    // Tap the 'Done' button to close the dialog
    await tester.tap(find.text('Done'));
    await tester.pumpAndSettle();
    
    // Assert: Dialog is no longer displayed
    expect(find.byType(Dialog), findsNothing);
  });
}
