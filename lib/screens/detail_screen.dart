import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:resto/data/models/resto.dart';
import 'package:resto/providers/resto_detail_provider.dart';
import 'package:resto/screens/review_screen.dart';
import 'package:resto/screens/widgets/alert/alert_animation_widget.dart';
import 'package:resto/screens/widgets/builder/build_widget.dart';
import 'package:resto/screens/widgets/builder/platform_widget.dart';
import 'package:resto/shared/constants.dart';
import 'package:transparent_image/transparent_image.dart';

class DetailScreen extends StatelessWidget {
  static const routeName = '/detail';

  final String id;
  const DetailScreen({required this.id});

  Widget _buildGeneralInfoWidget({
    required String name,
    required String city,
    required String address,
    required List<Category> catrgories,
    required String description,
  }) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      color: Colors.white,
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0.1, end: 1),
        duration: Duration(milliseconds: 300),
        builder: (BuildContext context, double val, Widget? child) {
          return Opacity(
            opacity: val,
            child: Padding(
              padding: EdgeInsets.only(top: 16.0 / val),
              child: child,
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: GoogleFonts.poppins(
                fontSize: 22.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4.0),
            Row(
              children: [
                Icon(
                  defaultTargetPlatform == TargetPlatform.android
                      ? Icons.store_outlined
                      : CupertinoIcons.map,
                  color: Colors.grey[700],
                ),
                SizedBox(width: 8.0),
                Text(
                  '$address, $city',
                  style: GoogleFonts.poppins(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                for (var category in catrgories)
                  Container(
                    margin: EdgeInsets.only(right: 8.0),
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[50],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      category.name!,
                      style: GoogleFonts.poppins(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Deskripsi',
                  style: GoogleFonts.poppins(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: 8.0),
                ReadMoreText(
                  description,
                  trimLines: 2,
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.poppins(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                  trimCollapsedText: 'Lihat semua',
                  trimExpandedText: 'Lihat sebagian',
                  moreStyle: GoogleFonts.poppins(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.amber[700],
                  ),
                  lessStyle: GoogleFonts.poppins(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.amber[700],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuListWidget({
    required String label,
    required Icon icon,
    required List<Category> menus,
  }) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.white,
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0.1, end: 1),
        duration: Duration(milliseconds: 300),
        builder: (BuildContext context, double val, Widget? child) {
          return Opacity(
            opacity: val,
            child: child,
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            SizedBox(width: 8.0),
            Column(
              children: [
                for (var item in menus)
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        Container(
                          height: 48.0,
                          width: 48.0,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[50],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: icon,
                        ),
                        SizedBox(width: 16.0),
                        Text(
                          item.name!,
                          style: GoogleFonts.poppins(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildReviewWidget({
    required BuildContext context,
    required double rating,
    required List<CustomerReview> reviews,
  }) {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Colors.white,
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0.1, end: 1),
        duration: Duration(milliseconds: 300),
        builder: (BuildContext context, double val, Widget? child) {
          return Opacity(
            opacity: val,
            child: child,
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rating Keseluruhan',
              style: GoogleFonts.poppins(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                bottom: 16.0,
                top: 8.0,
              ),
              child: Row(
                children: [
                  Text(
                    '$rating / 5.0',
                    style: GoogleFonts.poppins(
                      fontSize: 20.0,
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
                    itemSize: 20.0,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                ],
              ),
            ),
            Text(
              'Apa Kata Mereka',
              style: GoogleFonts.poppins(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                bottom: 16.0,
                top: 8.0,
              ),
              child: Column(
                children: [
                  for (var review in reviews)
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              height: 64.0,
                              width: 56.0,
                              decoration: BoxDecoration(
                                color: Colors.blueGrey[50],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Icon(
                                Icons.person_outline,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                          SizedBox(width: 16.0),
                          Expanded(
                            flex: 4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  review.name!,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  review.date!,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[700],
                                  ),
                                ),
                                Text(
                                  review.review!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: defaultTargetPlatform == TargetPlatform.android
                  ? ElevatedButton(
                      child: Text(
                        'Tulis Review',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 14.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          ReviewScreen.routeName,
                          arguments: id,
                        );
                      },
                    )
                  : CupertinoButton.filled(
                      child: Text('Tulis Review'),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          ReviewScreen.routeName,
                          arguments: id,
                        );
                      },
                    ),
            ),
            SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    Provider.of<RestoDetailProvider>(
      context,
      listen: false,
    ).fetchRestoDetail(id);

    return Consumer<RestoDetailProvider>(
      builder: (context, state, _) {
        if (state.state == FetchResultState.Loading) {
          return Center(
            child: SpinKitFadingCircle(
              color: Colors.amber[700],
            ),
          );
        } else if (state.state == FetchResultState.HasData) {
          final resto = state.resto!.item;
          return SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  Hero(
                    tag: '${UrlList.imageUrl}${resto!.pictureId}',
                    child: FadeInImage.memoryNetwork(
                      placeholder: kTransparentImage,
                      image: '${UrlList.largeImageUrl}${resto.pictureId}',
                      height: 300.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                  _buildGeneralInfoWidget(
                    name: resto.name!,
                    city: resto.city!,
                    address: resto.address!,
                    catrgories: resto.categories!,
                    description: resto.description!,
                  ),
                  Divider(
                    color: ColorPalette.backgroundColor,
                    height: 8.0,
                  ),
                  _buildMenuListWidget(
                    label: 'Makanan',
                    icon: Icon(
                      Icons.lunch_dining_outlined,
                      color: Colors.grey[700],
                    ),
                    menus: resto.menus!.foods!,
                  ),
                  Divider(
                    color: ColorPalette.backgroundColor,
                    height: 8.0,
                  ),
                  _buildMenuListWidget(
                    label: 'Minuman',
                    icon: Icon(
                      Icons.local_cafe_outlined,
                      color: Colors.grey[700],
                    ),
                    menus: resto.menus!.drinks!,
                  ),
                  Divider(
                    color: ColorPalette.backgroundColor,
                    height: 8.0,
                  ),
                  _buildReviewWidget(
                    context: context,
                    rating: resto.rating!,
                    reviews: resto.customerReviews!,
                  ),
                ],
              ),
            ),
          );
        } else if (state.state == FetchResultState.NoData) {
          return AlertAnimationWidget(
            animation: 'assets/not-found.json',
            text: 'Restorant detail tidak tersedia',
            action: defaultTargetPlatform == TargetPlatform.android
                ? SizedBox(
                    width: 200.0,
                    child: ElevatedButton(
                      child: Text(
                        'Refresh',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 14.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {
                        state.fetchRestoDetail(id);
                      },
                    ),
                  )
                : CupertinoButton.filled(
                    child: Text('Refresh'),
                    onPressed: () {
                      state.fetchRestoDetail(id);
                    },
                  ),
          );
        } else if (state.state == FetchResultState.Failure) {
          return AlertAnimationWidget(
            animation: 'assets/no-internet.json',
            text: 'Ada kesalahan. Coba cek koneksimu dan ulangi',
            action: defaultTargetPlatform == TargetPlatform.android
                ? SizedBox(
                    width: 200.0,
                    child: ElevatedButton(
                      child: Text(
                        'Refresh',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 14.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      onPressed: () {
                        state.fetchRestoDetail(id);
                      },
                    ),
                  )
                : CupertinoButton.filled(
                    child: Text('Refresh'),
                    onPressed: () {
                      state.fetchRestoDetail(id);
                    },
                  ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: (context) => BuildWidget.android(
        context: context,
        appBarTitle: 'Detail',
        appBarElevation: 2.0,
        body: _buildContent(context),
      ),
      iosBuilder: (context) => BuildWidget.iOS(
        context: context,
        prevPageTitle: 'Home',
        navBarTitle: 'Detail',
        body: _buildContent(context),
      ),
    );
  }
}
