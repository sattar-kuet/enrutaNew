import 'package:enruta/controllers/productController.dart';
import 'package:enruta/helper/helper.dart';
import 'package:enruta/helper/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetails extends StatelessWidget {
  final pController = Get.put(ProductController());
  final listImageHeader = [
    'assets/icons/photo.png',
    'assets/icons/photo.png',
    'assets/icons/photo.png',
    'assets/icons/photo.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          widgetPageViewHeader(),
          Align(
            alignment: Alignment.bottomCenter,
            child: WidgetDescription(),
          ),
        ],
      ),
    );
  }

  Widget widgetPageViewHeader() {
    var heightImage = Get.height / 1.3;
    return Container(
      height: heightImage,
      child: Stack(
        children: <Widget>[
          PageView.builder(
            itemBuilder: (context, index) {
              return Image.asset(
                listImageHeader[index],
                fit: BoxFit.fill,
              );
            },
            itemCount: listImageHeader.length,
            onPageChanged: (index) {
              pController.changeIndex(index);
              print(pController.position.value);
              // setState(() {
              //   _indexHeader = index;
              // });
            },
          ),
          Padding(
            padding: EdgeInsets.only(
              top: Get.height / 2.1,
              right: 20,
            ),
            child: Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  for (int i = 0; i < listImageHeader.length; i++)
                    if (i == pController.position.value)
                      circleBar(true)
                    else
                      circleBar(false),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isActive ? 16 : 12,
      width: isActive ? 16 : 12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: isActive ? Color(Helper.getHexToInt("#11C4A1")) : null,
        // border: isActive
        //     ? Border.all(color: Color(Helper.getHexToInt("#11C4A1")))
        //     : null,
      ),
      padding: EdgeInsets.all(isActive ? 4.0 : 0.0),
      child: Container(
        width: isActive ? 16 : 16,
        height: isActive ? 16 : 16,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Color(Helper.getHexToInt("#11C4A1")).withOpacity(0.22),
        ),
      ),
    );
  }
}

Widget productColor(bool isActive, String color) {
  // bool isActive = true;
  return Row(
    children: [
      AnimatedContainer(
        duration: Duration(milliseconds: 250),
        margin: EdgeInsets.symmetric(horizontal: 3.0),
        height: isActive ? 40 : 40,
        width: isActive ? 40 : 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          // color: isActive ? Color(Helper.getHexToInt("#11C4A1")) : null,
          // image: isActive ? Icon(Icons.check_circle, color: white) :null,

          // image: ImageIcon(Icons.ac_unit),
          border: isActive
              ? Border.all(
                  color: Color(Helper.getHexToInt(color)),
                  width: 3,
                )
              : null,
        ),
        padding: EdgeInsets.all(isActive ? 1.0 : 0.0),
        child: Container(
          width: isActive ? 40 : 40,
          height: isActive ? 40 : 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: isActive ? white : Color(Helper.getHexToInt(color))),
          child: isActive
              ? Icon(
                  Icons.check_circle,
                  color: Colors.red,
                  size: 32,
                )
              : null,
        ),
      ),
    ],
  );
}

Widget productSize(bool isActive, String size) {
  // bool isActive = true;
  return Row(
    children: [
      AnimatedContainer(
        duration: Duration(milliseconds: 250),
        margin: EdgeInsets.symmetric(horizontal: 3.0),
        height: isActive ? 40 : 40,
        width: isActive ? 40 : 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: isActive
              ? Color(Helper.getHexToInt("#11E5A1"))
              : Color(Helper.getHexToInt("#F7F8FA")),
          // border: isActive
          //     ? Border.all(color: Color(Helper.getHexToInt("#F7F8FA")))
          //     : null,
        ),
        padding: EdgeInsets.all(isActive ? 4.0 : 0.0),
        child: Center(
          child: Text(
            size,
            style: TextStyle(
                fontSize: 14,
                fontFamily: 'TTCommonsm',
                color: isActive ? white : Color(Helper.getHexToInt("#8D92A3"))),
          ),
          // width: isActive ? 40 : 40,
          // height: isActive ? 40 : 40,
          // decoration: BoxDecoration(
          //     borderRadius: BorderRadius.all(Radius.circular(20)),
          //     color: Color(Helper.getHexToInt("#F7F8FA"))),
        ),
      ),
    ],
  );
}

class WidgetDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Container(
      height: mediaQuery.size.height / 2.2,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 24.0, top: 40.0, right: 24.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return ListView(
                  padding: EdgeInsets.only(
                      bottom: mediaQuery.size.height -
                          mediaQuery.size.height / 1.1 +
                          16.0),
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _buildWidgetProductName(context),
                        SizedBox(
                          height: 10,
                        ),
                        // ListView.builder(
                        //     itemCount: 4,
                        //     scrollDirection: Axis.vertical,
                        //     itemBuilder: (context, index) {
                        //       return productColor();
                        //     }),
                        Row(
                          children: [
                            Container(
                              child: Text(
                                "COLOR",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'TTCommonsm',
                                    color:
                                        Color(Helper.getHexToInt("#8D92A3"))),
                              ),
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            productColor(true, "#F5003C"),
                            SizedBox(
                              width: 15,
                            ),
                            productColor(false, "#F5C300"),
                            SizedBox(
                              width: 15,
                            ),
                            productColor(false, "#00C6F5"),
                            SizedBox(
                              width: 15,
                            ),
                            productColor(false, "#7800F5"),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Container(
                              child: Text(
                                "SIZE",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'TTCommonsm',
                                    color:
                                        Color(Helper.getHexToInt("#8D92A3"))),
                              ),
                            ),
                            SizedBox(
                              width: 58,
                            ),
                            productSize(true, "XS"),
                            SizedBox(
                              width: 15,
                            ),
                            productSize(false, "S"),
                            SizedBox(
                              width: 15,
                            ),
                            productSize(false, "M"),
                            SizedBox(
                              width: 15,
                            ),
                            productSize(false, "L"),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // _buildWidgetProductPrice(context),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 16.0, bottom: 16.0),
                          child: Divider(
                              thickness: 1,
                              color: Color(
                                Helper.getHexToInt("#F1F3F8"),
                              )),
                        ),
                        // WidgetChooseColor(),
                        SizedBox(height: 16.0),
                        // WidgetChooseSize(),
                        buidbottomfield(),
                        // _buildWidgetProductInfo(context),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            // child: WidgetAddToBag(),
          ),
        ],
      ),
    );
  }

  // Widget _buildWidgetProductPrice(BuildContext context) {
  //   return Text(
  //     'Rp 159.000',
  //     style: Theme.of(context).textTheme.body1.merge(TextStyle(fontSize: 16.0)),
  //   );
  // }

  Widget _buildWidgetProductName(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Text(
                'Levi’s T-shirt',
                style: TextStyle(
                    fontFamily: "TTCommonsm",
                    fontSize: 24,
                    color: Color(Helper.getHexToInt("#000000"))),
              ),
            ),
            Wrap(
              direction: Axis.vertical,
              children: <Widget>[
                Text(
                  "\$" + "573",
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'TTCommonsd',
                      color: Color(Helper.getHexToInt("#000000"))
                          .withOpacity(0.4)),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  // ignore: unused_element
  Widget _buildWidgetProductInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'This is a beautiful women Mini Dress for your daily look, '
                  'it is elegance meets... ',
              style: Theme.of(context)
                  .textTheme
                  // ignore: deprecated_member_use
                  .body1
                  .merge(TextStyle(fontSize: 16.0)),
            ),
            TextSpan(
                text: 'More',
                // ignore: deprecated_member_use
                style: Theme.of(context).textTheme.body1.merge(
                      TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ))
          ],
        ),
      ),
    );
  }

  Widget buidbottomfield() {
    return InkWell(
      onTap: () {
        // Get.bottomSheet();
      },
      child: Stack(
        children: [
          Container(
            height: 60,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topLeft, colors: [
                Color(Helper.getHexToInt("#11C7A1")),
                // Colors.green[600],
                Color(Helper.getHexToInt("#11E4A1"))
              ]),
              // color: Colors.white,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Center(
                child: Text(
              "Add to Cart",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontFamily: 'TTCommonsm',
              ),
            )),
          ),
        ],
      ),
    );
  }
}
