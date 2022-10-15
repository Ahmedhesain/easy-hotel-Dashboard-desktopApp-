import 'dart:math';

import 'package:flutter/material.dart';

class TableWidget extends StatefulWidget {
  const TableWidget({
    Key? key,
    required this.header,
    required this.rows,
    required this.minimumCellWidth,
    required this.headerHeight,
    required this.rowHeight,
    this.rowColor,
  }) : super(key: key);

  final List<Widget> header;
  final List<List<Widget>> rows;
  final double minimumCellWidth;
  final double rowHeight;
  final double headerHeight;
  final Color Function(int)? rowColor;

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final height = widget.rowHeight * widget.rows.length;
    return LayoutBuilder(builder: (context, constraint) {
      final maxWidth = constraint.maxWidth;
      int columnsNum = widget.header.length;
      final cellWidth = max(maxWidth / columnsNum, widget.minimumCellWidth);
      return SizedBox(
        width: maxWidth,
        child: Scrollbar(
          // thumbVisibility: true,
          controller: controller,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            controller: controller,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: widget.headerHeight,
                    child: Row(
                      children: widget.header.map((e) => SizedBox(width: cellWidth, child: e)).toList(),
                    ),
                  ),
                  SizedBox(width: cellWidth * columnsNum, child: const Divider(thickness: 1.5, height: 1)),
                  Expanded(
                    child: SizedBox(
                      width: cellWidth * columnsNum,
                      child: ListView.builder(
                        itemCount: widget.rows.length,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => MouseRegion(
                          // cursor: SystemMouseCursors.click,
                          child: SizedBox(
                            height: widget.rowHeight,
                            child: ColoredBox(
                              color: widget.rowColor != null?widget.rowColor!(index):index % 2 == 1 ? Colors.black.withOpacity(.07) : Colors.transparent,
                              child: Row(
                                children: widget.rows[index].map((e) => SizedBox(width: cellWidth, child: e)).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
