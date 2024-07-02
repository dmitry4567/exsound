import 'package:exstudio/session/cubit/session_cubit.dart';
import 'package:exstudio/session/cubit/session_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpandListNodeType extends StatefulWidget {
  const ExpandListNodeType(
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
      required this.innerHorizontalPadding,
      required this.fontSize,
      required this.fontWeight,
      this.margin,
      required this.context})
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
  final double innerHorizontalPadding;
  final double fontSize;
  final FontWeight fontWeight;
  final double? margin;
  final BuildContext context;

  @override
  _ExpandListNodeTypeState createState() => _ExpandListNodeTypeState();
}

class _ExpandListNodeTypeState extends State<ExpandListNodeType> {
  @override
  Widget build(BuildContext context) {
    final cubit = this.context.watch<SessionCubit>();

    return Container(
        margin: const EdgeInsets.only(top: 16.0),
        child: Material(
            borderRadius: BorderRadius.circular(4.0),
            color: cubit.state.type == widget.target.title
                ? widget.selectedItemColor.withOpacity(0.1)
                : widget.unselectedItemColor,
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              onTap: () {
                cubit.updateType(widget.target.key);

                Navigator.of(context).pop();
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                        color: cubit.state.type == widget.target.title
                            ? widget.selectedItemColor.withOpacity(1)
                            : widget.itemBorderColor,
                        width: 1.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: widget.innerVerticalPadding,
                          horizontal: widget.innerHorizontalPadding),
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
                  ],
                ),
              ),
            )));
  }
}
