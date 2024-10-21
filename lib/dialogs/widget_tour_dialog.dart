import 'package:beautiful_dialog/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class WidgetTourDialog {
  static void showWidgetTourDialog(
    BuildContext context, {
    required List<WidgetItem> widgetItems,
  }) async {
    int currentIndex = 0;

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Tour des Widgets'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Widget ${currentIndex + 1}/${widgetItems.length}'),
                  SizedBox(height: 10),
                  Text(widgetItems[currentIndex].description),
                  SizedBox(height: 10),
                  widgetItems[currentIndex].widget,
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: currentIndex > 0
                      ? () {
                          setState(() {
                            currentIndex--;
                          });
                        }
                      : null,
                  child: Text('Précédent'),
                ),
                TextButton(
                  onPressed: currentIndex < widgetItems.length - 1
                      ? () {
                          setState(() {
                            currentIndex++;
                          });
                        }
                      : null,
                  child: Text('Suivant'),
                ),
                TextButton(
                  child: Text('Fermer'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class WidgetItem {
  final String description;
  final Widget widget;

  WidgetItem({required this.description, required this.widget});
}

class WidgetExtractor {
  static List<WidgetItem> extractWidgetItemsFromContext(BuildContext context) {
    List<WidgetItem> widgetItems = [];

    void visitElement(Element element) {
      if (element.widget is CustomButton) {
        final CustomButton customButton = element.widget as CustomButton;
        widgetItems.add(WidgetItem(
          description: customButton.text,
          widget: customButton,
        ));
      }
      // Appelle récursivement les éléments enfants
      element.visitChildElements(visitElement);
    }

    // Parcours des éléments à partir du contexte
    context.visitChildElements(visitElement);
    return widgetItems;
  }
}
