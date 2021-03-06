import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:randnumber_example/ui/widgets/custom_container.dart';

class GeneratedQrNumber extends StatelessWidget {
  final String randomNumber;

  const GeneratedQrNumber({
    Key key,
    this.randomNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return randomNumber != null
        ? SizedBox(
            height: 400,
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 175,
                    left: 20,
                    right: 20,
                  ),
                  width: double.infinity,
                  height: 175,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                    color: Color(0xFF121212),
                  ),
                  child: Stack(
                    children: [
                      CustomContainer(),
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 30),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Generated number\n\n',
                              style:
                                  DefaultTextStyle.of(context).style.copyWith(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: randomNumber,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 200,
                    height: 200,
                    margin: const EdgeInsets.only(top: 25),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12),
                      ),
                    ),
                    child: QrImage(
                      data: randomNumber,
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
