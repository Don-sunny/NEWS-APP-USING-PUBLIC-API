import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum NewsType {
  topTrending,
  allNews,
}

enum SortByEnum {
  relevency, // articles more closely related to q come first.
  popularity, // articles from popular sources and publishers come first.
  publishedAt, // newest articles come first.
}

TextStyle smallTextStyle = GoogleFonts.montserrat(fontSize: 15);
