import 'package:flutter/material.dart';

class TopCircle extends StatelessWidget {
  final bool showLogoutButton;
  final Function() onTapHandler;

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
        height: 100,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(75),
            bottomLeft: Radius.circular(75),
          ),
          color: Color(0xFF3D3A6B),
        ),
        child: showLogoutButton
            ? GestureDetector(
                onTap: onTapHandler,
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 8),
                    child: const Text(
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
