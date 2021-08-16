import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:resto/providers/content/resto_search_provider.dart';
import 'package:resto/screens/detail_screen.dart';
import 'package:resto/screens/widgets/alert/alert_animation_widget.dart';
import 'package:resto/screens/widgets/builder/build_widget.dart';
import 'package:resto/screens/widgets/builder/platform_widget.dart';
import 'package:resto/screens/widgets/list/item_list.dart';
import 'package:resto/screens/widgets/list/item_list_shimmer.dart';
import 'package:resto/shared/constants.dart';

class SearchScreen extends StatelessWidget {
  static const routeName = '/search';

  Widget _buildContent({required BuildContext context}) {
    final TextEditingController _searchController = TextEditingController();
    Provider.of<RestoSearchProvider>(
      context,
      listen: false,
    ).fetchRestoSearchResult();

    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Consumer<RestoSearchProvider>(
            builder: (context, state, _) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey[300]!,
                    ),
                  ),
                ),
                child: defaultTargetPlatform == TargetPlatform.android
                    ? TextField(
                        controller: _searchController,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          hintText: 'Kafe Cemara',
                          isCollapsed: true,
                          contentPadding: EdgeInsets.all(10.0),
                          filled: true,
                          fillColor: Colors.grey[200],
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey[300]!,
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          prefixIcon: Icon(Icons.search),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? GestureDetector(
                                  onTap: () {
                                    _searchController.clear();
                                    state.fetchRestoSearchResult(query: '');
                                  },
                                  child: Icon(
                                    Icons.close,
                                  ),
                                )
                              : null,
                        ),
                        onChanged: (query) {
                          state.fetchRestoSearchResult(query: query);
                        },
                      )
                    : CupertinoSearchTextField(
                        placeholder: 'Kafe Cemara',
                        controller: _searchController,
                        onChanged: (query) {
                          state.fetchRestoSearchResult(query: query);
                        },
                      ),
              );
            },
          ),
        ),
        Expanded(
          flex: 8,
          child: Consumer<RestoSearchProvider>(
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
              } else if (state.state == FetchResultState.Searching) {
                return AlertAnimationWidget(
                  animation: 'assets/search.json',
                  text: 'Cari restoran favoritmu',
                );
              } else if (state.state == FetchResultState.HasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.restos!.items!.length,
                  padding: EdgeInsets.all(16.0),
                  itemBuilder: (context, index) {
                    var resto = state.restos!.items![index];
                    return ItemList(
                      image: UrlList.imageUrl + resto.pictureId!,
                      title: resto.name!,
                      city: resto.city!,
                      rating: resto.rating!,
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          DetailScreen.routeName,
                          arguments: resto.id,
                        );
                      },
                    );
                  },
                );
              } else if (state.state == FetchResultState.NoData) {
                return AlertAnimationWidget(
                  animation: 'assets/not-found.json',
                  text: 'Oops! Sepertinya restoran tidak tersedia',
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
                              state.fetchRestoSearchResult();
                            },
                          ),
                        )
                      : CupertinoButton.filled(
                          child: Text('Refresh'),
                          onPressed: () {
                            state.fetchRestoSearchResult();
                          },
                        ),
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: (context) => BuildWidget.android(
        context: context,
        appBarTitle: 'Search',
        body: _buildContent(
          context: context,
        ),
      ),
      iosBuilder: (context) => BuildWidget.iOS(
        context: context,
        navBarTitle: 'Search',
        prevPageTitle: 'Home',
        body: _buildContent(
          context: context,
        ),
        hasBorder: false,
      ),
    );
  }
}
