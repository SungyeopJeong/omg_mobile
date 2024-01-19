import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:screen_badminton_mobile/viewmodels/room_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RoomModel()),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) => context.watch<RoomModel>().joined
                ? const Text('hi')
                : Column(
                    children: [
                      TextField(controller: _controller),
                      OutlinedButton(
                        onPressed: () {
                          final viewModel = context.read<RoomModel>();
                          viewModel.connect();
                          viewModel.input(_controller.text);
                          viewModel.join();
                        },
                        child: const Text('JOIN'),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
