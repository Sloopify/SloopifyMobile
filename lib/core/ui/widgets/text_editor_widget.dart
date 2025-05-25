import 'package:delta_to_html/delta_to_html.dart';
import 'package:flutter/material.dart';

import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_delta_from_html/parser/html_to_delta.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';

import '../../managers/app_dimentions.dart';
import '../../managers/color_manager.dart';

class TextEditorWidget extends StatefulWidget {
  const TextEditorWidget({
    super.key,
    required this.hint,
    required this.initialValue,
    required this.onChanged,
  });

  final String hint;
  final String initialValue;
  final Function onChanged;

  @override
  State<TextEditorWidget> createState() => _TextEditorWidgetState();
}

class _TextEditorWidgetState extends State<TextEditorWidget> {
  late final QuillController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
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
      var text = _controller.document.toDelta().toJson();

      widget.onChanged(DeltaToHTML.encodeJson(text));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 300.h,
          padding: EdgeInsetsDirectional.all(AppPadding.p4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: ColorManager.disActive.withOpacity(0.2),
              width: AppSize.s2,
            ),
          ),
          child: QuillEditor.basic(
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
        QuillToolbar.simple(
          configurations: QuillSimpleToolbarConfigurations(
            buttonOptions: QuillSimpleToolbarButtonOptions(
              base: QuillToolbarColorButtonOptions(
                iconTheme: QuillIconTheme(
                  iconButtonUnselectedData: IconButtonData(
                    highlightColor: Colors.transparent,
                    color: ColorManager.primaryColor,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    disabledColor: Colors.transparent,
                    style: ButtonStyle(
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
                    highlightColor: Colors.transparent,
                    color: ColorManager.white,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    disabledColor: Colors.transparent,
                    style: ButtonStyle(
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
      ],
    );
  }
}
