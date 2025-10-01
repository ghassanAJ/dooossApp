import 'package:flutter/material.dart';
import 'package:flutter_application_1000/Core/style/app_text_style.dart';
import 'package:flutter_application_1000/features/reels/presentation/widget/video_palyer_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class currentReelEditWidget extends StatelessWidget {
  const currentReelEditWidget({super.key, required this.link});
  final String link;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Current Reel', style: AppTextStyle.poppins514),
        SizedBox(height: 12.2.w),
        Container(alignment: Alignment(0, -10),
          child: Center(child: VideoPlayerWidget(videoUrl: link)),
          height: 293.h, // طول الـ Container
          width: 158.w, // إذا تريد أن يعرض كامل الشاشة
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 9, 9, 9), // لون الخلفية
            borderRadius: BorderRadius.circular(12), // حواف مدورة (اختياري)
          ),
        ),
      ],
    );
  }
}
