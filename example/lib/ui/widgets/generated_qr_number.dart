import 'package:flutter/material.dart';

class GeneratedQrNumber extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 175,
              left: 20,
              right: 20,
            ),
            width: double.infinity,
            height: 175,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
              color: Color(0xFF121212),
            ),
            child: Center(
              child: Container(
                margin: EdgeInsets.only(top: 30),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Generated number\n\n',
                    style: DefaultTextStyle.of(context).style.copyWith(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '12345',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: 200,
              height: 200,
              margin: EdgeInsets.only(top: 25),
              child: Image.asset("assets/images/qr.png"),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
