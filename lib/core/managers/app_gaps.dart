import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Widgets to add spaces in the match, easy to reach and use, the main benefit
/// rather than easy to use is that all same (GAPS) will refer to the same -
/// object in memory, that will make a better performance
class Gaps {
  const Gaps._();

  static Widget hGap0 = SizedBox(width: 2.w);
  static Widget hGap1 = SizedBox(width: 4.w);
  static Widget hGap2 = SizedBox(width: 8.w);
  static Widget hGap3 = SizedBox(width: 12.w);
  static Widget hGap4 = SizedBox(width: 16.w);
  static Widget hGap5 = SizedBox(width: 20.w);
  static Widget hGap6 = SizedBox(width: 24.w);
  static Widget hGap7 = SizedBox(width: 28.w);
  static Widget hGap8 = SizedBox(width: 32.w);
  static Widget hGap9 = SizedBox(width: 36.w);
  static Widget hGap10 = SizedBox(width: 40.w);
  static Widget hGap12 = SizedBox(width: 48.w);
  static Widget hGap15 = SizedBox(width: 60.w);
  static Widget hGap16 = SizedBox(width: 64.w);
  static Widget hGap26 = SizedBox(width: 104.w);
  static Widget hGap28 = SizedBox(width: 112.w);
  static Widget hGap32 = SizedBox(width: 128.w);
  static Widget hGap64 = SizedBox(width: 256.w);

  static Widget vGap00 = SizedBox(height: 4.h);
  static Widget vGap1 = SizedBox(height: 8.h);
  static Widget vGap0 = SizedBox(height: 6.5.h);
  static Widget vGap2 = SizedBox(height: 16.h);
  static Widget vGap3 = SizedBox(height: 24.h);
  static Widget vGap4 = SizedBox(height: 32.h);
  static Widget vGap5 = SizedBox(height: 40.h);
  static Widget vGap6 = SizedBox(height: 48.h);
  static Widget vGap7 = SizedBox(height: 56.h);
  static Widget vGap8 = SizedBox(height: 64.h);
  static Widget vGap9 = SizedBox(height: 72.h);
  static Widget vGap10 = SizedBox(height: 80.h);
  static Widget vGap12 = SizedBox(height: 96.h);
  static Widget vGap15 = SizedBox(height: 120.h);
  static Widget vGap16 = SizedBox(height: 128.h);
  static Widget vGap24 = SizedBox(height: 192.h);
  static Widget vGap32 = SizedBox(height: 256.h);
  static Widget vGap40 = SizedBox(height: 320.h);
  static Widget vGap50 = SizedBox(height: 400.h);
  static Widget vGap60 = SizedBox(height: 480.h);
  static Widget vGap64 = SizedBox(height: 512.h);
  static Widget vGap96 = SizedBox(height: 768.h);
  static Widget vGap128 = SizedBox(height: 1024.h);
  static Widget vGap256 = SizedBox(height: 2048.h);

  static const Widget line = Divider();

  static const Widget vLine = SizedBox(
    width: 0.6,
    height: 24.0,
    child: VerticalDivider(),
  );

  static const Widget empty = SizedBox.shrink();
}
