import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DialogContent extends StatefulWidget {
  const DialogContent({super.key});

  @override
  State<DialogContent> createState() => _DialogContentState();
}

class _DialogContentState extends State<DialogContent>
    with TickerProviderStateMixin {
  late AnimationController posController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 300));

  late AnimationController sizeController = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 150));

  GlobalKey contentKey = GlobalKey();
  Size contentSize = const Size(0, 0);

  List<String> discs = [
    "assets/cd1.svg",
    "assets/cd2.svg",
    "assets/cd3.svg",
    "assets/cd9.svg",
    "assets/cd5.svg",
    "assets/cd8.svg",
  ];

  double contentHeight = 380;
  double contentWidth = 0;
  double chosedAvatarH = 130;
  double unChosedRaduis = 45;
  double chosedRaduis = 60;
  double horizontalPadding = 20;

  int currentId = -1;
  int lastId = -1;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox contentBox =
          contentKey.currentContext!.findRenderObject() as RenderBox;

      setState(() {
        contentSize = contentBox.size;
      });
    });
  }

  @override
  void dispose() {
    posController.dispose();
    sizeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: posController,
        builder: (context, child) {
          return Container(
            key: contentKey,
            height: contentHeight,
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding, vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: chosedAvatarH,
                    width: chosedAvatarH,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color.fromARGB(255, 232, 230, 233),
                              Color.fromARGB(255, 204, 198, 203),
                            ]),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(255, 204, 198, 203),
                            offset: Offset(0, 8),
                            blurRadius: 2,
                          )
                        ]),
                    child: Center(
                      child: CircleAvatar(
                        radius: chosedRaduis,
                        backgroundColor:
                            const Color.fromARGB(255, 190, 185, 186),
                      ),
                    ),
                  ),
                ),
                ...List.generate(discs.length, (index) {
                  final row = index ~/ 2;
                  final column = index % 2;

                  double boxWidth = unChosedRaduis * 2;

                  double colSpacing = column == 0 ? 20 : 30;
                  double rowSpacing = row == 0 ? 0 : 10;
                  double firstLeft = (contentSize.width -
                          ((boxWidth + 10) * 3) -
                          (horizontalPadding * 2)) /
                      2;

                  double defLeft = (row * (boxWidth + rowSpacing));
                  double defTop =
                      (column * boxWidth) + chosedAvatarH + colSpacing;

                  Animation<double> leftTween =
                      AlwaysStoppedAnimation(defLeft + firstLeft);
                  Animation<double> topTween = AlwaysStoppedAnimation(defTop);
                  Animation<double> boxSizeTween =
                      AlwaysStoppedAnimation(boxWidth);

                  if (currentId == index) {
                    leftTween = Tween<double>(
                            begin: defLeft + firstLeft,
                            //15 is padding - space between the avatar and the container parent of the avatar
                            end: (contentSize.width / 2) -
                                (chosedAvatarH / 2) -
                                15)
                        .animate(posController);

                    //5 : difference between avatar widget and its parent container
                    topTween = Tween<double>(begin: defTop, end: 5)
                        .animate(posController);

                    boxSizeTween =
                        Tween<double>(begin: boxWidth, end: chosedRaduis * 2)
                            .animate(sizeController);
                  } else if (lastId == index) {
                    leftTween = Tween<double>(
                            begin: (contentSize.width / 2) -
                                (chosedAvatarH / 2) -
                                15,
                            end: defLeft + firstLeft)
                        .animate(posController);

                    topTween = Tween<double>(begin: 5, end: defTop)
                        .animate(posController);

                    boxSizeTween =
                        Tween<double>(begin: chosedRaduis * 2, end: boxWidth)
                            .animate(sizeController);
                  }
                  return Positioned(
                    left: leftTween.value,
                    top: topTween.value,
                    child: GestureDetector(
                      onTap: () {
                        if (currentId != index) {
                          setState(() {
                            lastId = currentId;
                            currentId = index;
                            sizeController.forward(from: 0);
                            posController.forward(from: 0);
                          });
                        }
                      },
                      child: SvgPicture.asset(
                        fit: BoxFit.fill,
                        allowDrawingOutsideViewBox: true,
                        discs[index],
                        width: boxSizeTween.value,
                        height: boxSizeTween.value,
                      ),
                    ),
                  );
                })
              ],
            ),
          );
        });
  }
}
