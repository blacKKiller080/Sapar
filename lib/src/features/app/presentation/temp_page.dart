// ignore_for_file: unused_import

import 'dart:math';

import 'package:flutter/material.dart';

class TempPage extends StatefulWidget {
  final Color color;
  const TempPage({
    super.key,
    required this.color,
  });

  @override
  State<TempPage> createState() => _TempPageState();
}

class _TempPageState extends State<TempPage> {
  late List<int> numbers = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10000; i++) {
      final int intValue = Random().nextInt(300) + 50;
      numbers.add(intValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.color,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Colors.grey,
                child: const Text('Bloc 1'),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: numbers[index].toDouble(),
                      width: double.infinity,
                      color: Colors.orange,
                    ),
                  );
                },
                childCount: numbers.length,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Colors.grey,
                child: const Text('Bloc 2'),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: numbers[index].toDouble(),
                      width: double.infinity,
                      color: Colors.red,
                    ),
                  );
                },
                childCount: numbers.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
