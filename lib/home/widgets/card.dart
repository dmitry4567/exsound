import 'dart:developer';

import '../../flutter_flow/custom_functions.dart' as functions;
import 'package:exstudio/home/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../backend/api_requests/api_calls.dart';
import '../../flutter_flow/flutter_flow_util.dart';

class CardProject extends StatefulWidget {
  const CardProject({super.key, required this.data});

  final Project data;

  @override
  State<CardProject> createState() => _CardProjectState();
}

class _CardProjectState extends State<CardProject> {
  bool like = false;
  bool favorite = false;

  @override
  void initState() {
    super.initState();

    for (Like userLike in widget.data.likes) {
      if (userLike.userId == "4") {
        like = true;
      }
    }
  }

  void addLike(int id) async {
    setState(() {
      widget.data.likesCount++;
      widget.data.likes.add(Like(userId: '1'));
      like = true;
    });

    ApiCallResponse? likeProject = await LikeProject.call(
        token:
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NCwiaWF0IjoxNzEyODQwOTk4LCJleHAiOjE3MTU0MzI5OTh9.nQsDskLIDjPtvUFTBkvGp_NqdDjIEe4JeaajMOCPhP0",
        id: id);

    if (!functions.resultCodeSuccess(getJsonField(
      (likeProject.jsonBody ?? ''),
      r'''$.status''',
    ))) {
      log("error like");
    }
  }

  void unLike(int id) async {
    setState(() {
      widget.data.likesCount--;
      widget.data.likes.remove(Like(userId: '4'));
      like = false;
    });

    ApiCallResponse? unLikeProject = await UnLikeProject.call(
      token:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NCwiaWF0IjoxNzEyODQwOTk4LCJleHAiOjE3MTU0MzI5OTh9.nQsDskLIDjPtvUFTBkvGp_NqdDjIEe4JeaajMOCPhP0",
      id: id,
    );

    if (!functions.resultCodeSuccess(getJsonField(
      (unLikeProject.jsonBody ?? ''),
      r'''$.status''',
    ))) {
      log("error unlike");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: double.infinity,
      height: 300,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(18)),
        child: InkWell(
          onTap: () {
            print(dioClient.options.baseUrl);
          },
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Image.network(
                  '${dioClient.options.baseUrl}/photoItem/image/${widget.data.photos[0].fileName}',
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                left: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.5, 1],
                      colors: [
                        Colors.transparent,
                        Color(0x99000000),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 14,
                left: 16,
                right: 90,
                child: Row(
                  children: [
                    ClipOval(
                      child: Container(
                        width: 30,
                        height: 30,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.data.description.toString(),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 18,
                                fontFamily: 'RobotoFlex',
                                color: Colors.white,
                                height: 1),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            widget.data.author.nickname,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 12,
                                fontFamily: 'RobotoFlex',
                                color: Colors.white,
                                height: 1),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 16,
                bottom: 6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () async {
                        like ? unLike(widget.data.id) : addLike(widget.data.id);
                      },
                      splashColor: Colors.white,
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            like
                                ? 'assets/icons/like_pressed.svg'
                                : 'assets/icons/like.svg',
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            widget.data.likesCount.toString(),
                            style: const TextStyle(
                              fontSize: 10,
                              fontFamily: 'RobotoFlex',
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () {
                        favorite = !favorite;
                        setState(() {});
                      },
                      splashColor: Colors.white,
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            favorite
                                ? 'assets/icons/heart_pressed.svg'
                                : 'assets/icons/heart.svg',
                            width: 24,
                            height: 24,
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            "438k",
                            style: const TextStyle(
                              fontSize: 10,
                              fontFamily: 'RobotoFlex',
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
