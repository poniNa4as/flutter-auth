import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'di/injection.dart';
import 'core/routes/router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(); 
  await configureDependencies(); 

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, _) => MaterialApp.router(
        routerConfig: goRouter,
        debugShowCheckedModeBanner: false,
        title: 'Clean Auth',
      ),
    );
  }
}
