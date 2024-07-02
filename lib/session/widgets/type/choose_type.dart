
import 'package:exstudio/session/cubit/session_cubit.dart';
import 'package:exstudio/session/cubit/session_state.dart';
import 'package:exstudio/session/widgets/type/expand_list_node_type.dart';
import 'package:flutter/material.dart';

class ChooseTypeWidget extends StatefulWidget {
  const ChooseTypeWidget({super.key, required this.context});

  final BuildContext context;

  @override
  State<ChooseTypeWidget> createState() => _ChooseTypeWidgetState();
}

class _ChooseTypeWidgetState extends State<ChooseTypeWidget> {
  List<Widget> typeWidgets = [];

  void initState() {
    super.initState();

    for (var i = 0; i < SessionCubit.listTypes.length; i++) {
      typeWidgets.add(
        ExpandListNodeType(
          target: Target(key: i, title: SessionCubit.listTypes[i].name),
          fontSize: 16,
          innerVerticalPadding: 12,
          innerHorizontalPadding: 16,
          fontWeight: FontWeight.w400,
          itemBorderColor: const Color(0xffCBD4DD),
          selectedItemColor: const Color(0xff8D40FF).withOpacity(0.1),
          unselectedItemColor: Colors.white,
          titleTextColor: Colors.black,
          margin: 0,
          context: widget.context,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(18),
        ),
      ),
      child: ListView(children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 18, bottom: 18),
                  child: Text(
                    "Закрыть",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Inter',
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "тип",
                      style: TextStyle(
                        fontSize: 35,
                        fontFamily: 'BebasNeue',
                        color: Colors.black,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  children: [...typeWidgets],
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
