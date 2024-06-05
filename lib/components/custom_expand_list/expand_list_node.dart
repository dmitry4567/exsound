import 'package:exstudio/components/custom_expand_list/expandable_list_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ExpandListNode extends StatefulWidget {
  const ExpandListNode(
      {Key? key,
      this.width,
      this.height,
      required this.target,
      this.titleFontSize,
      required this.itemBorderColor,
      required this.selectedItemColor,
      this.unselectedItemColor,
      this.titleTextColor,
      required this.innerVerticalPadding,
      required this.fontSize,
      required this.fontWeight,
      this.margin})
      : super(key: key);

  final double? width;
  final double? height;
  final Target target;
  final double? titleFontSize;
  final Color itemBorderColor;
  final Color selectedItemColor;
  final Color? unselectedItemColor;
  final Color? titleTextColor;
  final double innerVerticalPadding;
  final double fontSize;
  final FontWeight fontWeight;
  final double? margin;

  @override
  _ExpandListNodeState createState() => _ExpandListNodeState();
}

class _ExpandListNodeState extends State<ExpandListNode> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpandableListData>(builder: (context, value, child) {
      return Container(
          margin: const EdgeInsets.only(top: 16.0),
          child: Material(
              borderRadius: BorderRadius.circular(4.0),
              color: value.selectedItem == widget.target.key
                  ? widget.selectedItemColor.withOpacity(0.1)
                  : widget.unselectedItemColor,
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                onTap: () {
                  setState(() {
                    Provider.of<ExpandableListData>(context, listen: false)
                        .selectItem(widget.target.key);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(
                          color: value.selectedItem == widget.target.key
                              ? widget.selectedItemColor.withOpacity(1)
                              : widget.itemBorderColor,
                          width: 1.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: widget.innerVerticalPadding,
                            horizontal: 18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.target.title,
                              style: TextStyle(
                                  fontSize: widget.fontSize,
                                  fontWeight: widget.fontWeight,
                                  fontStyle: FontStyle.normal,
                                  color: widget.titleTextColor),
                            ),
                          ],
                        ),
                      ),
                      value.selectedItem == widget.target.key
                          ? Padding(
                              padding: const EdgeInsets.only(right: 18),
                              child: SvgPicture.asset(
                                'assets/icons/checkmark.svg',
                                width: 19.5,
                                height: 19.5,
                                color: widget.selectedItemColor.withOpacity(1),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              )));
    });
  }
}
