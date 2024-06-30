import 'package:expandable/expandable.dart';
import 'package:exstudio/session/widgets/type/expand_list_node_type.dart';
import 'package:exstudio/session/widgets/model.dart';
import 'package:flutter/material.dart';

class ExpandSubListNode extends StatefulWidget {
  const ExpandSubListNode(
      {Key? key,
      this.width,
      this.height,
      required this.items,
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
      this.isExpandedAtStart = false,
      this.arrowIconColor,
      required this.childInnerVerticalPadding,
      required this.childFontSize})
      : super(key: key);

  final double? width;
  final double? height;
  final List<Target> items;
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
  final bool isExpandedAtStart;
  final Color? arrowIconColor;
  final double childInnerVerticalPadding;
  final double childFontSize;

  @override
  _ExpandSubListNodeState createState() => _ExpandSubListNodeState();
}

class _ExpandSubListNodeState extends State<ExpandSubListNode>
    with SingleTickerProviderStateMixin {
  late bool _isExpand;
  late AnimationController _animationController;
  late ExpandableController _expandableController;
  List<Widget> itemWidgets = [];

  @override
  void initState() {
    super.initState();
    _isExpand = widget.isExpandedAtStart;

    _animationController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: widget.expandDuration ?? 500),
        upperBound: 0.5);

    _expandableController =
        ExpandableController(initialExpanded: widget.isExpandedAtStart);

    for (var item in widget.items) {
      itemWidgets.add(Builder(builder: (context) {
        return ExpandListNode(
          target: item,
          titleFontSize: 20,
          fontSize: widget.childFontSize - 2,
          innerVerticalPadding: widget.childInnerVerticalPadding - 2,
          fontWeight: FontWeight.w400,
          itemBorderColor: const Color(0xffCBD4DD),
          selectedItemColor: const Color(0x0fc7e100).withOpacity(0.1),
          unselectedItemColor: Colors.white,
          titleTextColor: Colors.black,
          margin: 0,
        );
      }));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        controller: _expandableController,
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
                  margin: const EdgeInsets.only(top: 16.0),
                  child: Material(
                      borderRadius: BorderRadius.circular(4.0),
                      color: _isExpand
                          ? widget.selectedItemColor
                          : widget.unselectedItemColor,
                      clipBehavior: Clip.hardEdge,
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              border: Border.all(
                                  color: widget.itemBorderColor ?? Colors.black,
                                  width: 1.0)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 18.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18,
                                        fontStyle: FontStyle.normal,
                                        color: widget.titleTextColor),
                                  ),
                                ),
                                ExpandableTheme(
                                    data: ExpandableThemeData(
                                      animationDuration: Duration(
                                          milliseconds:
                                              widget.expandDuration ?? 500),
                                      useInkWell: true,
                                      inkWellBorderRadius:
                                          BorderRadius.circular(20),
                                    ),
                                    child: ExpandableButton(
                                      child: RotationTransition(
                                        turns: Tween(begin: 0.0, end: 1.0)
                                            .animate(_animationController),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.keyboard_arrow_down,
                                            color: widget.arrowIconColor,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              if (_isExpand) {
                                                _animationController.reverse(
                                                    from: 0.5);
                                              } else {
                                                _animationController.forward(
                                                    from: 0.0);
                                              }
                                              _isExpand = !_isExpand;
                                              _expandableController.toggle();
                                            });
                                          },
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          )))),
              collapsed: Container(),
              expanded: Column(
                children: itemWidgets,
              ),
            )
          ],
        ))));
  }

  void updateExpandState(bool newExpandState) {
    setState(() {
      _isExpand = newExpandState;
    });
  }
}
