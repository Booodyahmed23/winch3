import 'package:carwinch/provider/provider.dart';
import 'package:carwinch/select/select_address_screen.dart';
import 'package:carwinch/test.dart';
import 'package:carwinch/trash/home_screen.dart';
import 'package:carwinch/winch_home/acc_screen/edit_profile.dart';
import 'package:carwinch/winch_home/home_layout.dart';
import 'package:carwinch/winch_home/servicepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';
import 'maps/MapsView.dart';
import 'users/carservices_screen.dart';
import 'auth/homescreen.dart';
import 'auth/login_screen.dart';
import 'auth/signup_screen.dart';
import 'users/user_screen.dart';
import 'users/winch_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Ensure Firebase is initialized before runApp
  runApp(MyApp());
  // const kGoogleApiKey = "AIzaSyDoBHEaV4zb2EsvqDqiIfaFq9h5nTw3Qk8";
  // GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() =>  new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override

  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => UiProvider()..init(),
      child: Consumer<UiProvider>(
        builder: (context, UiProvider notifier, child) {
          return MaterialApp(
            themeMode: notifier.isDark ? ThemeMode.dark : ThemeMode.light,
            darkTheme: notifier.darkTheme,
            theme: notifier.lightTheme,
            debugShowCheckedModeBanner: false,
            title: 'Car Winch App',
             initialRoute: '/m',
            routes: {
              '/servicepage': (context) => ServicePage(),
              '/selectadd': (context) => SelectAddressScreen(),
              '/MessengerScreen': (context) => MessengerScreen(),
              '/hm': (context) => Homescreen(),
               '/m': (context) => MapsView(onMapCreated: (GoogleMapController controller) {}),
              '/l': (context) => const LoginScreen(),
               '/th': (context) => HomeScreenTest(email: '',),
               '/homescreen': (context) => Homescreen(),
              '/signup': (context) => const SignUpScreen(),
              '/user': (context) => const UserScreen(),
              '/winch': (context) => const WinchScreen(),
              '/car_service': (context) => const CarServiceScreen(),
              '/HomeLayout': (context) => HomeLayout(),
              '/EditProfile': (context) => EditProfile(),
            },
          );
        },
      ),
    );
  }
}
