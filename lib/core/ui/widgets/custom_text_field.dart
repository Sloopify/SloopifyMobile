import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../managers/app_dimentions.dart';
import '../../managers/color_manager.dart';
import '../../managers/theme_manager.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final IconData? icon;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final Function()? onPressPrefixIcon;
  final Function()? onPressSuffixIcon;
  final Color? suffixIconColor;
  final Color? enableBorderColor;
  final double? suffixIconSize;
  final double? borderRadius;
  final String? imageData;
  final FormFieldValidator<String>? validator;
  final bool? obscureText;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;
  final bool? autofocus;
  final bool? required;
  final bool? enabled;
  final bool? readOnly;
  final bool? withTitle;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final FocusNode? focusNode;
  final GestureTapCallback? onTap;
  final InputDecoration? inputDecoration;
  final List<TextInputFormatter>? inputFormatters;
  final Function()? onEditingComplete;
  final Color? fillColor;
  final String? initialValue;

  const CustomTextField({
    Key? key,
    this.labelText = "",
    required this.hintText,
    this.icon,
    this.prefixIcon,
    this.onPressPrefixIcon,
    this.fillColor = ColorManager.white,
    this.readOnly = false,
    this.onEditingComplete,
    this.imageData,
    this.borderRadius = 10,
    this.suffixIcon,
    this.suffixIconColor = ColorManager.primaryColor,
    this.enableBorderColor = ColorManager.primaryColor,
    this.suffixIconSize = 15,
    this.onPressSuffixIcon,
    this.initialValue = '',
    this.validator,
    this.focusNode,
    this.onChanged,
    this.obscureText = false,
    this.textInputAction,
    this.keyboardType,
    this.autofocus = false,
    this.controller,
    this.withTitle = false,
    this.required = false,
    this.enabled = true,
    this.maxLength,
    this.maxLines = 1,
    this.minLines,
    this.onTap,
    this.inputDecoration,
    this.inputFormatters,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isSeen = false;
  late InputDecoration _inputDecoration;
  String textValue = '';

  @override
  void initState() {
    super.initState();
    if (widget.inputDecoration == null) {
      _inputDecoration = InputDecoration();
    } else {
      _inputDecoration = widget.inputDecoration!;
    }
    widget.controller?.selection = TextSelection.fromPosition(
      TextPosition(offset: widget.controller!.text.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.withTitle!
            ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    widget.labelText,
                    style: AppTheme.headline4.copyWith(
                      fontWeight: FontWeight.w500,
                      color:
                          textValue.isEmpty
                              ? ColorManager.disActive.withOpacity(0.5)
                              : ColorManager.black,
                    ),
                  ),
                ),
                if (widget.obscureText!)
                  InkWell(
                    onTap: (){
                      setState(() {
                        isSeen = !isSeen;
                      });
                    },
                    child: Text(
                      'show',
                      style: AppTheme.bodyText3.copyWith(
                        color: ColorManager.disActive,
                      ),
                    ),
                  ),
              ],
            )
            : Container(),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: ColorManager.black.withOpacity(0.1),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            style: AppTheme.bodyText1,
            cursorColor: ColorManager.primaryColor,
            onTap: () {
              // if (widget.controller!.selection ==
              //     TextSelection.fromPosition(
              //       TextPosition(offset: widget.controller!.text.length - 1),
              //     )) {
              //   setState(() {
              //     widget.controller!.selection = TextSelection.fromPosition(
              //       TextPosition(offset: widget.controller!.text.length),
              //     );
              //   });
              // }
              if (widget.onTap != null) widget.onTap!();
            },
            focusNode: widget.focusNode,
            readOnly: widget.readOnly!,
            enabled: widget.enabled!,
            initialValue: widget.initialValue,
            inputFormatters: widget.inputFormatters ?? [],
            expands: widget.maxLength == 0 ? true : false,
            controller: widget.controller,
            decoration: _inputDecoration.copyWith(
              labelStyle: AppTheme.bodyText2.copyWith(
                color: ColorManager.black,
              ),
              disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: ColorManager.disActive),
              ),
              errorMaxLines: 2,
              fillColor: widget.fillColor,
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: ColorManager.black),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius!),
                borderSide: BorderSide(
                  color: widget.enableBorderColor ?? ColorManager.primaryColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius!),
                borderSide: BorderSide(
                  color: ColorManager.disActive.withOpacity(0.5),
                ),
              ),
              hintText: widget.hintText,
              hintStyle: AppTheme.headline4.copyWith(
                fontWeight: FontWeight.w500,
                color: ColorManager.disActive.withOpacity(0.5),
              ),
              suffixIcon:
                  widget.suffixIcon != null
                      ? IconButton(
                        onPressed: widget.onPressSuffixIcon,
                        icon: Icon(
                          widget.suffixIcon,
                          size: widget.suffixIconSize,
                          color: widget.suffixIconColor,
                        ),
                      )
                      : null,
            ),
            validator: widget.validator,
            obscureText: !isSeen ? widget.obscureText! : false,
            onChanged: (value) {
              textValue = value;
              setState(() {});
              if (widget.onChanged != null) {
                widget.onChanged!(value);
              }
            },
            onEditingComplete: widget.onEditingComplete,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            autofocus: widget.autofocus!,
            maxLength: widget.maxLength,
            minLines: widget.minLines,
            maxLines: widget.maxLines,
          ),
        ),
      ],
    );
  }
}
