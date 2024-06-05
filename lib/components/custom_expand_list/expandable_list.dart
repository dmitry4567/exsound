import 'package:expandable/expandable.dart';
import 'package:exstudio/components/custom_expand_list/expandable_list_data.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ExpandList extends StatefulWidget {
  const ExpandList(
      {Key? key,
      this.width,
      this.height,
      this.items,
      this.expandDuration,
      required this.title,
      this.titleFontSize,
      this.itemBorderColor,
      required this.selectedItemColor,
      this.unselectedItemColor,
      this.expandArrowIcon,
      this.collapseArrowIcon,
      this.selectedItemDescriptionTextColor,
      this.unselectedItemDescriptionTextColor,
      this.titleTextColor,
      this.isExpandedAtStart,
      this.arrowIconColor})
      : super(key: key);

  final double? width;
  final double? height;
  final String? items;
  final int? expandDuration;
  final String title;
  final double? titleFontSize;
  final Color? itemBorderColor;
  final Color selectedItemColor;
  final Color? unselectedItemColor;
  final Widget? expandArrowIcon;
  final Widget? collapseArrowIcon;
  final Color? selectedItemDescriptionTextColor;
  final Color? unselectedItemDescriptionTextColor;
  final Color? titleTextColor;
  final bool? isExpandedAtStart;
  final Color? arrowIconColor;

  @override
  _ExpandListState createState() => _ExpandListState();
}

class _ExpandListState extends State<ExpandList>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    List<Target> items = targetsFromJson(widget.items ?? "");

    List<Widget> itemWidgets = [];

    for (var item in items) {
      itemWidgets.add(Builder(builder: (context) {
        return _nodeBuilder(context, item);
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

  Widget _nodeBuilder(context, Target node) {
    return Consumer<ExpandableListData>(builder: (context, value, child) {
      return Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: Material(
              borderRadius: BorderRadius.circular(4.0),
              color: value.selectedItem == node.key
                  ? widget.selectedItemColor
                  : widget.unselectedItemColor,
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                onTap: () {
                  setState(() {
                    Provider.of<ExpandableListData>(context, listen: false)
                        .selectItem(node.key);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                        color: value.selectedItem == node.key
                            ? widget.selectedItemDescriptionTextColor!
                            : widget.itemBorderColor!,
                        width: 1.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Expanded(
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 18.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(node.title,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,
                                            color: widget.titleTextColor)),
                                    node.description == null
                                        ? Container()
                                        : Padding(
                                            padding: const EdgeInsets.only(top: 4),
                                            child: Text(
                                              node.description!,
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  fontStyle: FontStyle.normal,
                                                  fontWeight: FontWeight.w400,
                                                  color: value.selectedItem ==
                                                          node.key
                                                      ? widget
                                                          .selectedItemDescriptionTextColor
                                                      : widget
                                                          .unselectedItemDescriptionTextColor),
                                            ),
                                          )
                                  ])),
                        ),
                      ),
                      value.selectedItem == node.key
                          ? Padding(
                              padding: const EdgeInsets.only(right: 18),
                              child: SvgPicture.asset(
                                'assets/icons/checkmark.svg',
                                width: 19.5,
                                height: 19.5,
                                color: widget.selectedItemColor.withOpacity(1),
                              ),
                            )
                          : const Padding(
                              padding: EdgeInsets.only(right: 18),
                              child: SizedBox(
                                width: 19.5,
                                height: 19.5,
                              ),
                            ),
                    ],
                  ),
                ),
              )));
    });
  }
}
