import 'package:flutter/material.dart';

//Design source: https://dribbble.com/shots/24921582-Feedback-Modal

class FeedbackDialogContent extends StatefulWidget {
  const FeedbackDialogContent({
    super.key,
  });

  @override
  State<FeedbackDialogContent> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialogContent> {
  int stars = -1;
  TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //double width = MediaQuery.sizeOf(context).width;
    return Container(
      //width: width * 0.25,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            const Text(
              "What was your experience using this product?",
              style: TextStyle(
                  color: Color.fromARGB(255, 135, 135, 135),
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 20,
            ),
            //satisfation emojis
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(5, (index) {
                bool moodColored = false;
                if (stars > index) {
                  setState(() {
                    //update selected emoji
                    moodColored = true;
                  });
                }
                return Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 246, 246, 246),
                      borderRadius: BorderRadius.circular(10)),
                  child: IconButton(
                      onPressed: () {
                        setState(() {
                          //update number of emoji to be colored
                          stars = index + 1;
                        });
                      },
                      icon: Icon(
                        Icons.mood,
                        color: moodColored ? Colors.blue : Colors.grey,
                      )),
                );
              }),
            ),
            const SizedBox(
              height: 5,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dissattisfied",
                  style: TextStyle(
                      color: Color.fromARGB(255, 135, 135, 135),
                      fontWeight: FontWeight.w400),
                ),
                Text("Sattisfied",
                    style: TextStyle(
                        color: Color.fromARGB(255, 135, 135, 135),
                        fontWeight: FontWeight.w400))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            RichText(
              text: const TextSpan(
                  text: "write your feedback",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                        text: " (optional)",
                        style: TextStyle(
                            color: Color.fromARGB(255, 135, 135, 135),
                            fontWeight: FontWeight.w400))
                  ]),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: commentController,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 246, 246, 246),
                  focusColor: const Color.fromARGB(255, 246, 246, 246),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(15)),
                  hintText: "Please write here",
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 135, 135, 135),
                      fontWeight: FontWeight.w400)),
              maxLines: null,
              minLines: 5,
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
