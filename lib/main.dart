import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:screen_badminton_mobile/viewmodels/game_model.dart';
import 'package:screen_badminton_mobile/views/home_view.dart';
import 'package:screen_badminton_mobile/views/join_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GameModel()),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => context.watch<GameModel>().joined
                ? const JoinView()
                : const HomeView(),
          ),
        ),
      ),
    );
  }
}
