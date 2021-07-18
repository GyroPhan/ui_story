import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ui_story_app/customIcons.dart';
import './data.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

var cardAspectRaito = 12.0 / 16.0;
var widgetAspectRaito = cardAspectRaito * 1.2;

class _MyAppState extends State<MyApp> {
  var currentPage = images.length - 1.0;
  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(initialPage: images.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page;
      });
    });

    return Scaffold(
      backgroundColor: Color(0xFF2d3447),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, top: 30, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      icon: Icon(
                        CustomIcon.menu,
                        color: Colors.white,
                      ),
                      onPressed: () {}),
                  IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      onPressed: () {}),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Trending',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 46,
                        fontFamily: 'Calibre-Semibold',
                        letterSpacing: 1),
                  ),
                  IconButton(
                      icon: Icon(
                        CustomIcon.option,
                        size: 12,
                        color: Colors.white,
                      ),
                      onPressed: () {})
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Color(0xffff6e6e),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 22, vertical: 6),
                        child: Text(
                          'Animated',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Text(
                    '25+ Stories',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                CardScrollWidget(
                  currentPage: currentPage,
                ),
                Positioned.fill(
                    child: PageView.builder(
                        itemCount: images.length,
                        controller: controller,
                        reverse: true,
                        itemBuilder: (context, index) {
                          return Container();
                        }))
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Favourite',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 46,
                        fontFamily: 'Calibre-Semibold',
                        letterSpacing: 1),
                  ),
                  IconButton(
                      icon: Icon(
                        CustomIcon.option,
                        size: 12,
                        color: Colors.white,
                      ),
                      onPressed: () {})
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 22, vertical: 6),
                        child: Text(
                          'Latest',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Text(
                    '9+ Stories',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 18),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/image_1.jpg',
                      width: 296,
                      height: 222,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CardScrollWidget extends StatelessWidget {
  var currentPage;
  var padding = 20;
  var verticalInset = 20;

  CardScrollWidget({this.currentPage});
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: widgetAspectRaito,
      child: LayoutBuilder(
        builder: (context, contraints) {
          var width = contraints.maxWidth;
          var height = contraints.maxHeight;

          var safeWidth = width - 2 * padding;
          var safeHeight = height - 2 * padding;

          var heightOfPrimaryCard = safeHeight;
          var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRaito;

          var primaryCardLeft = safeWidth - widthOfPrimaryCard;
          var horizontalInset = primaryCardLeft / 2;

          List<Widget> cardList = List();

          for (int i = 0; i < images.length; i++) {
            var delta = i - currentPage;
            bool isOnRight = delta > 0;
            var start = padding +
                max(
                    primaryCardLeft -
                        horizontalInset * -delta * (isOnRight ? 15 : 1),
                    0.0);

            var cardItem = Positioned.directional(
              top: double.parse(
                  (padding + verticalInset * max(-delta, 0.0)).toString()),
              bottom: double.parse(
                  (padding + verticalInset * max(-delta, 0.0)).toString()),
              start: start,
              textDirection: TextDirection.rtl,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(3, 6),
                        blurRadius: 10)
                  ]),
                  child: AspectRatio(
                    aspectRatio: cardAspectRaito,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          images[i],
                          fit: BoxFit.cover,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Text(
                                  title[i],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontFamily: 'SF-Pro-Text-Regular'),
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, bottom: 12),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 22, vertical: 6),
                                  decoration: BoxDecoration(
                                      color: Colors.blueAccent,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    'Read later',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
            cardList.add(cardItem);
          }
          return Stack(
            children: cardList,
          );
        },
      ),
    );
  }
}
