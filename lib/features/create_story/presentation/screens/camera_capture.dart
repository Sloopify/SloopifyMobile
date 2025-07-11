import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sloopify_mobile/core/managers/app_dimentions.dart';
import 'package:sloopify_mobile/core/managers/app_gaps.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';
import 'package:sloopify_mobile/core/managers/color_manager.dart';
import 'package:sloopify_mobile/core/managers/theme_manager.dart';
import 'package:sloopify_mobile/features/create_posts/domain/entities/media_entity.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/calculate_tempreture_cubit/calculate_temp_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/story_editor_cubit/story_editor_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/blocs/text_editing_cubit/text_editing_cubit.dart';
import 'package:sloopify_mobile/features/create_story/presentation/screens/media_editor_screen.dart';
import 'package:sloopify_mobile/features/create_story/presentation/screens/story_editor_screen.dart';

import '../blocs/drawing_story/drawing_story_cubit.dart';

class CameraCaptureScreen extends StatefulWidget {
  const CameraCaptureScreen({Key? key}) : super(key: key);

  @override
  State<CameraCaptureScreen> createState() => _CameraCaptureScreenState();
}

class _CameraCaptureScreenState extends State<CameraCaptureScreen> {
  CameraController? _controller;
  List<CameraDescription> _cameras = [];
  bool _isRecording = false;
  bool _isInitialized = false;
  bool isPhotoCamera = true;
  bool isFlashOn = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom],
    );
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras.isNotEmpty) {
      _controller = CameraController(_cameras[0], ResolutionPreset.high);
      await _controller!.initialize();
      setState(() {
        _isInitialized = true;
      });
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: ColorManager.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    super.dispose();
  }

  Future<void> _takePicture(BuildContext context) async {
    if (_controller != null && _controller!.value.isInitialized) {
      try {
        final XFile image = await _controller!.takePicture();
        File file = File(image.path);
        final MediaEntity mediaEntity = MediaEntity(
          id: '',
          file: file,
          order: 1,
          isVideoFile: false,
        );
        context.read<StoryEditorCubit>().addCameraPhotoOrVideoToMediaFiles(
          mediaEntity,
        );
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: context.read<StoryEditorCubit>(),
                  ),
                  BlocProvider(
                    create: (context) => TextEditingCubit(),
                  ),
                  BlocProvider(
                    create: (context) => DrawingStoryCubit(),
                  ),
                  BlocProvider(
                    create: (context) => CalculateTempCubit(),
                  ),
                ],
                child: StoryEditorScreen(media: mediaEntity),
              );
            },
          ),
        );
        // For now, we'll just navigate back
      } catch (e) {
        print("Error taking picture: $e");
      }
    }
  }

  Future<void> _toggleVideoRecording() async {
    if (_controller != null && _controller!.value.isInitialized) {
      if (_isRecording) {
        try {
          final XFile video = await _controller!.stopVideoRecording();
          setState(() {
            _isRecording = false;
          });
          File file = File(video.path);
          final MediaEntity mediaEntity = MediaEntity(
            id: '',
            file: file,
            order: 1,
            isVideoFile: true,
          );
          context.read<StoryEditorCubit>().addCameraPhotoOrVideoToMediaFiles(
            mediaEntity,
          );
        } catch (e) {
          print("Error stopping video recording: $e");
        }
      } else {
        try {
          await _controller!.startVideoRecording();
          setState(() {
            _isRecording = true;
          });
        } catch (e) {
          print("Error starting video recording: $e");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isInitialized
        ? Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child: CameraPreview(_controller!)),
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.arrow_back, color: ColorManager.white),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isFlashOn = !isFlashOn;
                      });
                      if (isFlashOn)
                        _controller?.setFlashMode(FlashMode.torch);
                      if (!isFlashOn)
                        _controller?.setFlashMode(FlashMode.off);
                    },
                    child: SvgPicture.asset(
                      isFlashOn
                          ? AssetsManager.flashOff
                          : AssetsManager.flashOn,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap:
              isPhotoCamera
                  ? () => _takePicture(context)
                  : _toggleVideoRecording,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  color:
                  !isPhotoCamera
                      ? _isRecording
                      ? Colors.red
                      : Colors.white
                      : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: 3),
                ),
                child:
                !isPhotoCamera
                    ? Icon(
                  _isRecording ? Icons.stop : Icons.videocam,
                  color: _isRecording ? Colors.white : Colors.black,
                  size: 30,
                )
                    : null,
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPhotoVideoSelect(isPhotoCamera, isPhoto: true),
                Gaps.hGap4,
                _buildPhotoVideoSelect(!isPhotoCamera, isPhoto: false),
              ],
            ),
          ),
          Positioned(
            bottom: 50,
            left: 20,
            child: InkWell(
              onTap: () {},
              child: SvgPicture.asset(AssetsManager.swipeCamera),
            ),
          ),
        ],
      ),
    )
        : const Center(child: CircularProgressIndicator());
  }

  Widget _buildPhotoVideoSelect(bool isSelected, {bool isPhoto = true}) {
    return InkWell(
      onTap: () {
        setState(() {
          isPhotoCamera = isPhoto;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.p16,
          vertical: AppPadding.p8,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? ColorManager.primaryShade4 : null,
        ),
        child: Text(
          isPhoto ? "Photo" : "Video",
          style: AppTheme.bodyText3.copyWith(
            color: isSelected ? ColorManager.primaryColor : ColorManager.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
