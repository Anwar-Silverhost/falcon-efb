import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../../../utils/app_color.dart';
import '../../../utils/app_font.dart';
import '../../../utils/app_sp.dart';

class ViewPdf extends StatefulWidget {
  final String pdfPath;
  final String pdfName;

  const ViewPdf({Key? key, required this.pdfPath, required this.pdfName})
      : super(key: key);

  @override
  State<ViewPdf> createState() => _ViewPdfState();
}

class _ViewPdfState extends State<ViewPdf> {
  late PDFViewController _pdfViewController;
  int _currentPage = 0;
  int _totalPages = 0;
  bool _isReady = false;
  double _zoomLevel = 1.0;
  int _rotationAngle = 0;

  bool isStarred = false;

  List<dynamic> items = [];
  @override
  void initState() {
    super.initState();
    getUserToken();
  }

  Future<void> getUserToken() async {
    AppSp appSp = AppSp();
    List<dynamic> fetchedItems = await appSp.getFavourites();
    List<Map<String, dynamic>> fetchedItemsList =
        List<Map<String, dynamic>>.from(fetchedItems);

    bool isStarredx =
        fetchedItemsList.any((item) => item['url'] == widget.pdfPath);
    setState(() {
      items = fetchedItemsList;
      isStarred = isStarredx;
    });
  }



  @override
  void dispose() {

    super.dispose();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FB),
      extendBody: true,
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            width: double.infinity,
            height: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          widget.pdfName,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: AppFont.OutfitFont,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white), // Default text style
                            children: [
                              WidgetSpan(
                                child: Container(
                                  color: Colors.black38, // Background color
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 4), // Optional padding
                                  child: Text(
                                    '${_currentPage + 1} ',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: ' / $_totalPages',
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.zoom_in, color: Colors.white),
                              onPressed: () {
                                setState(() {
                                  _zoomLevel = (_zoomLevel + 0.1)
                                      .clamp(1.0, 3.0); // Limit zoom level
                                });
                              },
                            ),
                            Container(
                              width: 60,
                              color: Colors.black38, // Background color
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: Center(
                                child: Text(
                                  '${(_zoomLevel * 100).toInt()}%',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.zoom_out, color: Colors.white),
                              onPressed: () {
                                setState(() {
                                  _zoomLevel = (_zoomLevel - 0.1)
                                      .clamp(1.0, 3.0); // Limit zoom level
                                });
                              },
                            ),
                            IconButton(
                              icon:
                                  Icon(Icons.rotate_right, color: Colors.white),
                              onPressed: () {
                                setState(() {
                                  _rotationAngle = (_rotationAngle + 90) % 360;
                                });
                              },
                            ),
                          ],
                        ),

                        AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return ScaleTransition(
                                child: child, scale: animation);
                          },
                          child: IconButton(
                            key: ValueKey<bool>(
                                isStarred), // Ensure unique key for state transition
                            iconSize: 30,
                            icon: Icon(
                              Icons.star,
                              color: isStarred ? Colors.yellow : Colors.grey,
                            ),
                            onPressed: () async {
                              setState(() {
                                isStarred = !isStarred; // Toggle star state
                              });

                              List<dynamic> existingItems =
                                  await AppSp().getFavourites();
                              List<Map<String, dynamic>> items =
                                  List<Map<String, dynamic>>.from(
                                      existingItems);

                              if (isStarred) {
                                if (!items.any(
                                    (item) => item['url'] == widget.pdfPath)) {
                                  items.add({
                                    "title": widget.pdfName,
                                    "type": "file",
                                    "url": widget.pdfPath,
                                  });
                                }
                                EasyLoading.showSuccess('Added to Favorites');
                              } else {
                                items.removeWhere(
                                    (item) => item['url'] == widget.pdfPath);
                                EasyLoading.showSuccess(
                                    'Removed from Favorites');
                              }

                              await AppSp().setFavourites(jsonEncode(items));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: Center(
                    child: Transform.rotate(
                      angle: _rotationAngle * 3.141592653589793238 / 180, // Convert to radians
                      child: PDFView(
                        key: ValueKey(widget.pdfPath),
                        filePath: widget.pdfPath,
                        enableSwipe: true,
                        swipeHorizontal: false,
                        autoSpacing: true,
                        pageFling: true,
                        onRender: (pages) {
                          setState(() {
                            _totalPages = pages!;
                            _isReady = true;
                          });
                        },
                        onViewCreated: (PDFViewController controller) {
                          _pdfViewController = controller;
                        },
                        onPageChanged: (currentPage, totalPages) {
                          setState(() {
                            _currentPage = currentPage!;
                          });
                        },
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
          Positioned(
            bottom: 23,
            right: 23,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                backgroundColor: Colors.black54,
              ),
              child: Container(
                width: 20,
                height: 20,
                alignment: Alignment.center,
                child: Icon(
                  Icons.zoom_in_map,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

