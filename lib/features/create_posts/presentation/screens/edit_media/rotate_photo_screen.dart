import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../blocs/rotate_photo_cubit/rotate_photo_cubit.dart';
import '../../blocs/rotate_photo_cubit/rotate_photo_state.dart';

class RotateImageScreen extends StatefulWidget {
  final List<AssetEntity> images;
  final int initialIndex;

  const RotateImageScreen({
    required this.images,
    required this.initialIndex,
    super.key,
  });

  @override
  State<RotateImageScreen> createState() => _RotateImageScreenState();
}

class _RotateImageScreenState extends State<RotateImageScreen> {
  late final PageController _controller;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _controller = PageController(initialPage: currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RotateEditCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit photos / videos'),
          leading: const BackButton(),
        ),
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: widget.images.length,
                onPageChanged: (index) => setState(() => currentIndex = index),
                itemBuilder: (context, index) {
                  final entity = widget.images[index];
                  return BlocBuilder<
                    RotateEditCubit,
                    Map<int, RotateEditState>
                  >(
                    builder: (context, state) {
                      final edit = state[index] ?? const RotateEditState();
                      return FutureBuilder<Uint8List?>(
                        future: entity.thumbnailDataWithSize(
                          const ThumbnailSize(500, 500),
                        ),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          Widget image = Image.memory(
                            snapshot.data!,
                            fit: BoxFit.contain,
                          );

                          // Apply rotation and flips
                          image = Transform(
                            alignment: Alignment.center,
                            transform:
                                Matrix4.identity()
                                  ..rotateZ(
                                    (edit.rotationAngle * math.pi) / 180,
                                  )
                                  ..scale(
                                    edit.isFlippedHorizontal ? -1.0 : 1.0,
                                    edit.isFlippedVertical ? -1.0 : 1.0,
                                  ),
                            child: image,
                          );

                          return Center(child: image);
                        },
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            _buildControls(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildControls() {
    return BlocBuilder<RotateEditCubit, Map<int, RotateEditState>>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _rotateButton(
                  icon: Icons.flip,
                  label: 'Flip Horizontal',
                  onPressed:
                      () => context.read<RotateEditCubit>().flipHorizontal(
                        currentIndex,
                      ),
                ),
                const SizedBox(width: 10),
                _rotateButton(
                  icon: Icons.flip,
                  label: 'Flip Vertical',
                  onPressed:
                      () => context.read<RotateEditCubit>().flipVertical(
                        currentIndex,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _rotateButton(
                  icon: Icons.rotate_left,
                  label: '90°',
                  onPressed:
                      () => context.read<RotateEditCubit>().rotateLeft(
                        currentIndex,
                      ),
                ),
                const SizedBox(width: 10),
                _rotateButton(
                  icon: Icons.rotate_right,
                  label: '90°',
                  onPressed:
                      () => context.read<RotateEditCubit>().rotateRight(
                        currentIndex,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                DoneCancelButton(text: 'Done'),
                DoneCancelButton(text: 'Cancel'),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _rotateButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 20),
      label: Text(label),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        textStyle: const TextStyle(fontSize: 14),
      ),
    );
  }
}

class DoneCancelButton extends StatelessWidget {
  final String text;

  const DoneCancelButton({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.pop(context), // or handle save
      child: Text(text),
    );
  }
}
