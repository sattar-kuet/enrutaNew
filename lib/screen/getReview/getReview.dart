import 'package:enruta/controllers/language_controller.dart';
import 'package:enruta/controllers/textController.dart';
import 'package:enruta/helper/helper.dart';
import 'package:enruta/helper/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../homePage.dart';

class GetReviewPage extends StatelessWidget {
  final tController = Get.put(TestController());
  final language = Get.put(LanguageController());
  final int shopid;

  GetReviewPage(this.shopid);
  String text(String key) {
    return language.text(key);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController reviewcont = new TextEditingController(text: "");
    String review;
    double r1, r2, r3, r4, r5 = 1.0;
    return Scaffold(
        body: ListView(padding: EdgeInsets.only(top: 30, left: 20, right: 20),
            // color: cardbackgroundColor,
            children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Container(
                  padding: EdgeInsets.only(
                    top: 20,
                  ),
                  child: InkWell(
                    // onTap: Get.back(),

                    onTap: () async {
                      SharedPreferences spreferences =
                          await SharedPreferences.getInstance();
                      spreferences.setInt("OrderCompletedShop", null);
                      Get.offAll(HomePage());
                    },
                    child: CircleAvatar(
                      backgroundColor: Color(Helper.getHexToInt("#F2F2F2")),
                      child: Icon(
                        Icons.close_rounded,
                        color: theamColor,
                        size: 20,
                      ),
                    ),
                  ),

                  // Align(
                  //     alignment: Alignment.centerRight,
                  //     child: Icon(Icons.close))
                ),
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.only(
                    top: 10,
                  ),
                  child: Text(
                    text('thanks_for_your_rating'),
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'TTCommonsd',
                        color: Colors.black.withOpacity(0.8)),
                  ),
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    Container(
                      height: 20,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          text('food'),
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'TTCommonsd',
                            color: Color(Helper.getHexToInt("#3B3A3A"))
                                .withOpacity(.8),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: RatingBar.builder(
                          initialRating: 3,

                          // minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 25,

                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            size: 1.0,
                            color: Colors.amber,
                          ),

                          onRatingUpdate: (rating) {
                            r1 = rating;
                            print(rating);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: SizedBox(
                  height: 20,
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    Container(
                      height: 20,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          text('food'),
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'TTCommonsd',
                              color: Color(Helper.getHexToInt("#3B3A3A"))
                                  .withOpacity(.8)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: RatingBar.builder(
                          initialRating: 3,

                          // minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 25,

                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            size: 1.0,
                            color: Colors.amber,
                          ),

                          onRatingUpdate: (rating) {
                            r2 = rating;
                            print(rating);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Container(
                  height: 30,
                  padding: EdgeInsets.only(
                    top: 10,
                  ),
                  child: Text(
                    text('How was everything else'),
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'TTCommonsd',
                        color: Color(Helper.getHexToInt("#3B3A3A"))
                            .withOpacity(.8)),
                  ),
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    Container(
                      height: 20,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          text('packaging'),
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'TTCommonsd',
                              color: Color(Helper.getHexToInt("#3B3A3A"))
                                  .withOpacity(.8)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: RatingBar.builder(
                          initialRating: 3,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 25,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            size: 1.0,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            r3 = rating;
                            print(rating);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Flexible(
                child: Column(
                  children: [
                    Container(
                      height: 20,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          text('rider'),
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'TTCommonsd',
                              color: Color(Helper.getHexToInt("#3B3A3A"))
                                  .withOpacity(.8)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: RatingBar.builder(
                          initialRating: 3,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 25,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            size: 1.0,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            r4 = rating;
                            print(rating);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Flexible(
                child: Column(
                  children: [
                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          text('timeliness'),
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'TTCommonsd',
                              color: Color(Helper.getHexToInt("#3B3A3A"))
                                  .withOpacity(.8)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        child: RatingBar.builder(
                          initialRating: 3,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 25,
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            size: 1.0,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            r5 = rating;
                            print(rating);
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      padding: EdgeInsets.only(
                        top: 20,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          text('everything_else_to_add'),
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'TTCommonsd',
                              color: Color(Helper.getHexToInt("#3B3A3A"))
                                  .withOpacity(.8)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 90,
                      child: TextField(
                        controller: reviewcont,
                        minLines: 5,
                        maxLines: 7,
                        onChanged: (v) {
                          return;
                        },
                        decoration: InputDecoration(
                          hintText: text('help_others_to_find_good_food'),
                          // border: InputBorder.none,
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        double rating = ((r1 + r2 + r3 + r4 + r5) / 5);
                        print(reviewcont.text);
                        print(rating);
                        await tController.addrivew(
                            shopid, rating, reviewcont.text);
                        SharedPreferences spreferences =
                            await SharedPreferences.getInstance();
                        spreferences.setInt("OrderCompletedShop", null);
                        Get.offAll(HomePage());
                      },
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              colors: [
                                Color(Helper.getHexToInt("#11C7A1")),
                                Color(Helper.getHexToInt("#11E4A1"))
                              ]),
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: Center(
                            child: Text(
                          text('done'),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'TTCommonsm',
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ]));
  }
}
