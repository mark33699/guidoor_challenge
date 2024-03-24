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
  int _totalCount = 0;
  int _currentPage = 4;

  @override
  Widget build(BuildContext context) {
    _totalCount = widget.totalCount;
    final currentMaxCount = _currentPage * pageSize;
    _start = _start + ((_currentPage - 1) * pageSize);
    if (_totalCount <= pageSize || _totalCount <= currentMaxCount) {
      _end = _totalCount;
    } else {
      _end = currentMaxCount;
    }

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
        Text(' of $_totalCount'),
      ],
    );
  }

}
