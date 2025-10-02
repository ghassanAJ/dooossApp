import 'package:flutter/material.dart';
import 'package:flutter_application_1000/features/reels/data/models/Reels_data_model.dart';
import 'package:flutter_application_1000/features/reels/presentation/page/my_reels_page.dart';
import 'package:flutter_application_1000/features/reels/presentation/widget/body_reel.dart';
import 'package:flutter_application_1000/features/reels/presentation/widget/video_palyer_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReelCardWidget extends StatelessWidget {
  const ReelCardWidget({super.key, required this.item});
  final ReelDataModel item;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 17, top: 6),
      width: 358.w,
      // height: 826.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xffffffff),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            offset: Offset(0, 2),
            color: Color.fromARGB(21, 0, 0, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          VideoPlayerWidget(videoUrl: item.video),
          // Container(
          //   width: double.infinity,
          //   height: 632,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(10),
          //     color: Colors.black,
          //   ),
          // ),
          bodyReel(item: item),
        ],
      ),
    );
  }
}
