import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const ZegarApp());
}

class ZegarApp extends StatelessWidget {
  const ZegarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mój Zegar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const ZegarEkran(),
    );
  }
}

class ZegarEkran extends StatefulWidget {
  const ZegarEkran({super.key});

  @override
  State<ZegarEkran> createState() => _ZegarEkranState();
}

class _ZegarEkranState extends State<ZegarEkran> {
  String godzina = '';
  String data = '';
  Timer? timer;

  @override
  void initState() {
    super.initState();
    _aktualizujCzas();
    timer = Timer.periodic(const Duration(seconds: 1), (_) => _aktualizujCzas());
  }

  void _aktualizujCzas() {
    final teraz = DateTime.now();
    setState(() {
      godzina = '${teraz.hour.toString().padLeft(2, '0')}:'
                '${teraz.minute.toString().padLeft(2, '0')}:'
                '${teraz.second.toString().padLeft(2, '0')}';

      data = '${teraz.day}.${teraz.month}.${teraz.year}';
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🕒 Mój Prosty Zegar'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Duża godzina
            Text(
              godzina,
              style: const TextStyle(
                fontSize: 90,
                fontWeight: FontWeight.w700,
                letterSpacing: 4,
              ),
            ),
            const SizedBox(height: 20),

            // Data
            Text(
              data,
              style: const TextStyle(fontSize: 28, color: Colors.grey),
            ),

            const SizedBox(height: 60),

            // Przycisk (możesz później dodać więcej funkcji)
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Zegar działa! 🎉')),
                );
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Odśwież teraz'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 20),
              ),
            ),

            const SizedBox(height: 30),
            const Text(
              'Kod napisany w 2 minuty na Windowsie 🚀\nDziała idealnie na iOS!',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}