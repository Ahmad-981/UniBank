import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:unibank/consts/consts.dart';
import 'package:unibank/views/transactions/bills/pay.dart';
import 'package:unibank/widgets_common/functions.dart';
import 'package:unibank/widgets_common/submit_button.dart';

class PAyBill extends StatelessWidget {
  PAyBill({super.key, required this.phone, required this.provide});
  final TextEditingController _moneyController = TextEditingController();
  final String provide;
  final String phone;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar("Pay"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8.0, top: 8),
              child: Text(
                "Utility Bills",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8.0, bottom: 12),
              child: Text(
                "Specify Bill Details",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
              ),
            ),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: redColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          height: 100,
                          child: TextFormField(
                            controller: _moneyController,
                            keyboardType: TextInputType.number,
                            maxLength: 8,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'xxxxxxxx',
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  //fontWeight: FontWeight.bold,
                                  fontFamily: semibold),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Text(
                          "Enter 8 Digit reference number\nwritten on your bill",
                          style: TextStyle(
                              color: Colors.white,
                              //fontWeight: FontWeight.normal,
                              fontSize: 12,
                              fontFamily: bold),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.payment,
                          color: redColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              child: CustomSubmitButton(
                  text: "Fetch your Bill",
                  width: MediaQuery.of(context).size.width * 1,
                  ontap: () {
                    Get.to(
                        () => FinalPayPage(
                              provider: provide,
                              phone: phone,
                              name: provide,
                            ),
                        transition: Transition.leftToRightWithFade,
                        duration: const Duration(milliseconds: 400));
                  }),
            )
          ],
        ),
      ),
    );
  }
}
