import 'package:fliqcard/Helpers/constants.dart';
import 'package:flutter/material.dart';

buildNoFliqcradWidget(BuildContext context) {
  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;

  return InkWell(
    onTap: () {},
    child: Container(
      margin: EdgeInsets.all(10),
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Container(
              width: screenWidth,
              child: Image.asset(
                "assets/notfound.png",
                fit: BoxFit.cover,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      "Please create FliQCard by tapping + Icon from Menu.",
                      style: TextStyle(
                          color: Color(COLOR_PRIMARY),
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
