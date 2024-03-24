import 'package:flutter/material.dart';
import 'theme.dart';

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
    if (_totalCount != widget.totalCount) { //rebuild from outside
      _currentPage = _firstPage;
      _lastPage = _firstPage;
    }
    _totalCount = widget.totalCount;

    final currentMaxCount = _currentPage * _pageSize;
    _start = 1 + ((_currentPage - 1) * _pageSize);
    if (_totalCount <= _pageSize || _totalCount <= currentMaxCount) {
      _end = _totalCount;
    } else {
      _end = currentMaxCount;
    }
    if (_totalCount != 0) {
      _lastPage = _totalCount % _pageSize == 0
          ? _totalCount ~/ _pageSize
          : _totalCount ~/ _pageSize + 1;
    }

    return Container(
      padding: const EdgeInsets.only(right: _pageControllerSpacing * 2),
      decoration: const BoxDecoration(
        color: GuidoorColors.toolbar,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      height: 72,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildCount(),
          const SizedBox(
              height: 24,
              child: VerticalDivider()
          ),
          _buildPageControllers()
        ],
      ),
    );
  }

  Widget _buildCount() {
    return Row(
      children: [
        Text('$_start - $_end',
          style: const TextStyle(
              color: GuidoorColors.text,
              fontWeight: FontWeight.bold
          ),
        ),
        Text(' of $_totalCount',
            style: const TextStyle(color: GuidoorColors.text)
        ),
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
      pageNumbers = List.generate(_lastPage, (index) => _buildPageNumber(index+1));
    } else if (_currentPage + _pageNumbersCount > _lastPage) {
      pageNumbers = List.generate(_pageNumbersCount, (index)
      => _buildPageNumber(_lastPage-index)
      ).reversed.toList();
    } else {
      pageNumbers = List.generate(_pageNumbersCount, (index) {
        if (index == _pageNumbersCount - 1) {
          return _buildPageNumber(_lastPage);
        } else if (index == _pageNumbersCount - 2) {
          return const Text('...');
        }
        return _buildPageNumber(_currentPage+index);
      });
    }

    return Wrap(
      spacing: _pageControllerSpacing,
      children: pageNumbers,
    );
  }

  Widget _buildPageNumber(int number) {
    return GestureDetector(
      child: Text('$number',
        style: TextStyle(
          decoration: number == _currentPage ? TextDecoration.underline : null,
        ),
      ),
      onTap: () => setState(() => _currentPage = number),
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
    final imageName = 'image/btn_${type.name}_${ onTap == null ? 'disable' : 'enable' }.png';
    return SizedBox(
      height: 24, width: 24,
      child: GestureDetector(
        child: Image.asset(imageName),
        onTap: onTap,
      ),
    );
  }
}
