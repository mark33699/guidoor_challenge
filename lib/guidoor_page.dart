import 'package:flutter/material.dart';
import 'pagination_toolbar.dart';
import 'theme.dart';

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
      backgroundColor: GuidoorColors.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PaginationToolbar(totalCount: _recordTotalCount),
              SizedBox(height: 40),
              SizedBox(
                width: 40,
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  onSubmitted: (recordTotalCount) {
                    setState(() {
                      _recordTotalCount = int.tryParse(recordTotalCount) ?? 0;
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}