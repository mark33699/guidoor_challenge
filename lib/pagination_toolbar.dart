import 'package:flutter/material.dart';

const pageSize = 20;

class PaginationToolbar extends StatefulWidget {
  const PaginationToolbar({Key? key, required this.totalCount}) : super(key: key);

  final int totalCount;

  @override
  State<PaginationToolbar> createState() => _PaginationToolbarState();
}

class _PaginationToolbarState extends State<PaginationToolbar> {

  int _start = 1;
  int _end = 0;
  int _total = 0;

  @override
  Widget build(BuildContext context) {
    _total = widget.totalCount;
    return Row(
      children: [
        _buildCount()
      ],
    );
  }

  Widget _buildCount() {
    return Row(
      children: [
        Text('$_start - $_end',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(' of $_total'),
      ],
    );
  }

}
