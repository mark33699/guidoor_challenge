import 'package:flutter/material.dart';

const _pageControllerSpacing = 8.0;
const _pageSize = 20, _firstPage = 1, _pageNumbersCount = 4;

class PaginationToolbar extends StatefulWidget {
  const PaginationToolbar({Key? key, required this.totalCount}) : super(key: key);

  final int totalCount;

  @override
  State<PaginationToolbar> createState() => _PaginationToolbarState();
}

class _PaginationToolbarState extends State<PaginationToolbar> {

  int _start = 1, _end = 0, _totalCount = 0;
  int _currentPage = _firstPage, _lastPage = _firstPage;
  bool get _isCurrentFirstPage => _currentPage == _firstPage;
  bool get _isCurrentLastPage => _currentPage == _lastPage;

  @override
  Widget build(BuildContext context) {
    _totalCount = widget.totalCount;

    final currentMaxCount = _currentPage * _pageSize;
    _start = 1 + ((_currentPage - 1) * _pageSize);
    if (_totalCount <= _pageSize || _totalCount <= currentMaxCount) {
      _end = _totalCount;
    } else {
      _end = currentMaxCount;
    }
    _lastPage = _totalCount % _pageSize == 0
        ? _totalCount ~/ _pageSize
        : _totalCount ~/ _pageSize + 1;

    return SizedBox(
      height: 24,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildCount(),
          VerticalDivider(),
          _buildPageControllers()
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

  Widget _buildPageControllers() {
    return Wrap(
      spacing: _pageControllerSpacing,
      children: [
        PageButton(
            type: PageButtonType.first,
            onTap: _isCurrentFirstPage
                ? null
                : () => setState(() => _currentPage = _firstPage)
        ),
        PageButton(
            type: PageButtonType.previous,
            onTap: _isCurrentFirstPage
                ? null
                : () => setState(() => _currentPage -= 1)
        ),
        if(_totalCount != 0) _buildPageNumbers(),
        PageButton(
            type: PageButtonType.next,
            onTap: _isCurrentLastPage
                ? null
                : () => setState(() => _currentPage += 1)
        ),
        PageButton(
            type: PageButtonType.last,
            onTap: _isCurrentLastPage
                ? null
                : () => setState(() => _currentPage = _lastPage)
        ),
      ],
    );
  }

  Widget _buildPageNumbers() {

    List<Widget> pageNumbers = [];
    if (_lastPage <= _pageNumbersCount) {
      pageNumbers = List.generate(_lastPage, (index) => Text('${index+1}'));
    } else if (_currentPage + _pageNumbersCount > _lastPage) {
      pageNumbers = List.generate(_pageNumbersCount, (index) => Text('${_lastPage-index}')).reversed.toList();
    } else {
      pageNumbers = List.generate(_pageNumbersCount, (index) {
        if (index == _pageNumbersCount - 1) {
          return Text('$_lastPage');
        } else if (index == _pageNumbersCount - 2) {
          return Text('...');
        }
        return Text('${_currentPage+index}');
      });
    }

    return Wrap(
      spacing: _pageControllerSpacing,
      children: pageNumbers,
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

