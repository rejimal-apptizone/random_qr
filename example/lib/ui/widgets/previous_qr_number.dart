import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PreviousQrNumber extends StatelessWidget {
  final int previousNumber;

  const PreviousQrNumber({
    Key key,
    this.previousNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return previousNumber != null
        ? Container(
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: 4,
                    left: 20,
                    right: 20,
                  ),
                  width: double.infinity,
                  height: 90,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    color: Color(0xFF121212),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 8,
                      left: 120,
                    ),
                    child: RichText(
                      text: TextSpan(
                        text: 'PREVIOUSLY SCANNED\n\n',
                        style: DefaultTextStyle.of(context).style.copyWith(
                              color: Colors.white.withOpacity(0.75),
                              fontSize: 12,
                            ),
                        children: <TextSpan>[
                          TextSpan(
                            text: previousNumber.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    width: 90,
                    height: 90,
                    margin: EdgeInsets.only(left: 25),
                    child: QrImage(data: previousNumber.toString()),
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
          )
        : Container();
  }
}
