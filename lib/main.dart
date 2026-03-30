import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zenith_architecture/data/models/user_model.dart';
import 'package:zenith_architecture/injection_container.dart' as di;
import 'package:zenith_architecture/presentation/pages/user_profile_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserModelAdapter());
  await di.init();
  runApp(const ZenithApp());
}

class ZenithApp extends StatelessWidget {
  const ZenithApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zenith Flutter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(body: Center(child: UserProfilePage())),
    );
  }
}
