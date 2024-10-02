# Beautiful Dialogs - Flutter

![Demo](./demo/demo.gif)

Welcome to **Beautiful Dialogs**, a Flutter open-source project where developers can contribute by adding beautiful dialog widgets! 🌟

## Getting Started

To contribute to this project, follow these simple steps:

### 1. Fork the repository and don't forget to add a star ⭐

Go to the [repository](https://github.com/Docteur-Parfait/beautiful_dialog.git) and click the **Fork** button. Remember to star the project to show your support!

### 2. Clone the repository

Clone your forked repository locally:

```bash
git clone https://github.com/YOUR_USERNAME/beautiful_dialog.git
cd beautiful_dialog
```

### 3. Create a new branch

Create a new branch where you can add your dialog:

```bash
git checkout -b your-branch-name
```

### 4. Add your custom dialog

In the code, navigate to the file `lib/dialogs/dialog_class.dart`. This is where you will add your custom dialog function. For example:

```dart
static void showDangerAlertDialog(BuildContext context,
    {required String warningMessage}) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.red[50],
        title: const Text(
          'Danger',
          style: TextStyle(color: Colors.red),
        ),
        content: Text(
          warningMessage,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
```

### 5. Call your dialog

In `lib/views/dialog_view.dart`, use the `CustomButton` widget to call your dialog like this:

```dart
CustomButton(
  text: "Danger alert",
  author: "Tech Pastor",
  onTap: () => DialogClass.showDangerAlertDialog(context,
      warningMessage: "Do you want to logout?"),
)
```

### 6. Commit, push, and submit a pull request

After adding your dialog, commit your changes:

```bash
git add .
git commit -m "Added new custom dialog"
git push origin your-branch-name
```

Then, open a pull request from your forked repository.

## Contribution Guidelines

- Contributions must only involve adding new dialogs.
- Respect the code structure and the contribution process as described.

Happy coding and thank you for contributing to **Beautiful Dialogs**! 😄
