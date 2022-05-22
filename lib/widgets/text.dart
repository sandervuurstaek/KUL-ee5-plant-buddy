import 'package:flutter/material.dart';

const double header1Size = 36;
const double header2Size = 24;
const double header3Size = 18;
const double header4Size = 10;
const double header5Size = 15;
const double header6Size = 13;
/// Custom Text widget
///
/// Mostly used for titles
class Header1Text extends Text {
  Header1Text(
    data, {
    Key? key,
    TextStyle? textStyle,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
  }) : super(
          data,
          key: key,
          style: textStyle == null
              ? const TextStyle(fontSize: header1Size)
              : textStyle.copyWith(fontSize: header1Size),
        );
}

/// Custom Text widget
///
/// Mostly used for subtitles
class Header2Text extends Text {
  Header2Text(
    data, {
    Key? key,
    TextStyle? textStyle,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
  }) : super(
          data,
          key: key,
          style: textStyle == null
              ? const TextStyle(fontSize: header2Size)
              : textStyle.copyWith(fontSize: header2Size),
        );
}

/// Custom Text widget
///
/// Mostly used for general text
class Header3Text extends Text {
  Header3Text(
    data, {
    Key? key,
    TextStyle? textStyle,
    StrutStyle? strutStyle,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    int? maxLines,
    String? semanticsLabel,
    TextWidthBasis? textWidthBasis,
    TextHeightBehavior? textHeightBehavior,
  }) : super(
          data,
          key: key,
          style: textStyle == null
              ? const TextStyle(fontSize: header3Size)
              : textStyle.copyWith(fontSize: header3Size),
        );
}

class Header4Text extends Text {
  Header4Text(
      data, {
        Key? key,
        TextStyle? textStyle,
        StrutStyle? strutStyle,
        TextAlign? textAlign,
        TextDirection? textDirection,
        Locale? locale,
        bool? softWrap,
        TextOverflow? overflow,
        double? textScaleFactor,
        int? maxLines,
        String? semanticsLabel,
        TextWidthBasis? textWidthBasis,
        TextHeightBehavior? textHeightBehavior,
      }) : super(
    data,
    key: key,
    style: textStyle == null
        ? const TextStyle(fontSize: header4Size)
        : textStyle.copyWith(fontSize: header4Size),
  );
}

class Header5Text extends Text {
  Header5Text(
      data, {
        Key? key,
        TextStyle? textStyle,
        StrutStyle? strutStyle,
        TextAlign? textAlign,
        TextDirection? textDirection,
        Locale? locale,
        bool? softWrap,
        TextOverflow? overflow,
        double? textScaleFactor,
        int? maxLines,
        String? semanticsLabel,
        TextWidthBasis? textWidthBasis,
        TextHeightBehavior? textHeightBehavior,
      }) : super(
    data,
    key: key,
    style: textStyle == null
        ? const TextStyle(fontSize: header5Size)
        : textStyle.copyWith(fontSize: header5Size),
  );
}

class Header6Text extends Text {
  Header6Text(
      data, {
        Key? key,
        TextStyle? textStyle,
        StrutStyle? strutStyle,
        TextAlign? textAlign,
        TextDirection? textDirection,
        Locale? locale,
        bool? softWrap,
        TextOverflow? overflow,
        double? textScaleFactor,
        int? maxLines,
        String? semanticsLabel,
        TextWidthBasis? textWidthBasis,
        TextHeightBehavior? textHeightBehavior,
      }) : super(
    data,
    key: key,
    style: textStyle == null
        ? const TextStyle(fontSize: header6Size)
        : textStyle.copyWith(fontSize: header6Size),
  );
}