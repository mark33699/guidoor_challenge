import 'package:flutter/material.dart';

const pageSize = 20;
const firstPage = 1;

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
  int _currentPage = firstPage;
  int _lastPage = firstPage;

  @override
  Widget build(BuildContext context) {
    _totalCount = widget.totalCount;

    final currentMaxCount = _currentPage * pageSize;
    _start = 1 + ((_currentPage - 1) * pageSize);
    if (_totalCount <= pageSize || _totalCount <= currentMaxCount) {
      _end = _totalCount;
    } else {
      _end = currentMaxCount;
    }
    _lastPage = _totalCount % pageSize == 0
        ? _totalCount ~/ pageSize
        : _totalCount ~/ pageSize + 1;

    return SizedBox(
      height: 24,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildCount(),
          VerticalDivider(),
          Expanded(child: _buildPageController())
        ],
      ),
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

  Widget _buildPageController() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PageButton(
            type: PageButtonType.previous,
            onTap: () => setState(() => _currentPage -= 1)
        ),
        Text('$_currentPage'),
        Text('$_lastPage'),
        PageButton(
            type: PageButtonType.next,
            onTap: () => setState(() => _currentPage += 1)
        ),
      ],
    );
  }

}

enum PageButtonType {first, previous, next, last}

class PageButton extends StatelessWidget {
  const PageButton({Key? key, required this.type, required this.onTap}) : super(key: key);

  final PageButtonType type;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Text('P'),
      onTap: onTap,
    );
  }
}

