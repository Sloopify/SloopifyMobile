import 'package:flutter/material.dart';
import 'package:giphy_get/giphy_get.dart';
import 'package:sloopify_mobile/core/utils/helper/api_keys.dart';

import '../../../../core/managers/theme_manager.dart';

class GifElement extends StatefulWidget {
  const GifElement({super.key});

  @override
  State<GifElement> createState() => _GifElementState();
}

class _GifElementState extends State<GifElement> {
  GiphyGif? currentGif;

  // Random ID
  String randomId = "";

  late String giphyApiKey = ApiKeys.giphyAndroidApiKey;
  late GiphyClient client = GiphyClient(apiKey: giphyApiKey, randomId: '');

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      client.getRandomId().then((value) {
        setState(() {
          randomId = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GiphyGetWrapper(
      giphy_api_key: giphyApiKey,
      builder: (stream, giphyGetWrapper) {
        stream.listen((gif) {
          setState(() {
            currentGif = gif;
          });
        });
        return currentGif != null
            ? SizedBox(
              child: GiphyGifWidget(
                imageAlignment: Alignment.center,
                gif: currentGif!,
                giphyGetWrapper: giphyGetWrapper,
                borderRadius: BorderRadius.circular(30),
                showGiphyLabel: true,
              ),
            )
            : Text(
              "No Selected GIF",
              style: AppTheme.headline4.copyWith(fontWeight: FontWeight.w500),
            );
      },
    );
  }
}
