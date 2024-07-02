
import 'package:exstudio/session/cubit/session_cubit.dart';
import 'package:exstudio/session/cubit/session_state.dart';
import 'package:exstudio/session/widgets/admin/expand_list_node_admin.dart';
import 'package:flutter/material.dart';

class ChooseAdminWidget extends StatefulWidget {
  const ChooseAdminWidget({super.key, required this.context});

  final BuildContext context;

  @override
  State<ChooseAdminWidget> createState() => _ChooseAdminWidgetState();
}

class _ChooseAdminWidgetState extends State<ChooseAdminWidget> {
  List<Widget> typeWidgets = [];

  void initState() {
    super.initState();
    
    for (var i = 0; i < SessionCubit.listAdmins.length; i++) {
      typeWidgets.add(
        ExpandListNodeAdmin(
          target: Target(key: i, title: SessionCubit.listAdmins[i].nickname),
          fontSize: 16,
          innerVerticalPadding: 18,
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
                      "админы",
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
