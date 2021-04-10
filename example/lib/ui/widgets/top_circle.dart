import 'package:flutter/material.dart';

class TopCircle extends StatelessWidget {
  final bool showLogoutButton;
  final Function onTapHandler;

  const TopCircle({
    @required this.showLogoutButton,
    this.onTapHandler,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(100),
          ),
          color: Color(0xFF3D3A6B),
        ),
        child: showLogoutButton
            ? GestureDetector(
                onTap: onTapHandler,
                child: Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 25),
                    child: Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              )
            : Container(),
      ),
    );
  }
}
