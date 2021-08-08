import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ItemListShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: Container(
        margin: EdgeInsets.only(bottom: 12.0),
        padding: EdgeInsets.symmetric(
          vertical: 14.0,
          horizontal: 16.0,
        ),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.4),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Row(
          children: [
            Container(
              height: 72.0,
              width: 72.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            SizedBox(
              width: 16.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 18.0,
                  width: 150.0,
                  margin: EdgeInsets.symmetric(
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                Container(
                  height: 18.0,
                  width: 80.0,
                  margin: EdgeInsets.symmetric(
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                Container(
                  height: 18.0,
                  width: 120.0,
                  margin: EdgeInsets.symmetric(
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
    );
  }
}
