import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:transparent_image/transparent_image.dart';

class ItemList extends StatelessWidget {
  final String image;
  final String title;
  final String city;
  final double rating;
  final Function() onPressed;
  const ItemList({
    required this.image,
    required this.title,
    required this.city,
    required this.rating,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.0),
      child: Material(
        color: Colors.white,
        shadowColor: Colors.grey[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(15.0),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 14.0,
              horizontal: 16.0,
            ),
            child: Row(
              children: [
                Hero(
                  tag: '$image',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: image,
                      height: 72.0,
                      width: 72.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          color: Colors.black87,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      Text(
                        city,
                        style: GoogleFonts.poppins(
                          color: Colors.black87,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.none,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '$rating',
                            style: GoogleFonts.poppins(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 8.0),
                          RatingBar.builder(
                            initialRating: rating,
                            allowHalfRating: true,
                            ignoreGestures: true,
                            minRating: 1,
                            maxRating: 5,
                            itemCount: 5,
                            itemSize: 14.0,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
