import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:resto/providers/resto_list_provider.dart';
import 'package:resto/screens/detail_screen.dart';
import 'package:resto/screens/widgets/alert/alert_animation_widget.dart';
import 'package:resto/screens/widgets/builder/build_widget.dart';
import 'package:resto/screens/widgets/list/item_list.dart';
import 'package:resto/screens/widgets/list/item_list_shimmer.dart';
import 'package:resto/screens/widgets/builder/platform_widget.dart';
import 'package:resto/shared/constants.dart';

class ListScreen extends StatelessWidget {
  static const routeName = '/list';

  Widget _buildList(BuildContext context) {
    Provider.of<RestoListProvider>(
      context,
      listen: false,
    ).fetchRestoList();

    return Consumer<RestoListProvider>(
      builder: (context, state, _) {
        if (state.state == FetchResultState.Loading) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            padding: EdgeInsets.all(16.0),
            itemBuilder: (context, index) {
              return ItemListShimmer();
            },
          );
        } else if (state.state == FetchResultState.HasData) {
          return SafeArea(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.restos!.items!.length,
              padding: EdgeInsets.all(16.0),
              itemBuilder: (context, index) {
                final resto = state.restos!.items![index];
                return TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: Duration(milliseconds: 500),
                  builder: (BuildContext context, double val, Widget? child) {
                    return Opacity(
                      opacity: val,
                      child: child,
                    );
                  },
                  child: ItemList(
                    image: UrlList.imageUrl + resto.pictureId!,
                    title: resto.name!,
                    city: resto.city!,
                    rating: resto.rating!,
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pushNamed(
                        DetailScreen.routeName,
                        arguments: resto.id,
                      );
                    },
                  ),
                );
              },
            ),
          );
        } else if (state.state == FetchResultState.NoData) {
          return AlertAnimationWidget(
            animation: 'assets/not-found.json',
            text: 'Tidak ada restorant yang tersedia',
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
                        state.fetchRestoList();
                      },
                    ),
                  )
                : CupertinoButton.filled(
                    child: Text('Refresh'),
                    onPressed: () {
                      state.fetchRestoList();
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
                        state.fetchRestoList();
                      },
                    ),
                  )
                : CupertinoButton.filled(
                    child: Text('Refresh'),
                    onPressed: () {
                      state.fetchRestoList();
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
        appBarTitle: 'Resto',
        appBarElevation: 2.0,
        body: _buildList(context),
      ),
      iosBuilder: (context) => BuildWidget.iOS(
        context: context,
        navBarTitle: 'Resto',
        hasBorder: true,
        body: _buildList(context),
      ),
    );
  }
}
