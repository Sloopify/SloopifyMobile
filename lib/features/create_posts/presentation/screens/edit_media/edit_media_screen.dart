import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/ui/widgets/custom_elevated_button.dart';
import 'package:sloopify_mobile/features/create_posts/presentation/screens/edit_media/rotate_photo_screen.dart';

import '../../../../../core/managers/app_gaps.dart';
import '../../../../../core/ui/widgets/custom_app_bar.dart';

class EditMediaScreen extends StatefulWidget {
  final List<AssetEntity> mediaAssets;
  final int initialIndex;

  const EditMediaScreen({
    required this.mediaAssets,
    this.initialIndex = 0,
    super.key,
  });

  @override
  State<EditMediaScreen> createState() => _EditMediaScreenState();
}

class _EditMediaScreenState extends State<EditMediaScreen> {
  late PageController _pageController;
  int _currentIndex = 0;
  String? _activeTool;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  void _onToolSelected(String tool) {
    setState(() {
      _activeTool = _activeTool == tool ? null : tool;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentAsset = widget.mediaAssets[_currentIndex];

    return Scaffold(
      appBar: getCustomAppBar(context: context, title: "Edit Photos/Videos"),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PageView.builder(
                    controller: _pageController,
                    itemCount: widget.mediaAssets.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                        _activeTool = null;
                      });
                    },
                    itemBuilder: (_, index) {
                      return FutureBuilder<Uint8List?>(
                        future: widget.mediaAssets[index].thumbnailDataWithSize(
                          ThumbnailSize(600, 600),
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Image.memory(
                              snapshot.data!,
                              fit: BoxFit.contain,
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      );
                    },
                  ),

                  // Left arrow
                  if (_currentIndex > 0)
                    Positioned(
                      left: 10,
                      child: InkWell(
                        onTap:
                            () => _pageController.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            ),
                        child: SvgPicture.asset(AssetsManager.arrowBackFilled),
                      ),
                    ),

                  // Right arrow
                  if (_currentIndex < widget.mediaAssets.length - 1)
                    Positioned(
                      right: 10,
                      child: InkWell(
                        onTap:
                            () => _pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            ),
                        child: SvgPicture.asset(
                          AssetsManager.arrowForwardFilled,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            Gaps.vGap2,
            // 🔧 Tools row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _toolButton(AssetsManager.crop, 'Crop', 'crop', () {}),
                      Gaps.hGap3,
                      _toolButton(AssetsManager.rotate, 'Rotate', 'rotate', () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return RotateImageScreen(
                                images: widget.mediaAssets,
                                initialIndex: _currentIndex,
                              );
                            },
                          ),
                        );
                      }),
                    ],
                  ),
                  Gaps.vGap2,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _toolButton(
                        AssetsManager.effects,
                        'Effects',
                        'effects',
                        () {},
                      ),
                      Gaps.hGap3,

                      _toolButton(
                        AssetsManager.deleteImage,
                        'Delete',
                        'delete',
                        () {},
                        isDestructive: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Gaps.vGap2,

            // Footer buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      label: "Done",
                      onPressed: () {},
                      backgroundColor: ColorManager.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: AppPadding.p8),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: CustomElevatedButton(
                      label: "Cancel",
                      onPressed: () => Navigator.of(context).pop(),
                      backgroundColor: ColorManager.white,
                      borderSide: BorderSide(color: ColorManager.gray600),
                      foregroundColor: ColorManager.gray600,
                      padding: EdgeInsets.symmetric(vertical: AppPadding.p8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _toolButton(
    String assetsName,
    String label,
    String toolKey,
    Function() callBack, {
    bool isDestructive = false,
  }) {
    final isActive = _activeTool == toolKey;

    return CustomElevatedButton(
      svgAlignment: IconAlignment.start,
      width: MediaQuery.of(context).size.width * 0.4,
      padding: EdgeInsets.symmetric(vertical: AppPadding.p8),
      label: label,
      onPressed: callBack,
      svgPic: SvgPicture.asset(assetsName),
      backgroundColor: ColorManager.white,
      borderSide: BorderSide(
        color: isDestructive ? ColorManager.red : ColorManager.gray600,
      ),
      foregroundColor: isDestructive ? ColorManager.red : ColorManager.gray600,
    );
  }

  Widget _buildToolOptions(String tool) {
    switch (tool) {
      case 'crop':
        return _cropOptions();
      case 'rotate':
        return _rotateOptions();
      case 'effects':
        return _effectsOptions();
      case 'delete':
        return _deleteConfirm();
      default:
        return SizedBox.shrink();
    }
  }

  Widget _cropOptions() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Wrap(
        spacing: 10,
        children: [
          _optionChip('Square'),
          _optionChip('16:9'),
          _optionChip('Freeform'),
        ],
      ),
    );
  }

  Widget _rotateOptions() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Wrap(
        spacing: 10,
        children: [
          _optionChip('Left'),
          _optionChip('Right'),
          _optionChip('180°'),
        ],
      ),
    );
  }

  Widget _effectsOptions() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Wrap(
        spacing: 10,
        children: [
          _optionChip('Vintage'),
          _optionChip('Mono'),
          _optionChip('Vibrant'),
        ],
      ),
    );
  }

  Widget _deleteConfirm() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Are you sure you want to delete this media?'),
          SizedBox(width: 10),
          TextButton(
            onPressed: () {
              // Handle deletion
              Navigator.pop(context);
            },
            child: Text('Yes', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  Widget _optionChip(String label) {
    return Chip(label: Text(label), backgroundColor: Colors.grey.shade200);
  }
}
