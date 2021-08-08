import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:resto/providers/resto_detail_provider.dart';
import 'package:resto/providers/resto_review_provider.dart';
import 'package:resto/screens/detail_screen.dart';
import 'package:resto/screens/widgets/alert/alert_animation_widget.dart';
import 'package:resto/screens/widgets/builder/build_widget.dart';
import 'package:resto/screens/widgets/builder/platform_widget.dart';
import 'package:resto/shared/constants.dart';

class ReviewScreen extends StatelessWidget {
  static const routeName = '/review';

  final String id;
  const ReviewScreen({required this.id});

  Widget _buildContent({required BuildContext context}) {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _reviewController = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    return Consumer<RestoReviewProvider>(
      builder: (context, state, _) {
        if (state.state == PostResultState.Idle) {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                defaultTargetPlatform == TargetPlatform.android
                    ? Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _nameController,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                hintText: 'Name',
                                isCollapsed: true,
                                contentPadding: EdgeInsets.all(16.0),
                                filled: true,
                                fillColor: Colors.white,
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
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Nama tidak boleh kosong';
                                }
                              },
                            ),
                            SizedBox(
                              height: 16.0,
                            ),
                            TextFormField(
                              controller: _reviewController,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              textAlign: TextAlign.justify,
                              decoration: InputDecoration(
                                hintText: 'Review',
                                isCollapsed: true,
                                contentPadding: EdgeInsets.all(16.0),
                                filled: true,
                                fillColor: Colors.white,
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
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Review tidak boleh kosong';
                                }
                              },
                            ),
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          CupertinoTextField(
                            controller: _nameController,
                            padding: EdgeInsets.all(14.0),
                            placeholder: 'Name',
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: Colors.grey[300]!,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16.0,
                          ),
                          CupertinoTextField(
                            controller: _reviewController,
                            padding: EdgeInsets.all(14.0),
                            placeholder: 'Review',
                            keyboardType: TextInputType.multiline,
                            maxLines: 5,
                            textAlign: TextAlign.justify,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: Colors.grey[300]!,
                              ),
                            ),
                          ),
                        ],
                      ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: defaultTargetPlatform == TargetPlatform.android
                        ? ElevatedButton(
                            child: Text(
                              'Kirim Review',
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
                              if (_formKey.currentState!.validate()) {
                                state.postReviewByRestoId(
                                  id: id,
                                  name: _nameController.text,
                                  review: _reviewController.text,
                                );
                              }
                            },
                          )
                        : CupertinoButton.filled(
                            child: Text('Kirim Review'),
                            onPressed: () {
                              if (_nameController.text.isEmpty) {
                                showCupertinoDialog(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoAlertDialog(
                                      title: Text('Peringatan'),
                                      content: Text('Nama tidak boleh kosong!'),
                                      actions: [
                                        CupertinoButton(
                                          child: Text('Oke'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    );
                                  },
                                );
                              } else if (_reviewController.text.isEmpty) {
                                showCupertinoDialog(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoAlertDialog(
                                      title: Text('Peringatan'),
                                      content:
                                          Text('Review tidak boleh kosong!'),
                                      actions: [
                                        CupertinoButton(
                                          child: Text('Oke'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    );
                                  },
                                );
                              } else {
                                state.postReviewByRestoId(
                                  id: id,
                                  name: _nameController.text,
                                  review: _reviewController.text,
                                );
                              }
                            },
                          ),
                  ),
                ),
              ],
            ),
          );
        } else if (state.state == PostResultState.Loading) {
          return Center(
            child: SpinKitFadingCircle(
              color: Colors.amber[700],
            ),
          );
        } else if (state.state == PostResultState.Success) {
          return AlertAnimationWidget(
            animation: 'assets/done.json',
            text: 'Terimakasih sudah review!',
            action: defaultTargetPlatform == TargetPlatform.android
                ? SizedBox(
                    width: 200.0,
                    child: ElevatedButton(
                      child: Text(
                        'Kembali',
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
                        Provider.of<RestoDetailProvider>(
                          context,
                          listen: false,
                        ).fetchRestoDetail(id);

                        state.setState(PostResultState.Idle);

                        Navigator.of(context).popUntil(
                          ModalRoute.withName(DetailScreen.routeName),
                        );
                      },
                    ),
                  )
                : CupertinoButton.filled(
                    child: Text('Kembali'),
                    onPressed: () {
                      Provider.of<RestoDetailProvider>(
                        context,
                        listen: false,
                      ).fetchRestoDetail(id);

                      state.setState(PostResultState.Idle);

                      Navigator.of(context).popUntil(
                        ModalRoute.withName(DetailScreen.routeName),
                      );
                    },
                  ),
          );
        } else if (state.state == PostResultState.Failure) {
          return AlertAnimationWidget(
            animation: 'assets/no-internet.json',
            text: 'Terjadi kesalahan. Coba cek koneksimu dan ulangi',
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
                        state.setState(PostResultState.Idle);
                      },
                    ),
                  )
                : CupertinoButton.filled(
                    child: Text('Refresh'),
                    onPressed: () {
                      state.setState(PostResultState.Idle);
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
        appBarTitle: 'Review',
        appBarElevation: 2.0,
        body: _buildContent(
          context: context,
        ),
      ),
      iosBuilder: (context) => BuildWidget.iOS(
        context: context,
        navBarTitle: 'Review',
        prevPageTitle: 'Detail',
        body: _buildContent(
          context: context,
        ),
        hasBorder: true,
      ),
    );
  }
}
