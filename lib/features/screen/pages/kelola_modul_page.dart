import 'package:flutter/material.dart';

class KelolaModulPage extends StatelessWidget {
  final VoidCallback onOpenDetailModul;

  const KelolaModulPage({
    super.key,
    required this.onOpenDetailModul,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text("Pilih Modul"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: onOpenDetailModul,

              child: const Text("Detail Modul"),
            ),
          ],
        ),
      ),
    );
  }
}