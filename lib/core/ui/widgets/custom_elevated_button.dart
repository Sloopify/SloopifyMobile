// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../managers/app_dimentions.dart';
import '../../managers/app_gaps.dart';
import '../../managers/color_manager.dart';
import '../../managers/theme_manager.dart';

class CustomElevatedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Icon? icon;
  final bool? isRounded;
  final EdgeInsetsGeometry? padding;
  final bool isLoading;
  final bool isEnabled;
  final IconAlignment? iconAlignment;
  final SvgPicture? svgPic;
  final bool isBold;
  final TextStyle? btnTextStyle;
  final IconAlignment? svgAlignment;
  final BorderSide? borderSide;
  final Color? loadingColor;
  final double? width;

  const CustomElevatedButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.icon,
    this.isRounded,
    this.padding,
    this.svgAlignment = IconAlignment.end,
    this.isLoading = false,
    this.iconAlignment = IconAlignment.start,
    this.isEnabled = true,
    this.svgPic,
    this.borderSide,
    this.width,
    this.isBold = false,
    this.loadingColor,
    this.btnTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return svgPic != null
        ? _buildElevatedWithSvg(isRounded, context)
        : icon != null
        ? _buildElevatedWithIcon(isRounded, context)
        : _buildElevatedWithoutIcon(isRounded, context);
  }

  Widget _buildElevatedWithIcon(bool? isRounded, BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.transparent,
      shadowColor: ColorManager.black.withOpacity(0.25),
      borderOnForeground: true,
      child: SizedBox(
        width: width ?? MediaQuery.of(context).size.width * 0.9,
        child: ElevatedButton.icon(
          icon: icon!,
          iconAlignment: iconAlignment ?? IconAlignment.start,
          onPressed: onPressed,
          label:
              isLoading
                  ? CircularProgressIndicator(
                    color: loadingColor ?? ColorManager.white,
                  )
                  : FittedBox(
                    child: Text(
                      label,
                      textAlign: TextAlign.center,
                      style:
                          btnTextStyle ??
                          AppTheme.bodyText1.copyWith(
                            fontSize: 18,
                            fontWeight:
                                isBold ? FontWeight.w500 : FontWeight.w400,
                            color: foregroundColor ?? Colors.white,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
          style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
            padding: WidgetStatePropertyAll(padding),
            backgroundColor: WidgetStatePropertyAll(backgroundColor),
            foregroundColor: WidgetStatePropertyAll(foregroundColor),
          ),
        ),
      ),
    );
  }

  Widget _buildElevatedWithoutIcon(bool? isRounded, BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width * 0.9,


      decoration: BoxDecoration(
        border: Border.all(color: borderSide?.color??ColorManager.primaryColor,width: borderSide?.width??1),
        borderRadius: BorderRadius.circular(10),
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withOpacity(0.2),
            spreadRadius: 0,
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
          padding: WidgetStatePropertyAll(padding),
          backgroundColor: WidgetStatePropertyAll(backgroundColor),
          foregroundColor: WidgetStatePropertyAll(foregroundColor),

        ),
        child:
            isLoading
                ? CircularProgressIndicator(color: ColorManager.white)
                : FittedBox(
                  child: Text(
                    textAlign: TextAlign.center,
                    label,
                    maxLines: 2,
                    style:
                        btnTextStyle ??
                        AppTheme.bodyText1.copyWith(
                          fontSize: 16,
                          fontWeight:
                              isBold ? FontWeight.w500 : FontWeight.w400,
                          color: foregroundColor ?? Colors.white,
                        ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
      ),
    );
  }

  _buildElevatedWithSvg(bool? isRounded, BuildContext context) {
    return Card(
      elevation: 5,
      color: Colors.transparent,
      shadowColor: ColorManager.black.withOpacity(0.25),
      borderOnForeground: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: ColorManager.primaryColor, width: 1.5),
      ),
      child: SizedBox(
        width: width ?? MediaQuery.of(context).size.width * 0.9,
        child: ElevatedButton(
          onPressed: onPressed,
          style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
            padding: WidgetStatePropertyAll(padding),
            backgroundColor: WidgetStatePropertyAll(backgroundColor),
            foregroundColor: WidgetStatePropertyAll(foregroundColor),
          ),
          child:
              isLoading
                  ? CircularProgressIndicator(color: ColorManager.white)
                  : FittedBox(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (svgAlignment == IconAlignment.end) ...[
                          if(label.isNotEmpty)
                      ...[    Text(
                        label,
                        textAlign: TextAlign.center,
                        style:
                        btnTextStyle ??
                            AppTheme.bodyText1.copyWith(
                              fontSize: 18,
                              fontWeight:
                              isBold
                                  ? FontWeight.w500
                                  : FontWeight.w400,
                              color: foregroundColor ?? Colors.white,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                        Gaps.hGap2,],
                          svgPic!,
                        ] else ...[
                          svgPic!,
                          if(label.isNotEmpty)...[
                            Gaps.hGap2,
                            Text(
                              label,
                              textAlign: TextAlign.center,
                              style:
                              btnTextStyle ??
                                  AppTheme.bodyText1.copyWith(
                                    fontSize: 18,
                                    fontWeight:
                                    isBold
                                        ? FontWeight.w500
                                        : FontWeight.w400,
                                    color: foregroundColor ?? Colors.white,
                                  ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],

                        ],
                      ],
                    ),
                  ),
        ),
      ),
    );
  }
}

getCancelButton(BuildContext context) {
  return CustomElevatedButton(
    label: 'close'.tr(),
    onPressed: () {
      Navigator.pop(context);
    },
    backgroundColor: ColorManager.lightGray,
    foregroundColor: Colors.black,
  );
}
