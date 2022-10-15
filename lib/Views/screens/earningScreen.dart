import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class EarningScreen extends ConsumerStatefulWidget {
  const EarningScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<EarningScreen> createState() => _EarningScreenState();
}

class _EarningScreenState extends ConsumerState<EarningScreen> {

   @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWeight = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Stack(
        children: [
          Positioned(
              top: 0,
              height: screenHeight * 0.4,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWeight, vertical: screenHeight * .15),
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
              )),
          Positioned(
            top: screenHeight*0.07,
            left: screenWeight*0.03,
            child: Container(
              child: Text(
                'Earnings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            top: screenHeight * 0.13,
            left: screenWeight * 0.09,
            child: Container(
              //padding: EdgeInsets.symmetric(horizontal: screenWeight*0.4, vertical: screenHeight*0.05),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: 20, bottom: 5, top: 20, right: 10),
                        child: Text('AVAILABLE BALANCE',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                            )),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 20, bottom: 15, top: 2, right: 10),
                        child: Text(
                          '£${'00.00'}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 45,
                  ),
                  Container(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Withdraw',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.amber,
                          padding: EdgeInsets.symmetric(horizontal: 32),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}