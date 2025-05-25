import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sloopify_mobile/features/create_posts/data/models/album_model.dart';
import 'package:yaml/yaml.dart';

import '../local_storage/preferene_utils.dart';
import '../locator/service_locator.dart' as sl;

class AppConfiguration{
  static Future<void> initializeCore() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    final dir =await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    await Hive.initFlutter();
    Hive.registerAdapter(AlbumModelAdapter());
    await Hive.openBox<AlbumModel>('albums');
    await sl.setupLocator();
    HttpOverrides.global = MyHttpOverrides();
  // await getAppVersion();


  }
  static Future<String> getAppVersion() async {
    final yamlString = await rootBundle.loadString('pubspec.yaml');
    final parsedYaml = loadYaml(yamlString);
    final String versionNumber = await getAppVersion();
    String buildNumber = versionNumber.split("+")[1];
    PreferenceUtils.setString('buildNumberKey', buildNumber);
    PreferenceUtils.setString('versionNumberKey', versionNumber.split("+")[0]);
    return parsedYaml['version'];
    // print(parsedYaml['version']); // print 1.0.0+1
  }
}


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}