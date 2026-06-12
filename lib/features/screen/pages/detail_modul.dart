import 'package:flutter/material.dart';

class DetailModulPage extends StatelessWidget {

  const DetailModulPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: const Text("Detail Modul")),

      body: Center(
        child: Text("Detail Modul"),
      ),
    );
  }
}
