import 'package:flutter/material.dart';

class DiscardChangesDialog {
  static void showDiscardDialog(BuildContext context) async {
    bool isDesktop = MediaQuery.of(context).size.width >= 1024.0;
    Size size = MediaQuery.of(context).size;

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.grey[900],
          child: Container(
            padding: const EdgeInsets.only(bottom: 12),
            height: isDesktop ? size.height * 0.25 : size.height * 0.22,
            width: isDesktop ? size.width * 0.24 : size.width * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 66, 66, 66),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Discard unsaved changes?",
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(18, 9, 18, 0),
                  child: Text(
                    "This will delete all edits since you last saved",
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 189, 189, 189),
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 0, 22, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                              color: Color.fromARGB(255, 189, 189, 189),
                              width: 1.5),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Keep editing',
                          style: TextStyle(
                            color: Color.fromARGB(255, 189, 189, 189),
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          backgroundColor: Colors.red[600],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Discard',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
