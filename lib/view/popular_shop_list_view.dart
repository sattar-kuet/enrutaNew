import 'package:enruta/model/popular_shop.dart';
import 'package:enruta/screen/menuandreviewpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../helper/helper.dart';

class PopularShopListView extends StatelessWidget {
  const PopularShopListView(
      {Key key,
      this.itemData,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback callback;
  final Datums itemData;
  final AnimationController animationController;
  final Animation<dynamic> animation;

//  Widget _bgCard(String titels, String imageicon, String info, String unit,
//       bool loveicon) {

//   }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 255,
      width: 180,
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MenuAndReviewPage(
                      itemData.shopId,
                      itemData.vat.toInt(),
                      itemData.deliveryCharge,
                      itemData.name,
                      itemData.address)));
        },
        child: Stack(
          children: [
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 30,
                child: Container(
                  // height: MediaQuery.of(context).size.height / 8,
                  // width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      alignment: Alignment.center,
                      matchTextDirection: false,
                      image: NetworkImage(
                          itemData.logo), //AssetImage(itemData.logo),
                      fit: BoxFit.contain,
                    ),
                  ),
                  // decoration: BoxDecoration(
                  //   color: Colors.white,
                  //   borderRadius: BorderRadius.circular(20),
                  // ),
                )),
            Positioned(
              child: Container(
                  height: 30,
                  // child: Padding(
                  //     padding: const EdgeInsets.only(top: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          // child: Padding(
                          //     padding: const EdgeInsets.all(0.0),
                          child: Container(
                              margin: EdgeInsets.only(right: 50),
                              padding:
                                  EdgeInsets.only(left: 8, top: 8, bottom: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    // topRight: Radius.circular(10.0),
                                    // bottomLeft: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0)),
                                color: Color(Helper.getHexToInt("#ECFBF8")),
                              ),
                              // child: Center(
                              child: Text(
                                itemData.time,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontFamily: 'Poppinsr',
                                    fontSize: 10,
                                    color: Color(Helper.getHexToInt("#11C4A1"))
                                        .withOpacity(1)),
                              )
                              // ),
                              )),
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(right: 5, top: 5),
                          child: ClipOval(
                            child: GestureDetector(
                              child: Container(
                                  height: 25,
                                  width: 25,
                                  color: itemData.favorite
                                      ? Color(Helper.getHexToInt("#FFEEEE"))
                                      : Color(Helper.getHexToInt("#F9F9F9")),
                                  child: IconButton(
                                    padding: EdgeInsets.all(0),
                                    onPressed: () {},
                                    icon: itemData.favorite
                                        ? Icon(Icons.favorite,
                                            color: Color(
                                                Helper.getHexToInt("#FF5A5A")),
                                            size: 15)
                                        : Icon(
                                            Icons.favorite,
                                            color: Color(
                                                Helper.getHexToInt("#C0C0C0")),
                                            size: 15,
                                          ),
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            Positioned(
              bottom: 45,
              left: 10,
              right: 10,
              child: Center(
                child: Container(
                  height: 20,

                  // width: 100,
                  // padding: EdgeInsets.only(left: 20),
                  // margin: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                    color: Color(Helper.getHexToInt("#F8F9FF")),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 7),
                            child: RatingBar(
                              initialRating: itemData.rating,

                              // minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 11,

                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                size: 1.0,
                                color: Colors.amber,
                              ),

                              onRatingUpdate: (rating) {
                                print(itemData.rating);
                              },
                            ),
                          ),
                        ),
                      ),
                      // Expanded(
                      //   child:
                      Container(
                          // width: 50,
                          padding: EdgeInsets.only(right: 10),
                          child: Text(
                            // '8888522 Reviews',
                            ' ${itemData.totalReview} Reviews',
                            style: TextStyle(
                                fontFamily: 'TTCommonsd',
                                fontSize: 11,
                                color: Color(Helper.getHexToInt("#000000"))
                                    .withOpacity(0.4)),
                            textAlign: TextAlign.end,
                          )),
                      // )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(bottom: 28, left: 10, right: 10, child: Divider()),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Text(
                itemData.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'TTCommonsr',
                    fontSize: 17,
                    color: Color(Helper.getHexToInt("#434343")).withOpacity(1)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
