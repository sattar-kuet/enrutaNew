import 'package:enruta/controllers/language_controller.dart';
import 'package:enruta/helper/helper.dart';
import 'package:enruta/helper/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class GetReviewPage extends StatelessWidget {

  final language = Get.put(LanguageController());
  String text(String key) {
    return language.text(key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        color: cardbackgroundColor,
        child: ListView(
          children: [
            Container(
              height: 40,
              padding: EdgeInsets.only(
                top: 20,
              ),
              child: InkWell(
                // onTap: Get.back(),

                onTap: () {
                  Navigator.pop(context);
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
            Container(
              height: 50,
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
            SizedBox(
              height: 10,
            ),
            Expanded(
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
                      child: RatingBar(
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
                          print(rating);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
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
                      child: RatingBar(
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
                          print(rating);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 30,
              padding: EdgeInsets.only(
                top: 10,
              ),
              child: Text(
                text('who_was_everything_else'),
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'TTCommonsd',
                    color:
                        Color(Helper.getHexToInt("#3B3A3A")).withOpacity(.8)),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
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
                      child: RatingBar(
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
                          print(rating);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
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
                      child: RatingBar(
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
                          print(rating);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: 20,
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
                      child: RatingBar(
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
                          print(rating);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
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
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Container(
                    height: 90,
                    child: TextFormField(
                      minLines: 5,
                      maxLines: 7,
                      decoration: InputDecoration(
                        hintText: text('help_others_to_find_good_food'),
                        // border: InputBorder.none,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {},
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
      ),
    );
  }
}
