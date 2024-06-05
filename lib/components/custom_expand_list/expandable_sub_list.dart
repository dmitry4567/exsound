import 'package:expandable/expandable.dart';
import 'package:exstudio/components/custom_expand_list/expand_list_node.dart';
import 'package:exstudio/components/custom_expand_list/expandable_list_data.dart';
import 'package:exstudio/components/custom_expand_list/expandable_sub_list_node.dart';
import 'dart:math';
import 'package:flutter/material.dart';

class ExpandSubList extends StatefulWidget {
  const ExpandSubList(
      {Key? key,
      this.width,
      this.height,
      this.items,
      this.expandDuration,
      required this.title,
      this.titleFontSize,
      this.itemBorderColor,
      this.selectedItemColor,
      this.unselectedItemColor,
      this.expandArrowIcon,
      this.collapseArrowIcon,
      this.itemDescriptionTextColor,
      this.titleTextColor,
      this.isExpandedAtStart,
      this.arrowIconColor,
      required this.childInnerVerticalPadding,
      required this.childFontSize})
      : super(key: key);

  final double? width;
  final double? height;
  final String? items;
  final int? expandDuration;
  final String title;
  final double? titleFontSize;
  final Color? itemBorderColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final Widget? expandArrowIcon;
  final Widget? collapseArrowIcon;
  final Color? itemDescriptionTextColor;
  final Color? titleTextColor;
  final bool? isExpandedAtStart;
  final Color? arrowIconColor;
  final double childInnerVerticalPadding;
  final double childFontSize;

  @override
  _ExpandSubListState createState() => _ExpandSubListState();
}

String? selectedItem;

class _ExpandSubListState extends State<ExpandSubList>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    List<Target> items = targetsFromJson(widget.items ?? "");

    List<Widget> itemWidgets = [];

    for (var item in items) {
      itemWidgets.add(Builder(builder: (context) {
        return item.nodes == null
            ? ExpandListNode(
                target: item,
                titleFontSize: widget.childFontSize,
                fontSize: widget.childFontSize,
                innerVerticalPadding: widget.childInnerVerticalPadding,
                itemBorderColor: widget.itemBorderColor!,
                selectedItemColor: const Color(0xffC7E100),
                unselectedItemColor: widget.unselectedItemColor,
                titleTextColor: Colors.black,
                fontWeight: FontWeight.w400,
              )
            : ExpandSubListNode(
                title: item.title,
                items: item.nodes!,
                expandDuration: 500,
                titleFontSize: 18,
                childFontSize: widget.childFontSize,
                childInnerVerticalPadding: widget.childInnerVerticalPadding,
                itemBorderColor: widget.itemBorderColor,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.white,
                expandArrowIcon: const Icon(Icons.keyboard_arrow_down),
                collapseArrowIcon: const Icon(Icons.keyboard_arrow_down),
                itemDescriptionTextColor: const Color(0xFF3C84CC),
                titleTextColor: Colors.black,
                isExpandedAtStart: false,
                arrowIconColor: Colors.black,
              );
      }));
    }

    return ExpandableNotifier(
        initialExpanded: widget.isExpandedAtStart ?? false,
        child: ScrollOnExpand(
            child: Container(
                child: Column(
          children: <Widget>[
            ExpandablePanel(
              theme: ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapHeaderToExpand: false,
                  hasIcon: false,
                  animationDuration:
                      Duration(milliseconds: widget.expandDuration ?? 500)),
              header: Container(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.title,
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: widget.titleFontSize,
                            fontStyle: FontStyle.normal,
                            color: widget.titleTextColor),
                      ),
                    ),
                    ExpandableTheme(
                        data: ExpandableThemeData(
                          animationDuration: Duration(
                              milliseconds: widget.expandDuration ?? 500),
                          useInkWell: true,
                          inkWellBorderRadius: BorderRadius.circular(20),
                        ),
                        child: ExpandableButton(
                            child: ExpandableIcon(
                          theme: ExpandableThemeData(
                            iconColor: widget.arrowIconColor ?? Colors.black,
                            iconRotationAngle: pi,
                            expandIcon: (widget.expandArrowIcon as Icon).icon ??
                                Icons.keyboard_arrow_down,
                            collapseIcon:
                                (widget.collapseArrowIcon as Icon).icon ??
                                    Icons.keyboard_arrow_up,
                          ),
                        )))
                  ],
                ),
              ),
              collapsed: Container(),
              expanded: Column(
                children: itemWidgets,
              ),
            )
          ],
        ))));
  }
}
