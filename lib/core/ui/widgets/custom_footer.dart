import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../managers/color_manager.dart';

var customFooter = CustomFooter(
  builder: (BuildContext? context, LoadStatus? mode) {
    Widget body;
    if (mode == LoadStatus.idle) {
      body = Text("pull_up_load".tr());
    } else if (mode == LoadStatus.loading) {
      body = const CircularProgressIndicator(color: ColorManager.primaryColor,);
    } else if (mode == LoadStatus.failed) {
      body = Text("Load_Failed!".tr());
    } else if (mode == LoadStatus.canLoading) {
      body = Text("release_to_load_more".tr());
    } else if (mode == LoadStatus.noMore){
      body = Text('');
    }
    else{
      body = Text('');
    }
    return SizedBox(
      height: 55.0,
      child: Center(child: body),
    );
  },
);
