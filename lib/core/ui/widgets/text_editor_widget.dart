import 'package:delta_to_html/delta_to_html.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_delta_from_html/parser/html_to_delta.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/text_entity.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/blocs/create_post_cubit/create_post_cubit.dart';

import '../../managers/app_dimentions.dart';
import '../../managers/assets_managers.dart';
import '../../managers/color_manager.dart';

class GradientBackground {
  final Color startColor;
  final Color endColor;

  GradientBackground(this.startColor, this.endColor);
}

class TextEditorWidget extends StatefulWidget {
  TextEditorWidget({
    super.key,
    required this.hint,
    required this.initialValue,
    required this.onChanged,
    required this.onChangedText,
  });

  final String hint;
  final String initialValue;
  final Function onChanged;
  final Function onChangedText;

  @override
  State<TextEditorWidget> createState() => _TextEditorWidgetState();
}

class _TextEditorWidgetState extends State<TextEditorWidget> {
  late final QuillController _controller;
  GradientBackground? _selectedGradient;
  late FocusNode _focusNode;

  bool _showGradientPicker = false;
  final List<GradientBackground> gradients = [
    GradientBackground(Colors.pink, Colors.purple),
    GradientBackground(Colors.blue, Colors.blue),
    GradientBackground(Colors.green, Colors.green),
    GradientBackground(Colors.pink, Colors.pink),
    GradientBackground(Colors.green, Colors.green),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _focusNode=FocusNode();
    if (widget.initialValue.isEmpty) {
      _controller = QuillController.basic();
    } else {
      var delta = HtmlToDelta().convert(widget.initialValue);
      _controller = QuillController(
        document: Document.fromJson(delta.toJson()),
        selection: TextSelection.collapsed(offset: delta.length),
      );
    }
    _controller.document.changes.listen((event) {
      if(!_focusNode.hasFocus){
        _focusNode.requestFocus();
      }
      final delta = _controller.document.toDelta();

      final plainText = _controller.document.toPlainText().trim();

      widget.onChangedText(plainText);

      bool hasBold = false;
      bool hasItalic = false;
      bool hasUnderline = false;
      String? color;

      for (final op in delta.toList()) {
        final attrs = op.attributes;
        if (attrs != null) {
          print(attrs.keys);
          if (attrs.containsKey('bold')) hasBold = true;
          if (attrs.containsKey('italic')) hasItalic = true;
          if (attrs.containsKey('underline')) hasUnderline = true;
          if (attrs.containsKey('color')) color = attrs['color'];
        }
      }

      widget.onChanged(
        TextPropertyEntity(
          isUnderLine: hasUnderline,
          isItalic: hasItalic,
          isBold: hasBold,
          color:'#${color?.substring(3)}',
        ),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QuillToolbar.simple(
          configurations: QuillSimpleToolbarConfigurations(
            customButtons: [
              QuillToolbarCustomButtonOptions(
                childBuilder: (_, _) {
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(
                                () =>
                            _showGradientPicker = !_showGradientPicker,
                          );
                          context
                              .read<CreatePostCubit>()
                              .setVerticalHorizontalOption(false);
                        },
                        child: _selectedGradient != null ? Container(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            gradient:
                            _selectedGradient != null
                                ? LinearGradient(
                              colors: [
                                _selectedGradient!.startColor,
                                _selectedGradient!.endColor,
                              ],
                            )
                                : null,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ) :

                        SvgPicture.asset(
                          _showGradientPicker
                              ? AssetsManager.addBgColor
                              : AssetsManager.changeBgColor,
                        ),
                      ),
                      if (_showGradientPicker)
                        Row(
                          children: [
                            const SizedBox(width: 8),
                            ...gradients.map(
                                  (gradient) =>
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _selectedGradient = gradient;
                                        _showGradientPicker = false;
                                        context
                                            .read<CreatePostCubit>()
                                            .setBackGroundGradiant(gradient);
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                        horizontal: 2,
                                      ),
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            gradient.startColor,
                                            gradient.endColor,
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Colors.black26),
                                      ),
                                    ),
                                  ),
                            ),
                          ],
                        ),
                    ],
                  );
                },
              ),
            ],
            buttonOptions: QuillSimpleToolbarButtonOptions(
              base: QuillToolbarColorButtonOptions(
                iconTheme: QuillIconTheme(
                  iconButtonUnselectedData: IconButtonData(
                    padding: EdgeInsets.zero,
                    highlightColor: Colors.transparent,
                    color: ColorManager.primaryColor,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    disabledColor: Colors.transparent,
                    style: ButtonStyle(
                      alignment: Alignment.center,
                      iconAlignment: IconAlignment.start,
                      padding: WidgetStatePropertyAll(EdgeInsets.all(4)),
                      maximumSize: WidgetStatePropertyAll(Size(30, 30)),
                      minimumSize: WidgetStatePropertyAll(Size(10, 10)),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                        ColorManager.primaryShade1.withOpacity(0.3),
                      ),
                    ),
                  ),
                  iconButtonSelectedData: IconButtonData(
                    padding: EdgeInsets.zero,
                    highlightColor: Colors.transparent,
                    color: ColorManager.white,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    disabledColor: Colors.transparent,
                    style: ButtonStyle(
                      alignment: Alignment.center,
                      iconAlignment: IconAlignment.start,
                      padding: WidgetStatePropertyAll(EdgeInsets.all(4)),
                      maximumSize: WidgetStatePropertyAll(Size(30, 30)),
                      minimumSize: WidgetStatePropertyAll(Size(10, 10)),
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                        ColorManager.primaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            controller: _controller,
            multiRowsDisplay: true,
            showBackgroundColorButton: false,
            showClearFormat: false,
            toolbarSectionSpacing: 0,
            showClipboardCopy: false,
            showClipboardCut: false,
            showClipboardPaste: false,
            showCodeBlock: false,
            showLink: false,
            showIndent: false,
            showInlineCode: false,
            showFontFamily: false,
            showFontSize: false,
            showRedo: false,
            showHeaderStyle: false,
            showDividers: false,
            showQuote: false,
            showUndo: false,
            showSuperscript: false,
            showSubscript: false,
            showSearchButton: false,
            showStrikeThrough: false,
            showListNumbers: false,
            showDirection: false,
            showListCheck: false,
            showListBullets: false,
            showColorButton: true,
            showAlignmentButtons: false,
            showJustifyAlignment: false,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              border: Border.all(
                color: ColorManager.disActive.withOpacity(0.2),
                width: 1.5,
              ),
            ),
            toolbarSize: 50,
            toolbarIconAlignment: WrapAlignment.spaceEvenly,
            toolbarIconCrossAlignment: WrapCrossAlignment.center,
            sharedConfigurations: const QuillSharedConfigurations(
              locale: Locale('en'),
            ),
          ),
        ),
        Container(
          height: context
              .read<CreatePostCubit>()
              .state.selectedMedia.isEmpty ? 300.h:150.h,
          padding: EdgeInsetsDirectional.all(AppPadding.p4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient:
            _selectedGradient != null
                ? LinearGradient(
              colors: [
                _selectedGradient!.startColor,
                _selectedGradient!.endColor,
              ],
            )
                : null,
            border: Border.all(
              color: ColorManager.disActive.withOpacity(0.2),
              width: AppSize.s2,
            ),
          ),
          child: QuillEditor.basic(
            focusNode: _focusNode,
            configurations: QuillEditorConfigurations(
              controller: _controller,
              customStyles: DefaultStyles(
                placeHolder: DefaultTextBlockStyle(
                  AppTheme.bodyText3.copyWith(color: ColorManager.disActive),
                  VerticalSpacing(AppPadding.p8, AppPadding.p8),
                  VerticalSpacing(AppPadding.p8, AppPadding.p8),
                  BoxDecoration(),
                ),
              ),
              padding: EdgeInsetsDirectional.all(AppPadding.p4),
              placeholder: widget.hint,
              textInputAction: TextInputAction.done,
              enableSelectionToolbar: false,
              sharedConfigurations: const QuillSharedConfigurations(
                dialogTheme: QuillDialogTheme(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  dialogBackgroundColor: ColorManager.white,
                ),
                locale: Locale('en'),
              ),
            ),
          ),
        ),

      ],
    );
  }
}
