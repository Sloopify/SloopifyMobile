import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';

class CountryCodeWidget extends StatefulWidget {
  final Function(String dialCode) onChanged;

  const CountryCodeWidget({super.key,required this.onChanged});

  @override
  State<CountryCodeWidget> createState() => _CountryCodeWidgetState();
}

class _CountryCodeWidgetState extends State<CountryCodeWidget> {
   String dialCode="+963";



  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        color: ColorManager.white,
        border: Border.all(color: ColorManager.disActive.withOpacity(0.5)),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: ColorManager.black.withOpacity(0.2),
            blurRadius: 4,
            spreadRadius: 0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Row(
          children: [
            Text(dialCode,style: AppTheme.bodyText3.copyWith(fontWeight: FontWeight.w500),),
            Expanded(
              child: CountryCodePicker(
                margin: EdgeInsets.zero,
                hideMainText: true,
                backgroundColor: ColorManager.white,
                showDropDownButton: false,
                flagWidth: 18,
                dialogTextStyle: AppTheme.bodyText3,
                dialogBackgroundColor: ColorManager.white,
                padding: EdgeInsets.zero,
                dialogSize: Size(
                  double.infinity,
                  MediaQuery.of(context).size.height * 0.6,
                ),
                onChanged: (value) {
                  setState(() {
                    dialCode=value.dialCode??"+963";
                  });
                  widget.onChanged(dialCode);
                },
                // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                initialSelection: 'Sy',
                // optional. Shows only country name and flag
                showCountryOnly: false,
                showFlag: true,
                showFlagDialog: true,
                showFlagMain: true,
                searchStyle: AppTheme.bodyText3.copyWith(fontWeight: FontWeight.w500),
                headerTextStyle: AppTheme.headline3.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                // optional. Shows only country name and flag when popup is closed.
                showOnlyCountryWhenClosed: false,
                // optional. aligns the flag and the Text left
                alignLeft: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
