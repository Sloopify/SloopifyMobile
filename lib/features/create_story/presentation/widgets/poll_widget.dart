import 'package:dashed_rect/dashed_rect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_text_field.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/all_positioned_element.dart';
import 'package:sloopify_mobile/features/create_story/domain/entities/poll_entity_option.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/story_editor_cubit/story_editor_cubit.dart';

import '../../../../core/managers/app_dimentions.dart';
import '../../../../core/managers/app_gaps.dart' show Gaps;

class PollCreationWidget extends StatefulWidget {
  const PollCreationWidget({super.key});

  @override
  State<PollCreationWidget> createState() => _PollCreationWidgetState();
}

class _PollCreationWidgetState extends State<PollCreationWidget> {
  final TextEditingController _questionController = TextEditingController(
    text: "Poll Text",
  );
  final List<PollOption> _options = [
    PollOption(optionId: 1, optionName: 'option 1'),
    PollOption(optionId: 2, optionName: 'option 2'),
  ];
  late Poll poll;

  int _nextOptionId = 3;
  bool isPollDone=false;

  @override
  void initState() {
    poll = Poll(question: _questionController.text, options: _options);
    context.read<StoryEditorCubit>().updatePollElement(poll);
    super.initState();
  }

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onDoubleTap: (){
        setState(() {
          isPollDone=!isPollDone;
        });
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorManager.white,
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                gradient: LinearGradient(
                  colors: [ColorManager.primaryColor, ColorManager.lightPurple],
                ),
              ),
              child: Center(
                child: TextFormField(
                  textAlign: TextAlign.center,
                  controller: _questionController,
                  style: AppTheme.headline3.copyWith(color: ColorManager.white),
                  onChanged: (value) {
                    _questionController.text = value;
                    final question = _questionController.text.trim();
                    final validOptions =
                        _options
                            .where(
                              (option) => option.optionName.trim().isNotEmpty,
                            )
                            .toList();
                     poll = Poll(question: question, options: validOptions);
                    print('pppppppppp${poll.options.map((e) => e.optionName)}');
                    context.read<StoryEditorCubit>().updatePollElement(poll);
                  },
                  decoration: InputDecoration(
                    hintStyle: AppTheme.headline3.copyWith(
                      color: ColorManager.white,
                    ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.p10,
                vertical: AppPadding.p8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < _options.length; i++)
                    Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: TextFormField(
                        initialValue: _options[i].optionName,
                        style: AppTheme.headline4.copyWith(
                          color: ColorManager.black,
                        ),
                        onChanged: (value) {
                          _options[i].optionName = value;
                          final question = _questionController.text.trim();
                          final validOptions =
                              _options
                                  .where(
                                    (option) =>
                                        option.optionName.trim().isNotEmpty,
                                  )
                                  .toList();
                           poll = Poll(
                            question: question,
                            options: validOptions,
                          );
                          print(
                            'pppppppppp${poll.options.map((e) => e.optionName)}',
                          );
                          context.read<StoryEditorCubit>().updatePollElement(
                            poll,
                          );
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: ColorManager.lightGrayTextField,
                          suffixIcon:
                              i > 1
                                  ? InkWell(
                                    onTap: () {
                                      setState(() {
                                        _options.removeAt(i);
                                      });
                                    },
                                    child: Icon(Icons.cancel_outlined),
                                  )
                                  : null,
                          hintStyle: AppTheme.headline3.copyWith(
                            color: ColorManager.black,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: ColorManager.lightGrayTextField,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: ColorManager.lightGrayTextField,
                            ),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: ColorManager.lightGrayTextField,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: ColorManager.lightGrayTextField,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: ColorManager.lightGrayTextField,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: ColorManager.lightGrayTextField,
                            ),
                          ),
                        ),
                      ),
                    ),
                  if(!isPollDone)
                  DashedRect(
                    color: ColorManager.lightBlueGray,
                    strokeWidth: 2,
                    gap: 4,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppPadding.p16,
                        vertical: AppPadding.p8,
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _options.add(
                              PollOption(
                                optionId: _nextOptionId,
                                optionName: 'option ${_nextOptionId}',
                              ),
                            );
                            _nextOptionId++;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Add Option',
                              style: AppTheme.headline4.copyWith(
                                color: ColorManager.lightBlueGray,
                              ),
                            ),
                            Gaps.hGap1,
                            Icon(Icons.add_circle_outline,color: ColorManager.lightBlueGray,)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _createPoll() {
    final question = _questionController.text.trim();
    final validOptions =
        _options
            .where((option) => option.optionName.trim().isNotEmpty)
            .toList();

    if (question.isEmpty || validOptions.length < 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a question and at least 2 options'),
        ),
      );
      return;
    }

    final poll = Poll(question: question, options: validOptions);

    // Convert to JSON and send to backend
    final pollJson = poll.toJson();
    print(pollJson); // This will match your required structure
  }
}
