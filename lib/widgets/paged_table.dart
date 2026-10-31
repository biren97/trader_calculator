import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Simple table with page controls. Cells are plain strings; the first column
/// is narrower than the rest.
class PagedTable extends StatefulWidget {
  const PagedTable({
    super.key,
    required this.headers,
    required this.rows,
    this.pageSize = 10,
  });

  final List<String> headers;
  final List<List<String>> rows;
  final int pageSize;

  @override
  State<PagedTable> createState() => _PagedTableState();
}

class _PagedTableState extends State<PagedTable> {
  int _page = 0;

  int get _pageCount =>
      widget.rows.isEmpty ? 1 : (widget.rows.length / widget.pageSize).ceil();

  @override
  void didUpdateWidget(PagedTable old) {
    super.didUpdateWidget(old);
    if (_page >= _pageCount) _page = _pageCount - 1;
  }

  int _flex(int col) => col == 0 ? 2 : 3;

  Widget _cell(String text, int col, {bool header = false}) {
    return Expanded(
      flex: _flex(col),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: col == 0 ? Alignment.centerLeft : Alignment.centerRight,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              fontWeight: header ? FontWeight.w700 : FontWeight.w500,
              color: header ? AppColors.white : AppColors.ink,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final start = _page * widget.pageSize;
    final end = (start + widget.pageSize).clamp(0, widget.rows.length);
    final visible = widget.rows.sublist(start, end);

    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Column(
            children: [
              Container(
                color: AppColors.blue,
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    for (var c = 0; c < widget.headers.length; c++)
                      _cell(widget.headers[c], c, header: true),
                  ],
                ),
              ),
              for (var r = 0; r < visible.length; r++)
                Container(
                  color: r.isEven ? AppColors.white : AppColors.blueSoft,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Row(
                    children: [
                      for (var c = 0; c < visible[r].length; c++)
                        _cell(visible[r][c], c),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton.filledTonal(
              tooltip: 'Previous page',
              onPressed: _page > 0 ? () => setState(() => _page--) : null,
              icon: const Icon(Icons.chevron_left_rounded),
            ),
            Column(
              children: [
                Text(
                  'Page ${_page + 1} of $_pageCount',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                Text(
                  '${start + 1}-$end of ${widget.rows.length}',
                  style: const TextStyle(color: AppColors.muted, fontSize: 12),
                ),
              ],
            ),
            IconButton.filledTonal(
              tooltip: 'Next page',
              onPressed:
                  _page < _pageCount - 1 ? () => setState(() => _page++) : null,
              icon: const Icon(Icons.chevron_right_rounded),
            ),
          ],
        ),
      ],
    );
  }
}
