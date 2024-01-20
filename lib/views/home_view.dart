import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screen_badminton_mobile/viewmodels/room_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late TextEditingController _nameController, _codeController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _codeController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(controller: _nameController),
          TextField(controller: _codeController),
          OutlinedButton(
            onPressed: () {
              final viewModel = context.read<RoomModel>();
              viewModel.connect();
              viewModel.input(_codeController.text);
              viewModel.join();
            },
            child: const Text('JOIN'),
          ),
        ],
      ),
    );
  }
}
