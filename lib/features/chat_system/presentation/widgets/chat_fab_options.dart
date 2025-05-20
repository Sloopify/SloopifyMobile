// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sloopify_mobile/core/managers/assets_managers.dart';

class ChatFabOptions extends StatefulWidget {
  const ChatFabOptions({Key? key}) : super(key: key);

  @override
  State<ChatFabOptions> createState() => _ChatFabOptionsState();
}

class _ChatFabOptionsState extends State<ChatFabOptions> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
  }

  void _toggleFab() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          right: 0,
          child: FloatingActionButton.small(
            onPressed: _toggleFab,
            child: SvgPicture.asset(AssetsManager.messageOption),
          ),
        ),
        if (_isExpanded) ...[
          Positioned(
            right: 0,
            bottom: 50,
            child: _buildExpandedFab(
              AssetsManager.record,
              1,
              hero: 'record',
              onTap: () {},
            ),
          ),
          Positioned(
            bottom: 100,
            right: 0,

            child: _buildExpandedFab(
              AssetsManager.camera,
              2,
              hero: 'camera',
              onTap: () {},
            ),
          ),

          Positioned(
            bottom: 150,
            right: 0,
            child: _buildExpandedFab(
              AssetsManager.attached,
              3,
              hero: 'attached',
              onTap: () {},
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildExpandedFab(
    String assets,
    int index, {
    required Function() onTap,
    required String hero,
  }) {
    return FloatingActionButton.small(
      heroTag: hero,
      onPressed: onTap,
      child: SvgPicture.asset(assets),
    );
  }
}
