import 'package:enruta/helper/helper.dart';
import 'package:enruta/model/payment_method_list_data.dart';
import 'package:flutter/material.dart';

class PaymentMethodListView extends StatelessWidget {
  const PaymentMethodListView(
      {Key key,
      this.paymentData,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback callback;
  final PaymentMethodListData paymentData;
  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              width: 2, color: Color(Helper.getHexToInt("#F0F0F0")))),
      child: InkWell(
        onTap: () {},
        child: Stack(
          children: [
            Positioned(
              top: 10,
              right: 20,
              bottom: 10,
              child: Container(
                height: 30,
                width: 51,
                child: Image.asset(paymentData.imagePath),
              ),
            ),
            Positioned(
              top: 24,
              left: 16,
              child: Center(
                child: Container(
                  child: Text(
                    paymentData.paymentTitle,
                    style: TextStyle(
                        fontFamily: "TTCommonsr",
                        fontSize: 13,
                        color: Color(Helper.getHexToInt("#8D8D8D"))),
                  ),
                ),
              ),
            ),
            Positioned(
                top: 42,
                left: 16,
                child: Center(
                  child: Text(
                    paymentData.paymentDetails,
                    style: TextStyle(
                        fontFamily: "TTCommonsr",
                        fontSize: 17,
                        color: Color(Helper.getHexToInt("#8D8D8D"))),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
