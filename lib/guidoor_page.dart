import 'package:flutter/material.dart';

class GuidoorPage extends StatefulWidget {
  const GuidoorPage({Key? key}) : super(key: key);

  @override
  State<GuidoorPage> createState() => _GuidoorPageState();
}

class _GuidoorPageState extends State<GuidoorPage> {

  var _recordTotalCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('technical challenge')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('$_recordTotalCount'),
              const SizedBox(height: 40),
              TextField(
                keyboardType: TextInputType.number,
                onSubmitted: (recordTotalCount) {
                  setState(() {
                    _recordTotalCount = int.tryParse(recordTotalCount) ?? 0;
                  });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}