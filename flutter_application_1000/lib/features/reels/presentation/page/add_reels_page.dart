import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1000/Core/network/service_locator.dart';
import 'package:flutter_application_1000/Core/style/app_Colors.dart';
import 'package:flutter_application_1000/Core/style/app_text_style.dart';
import 'package:flutter_application_1000/features/Home/presentation/page/add_new_car_page.dart';
import 'package:flutter_application_1000/features/Home/presentation/page/edit_Prodect_page.dart';
import 'package:flutter_application_1000/features/Home/presentation/widget/Custom_Button_With_icon.dart';
import 'package:flutter_application_1000/features/reels/data/remoute_data_reels_source.dart';
import 'package:flutter_application_1000/features/reels/presentation/manager/reels_state_cubit.dart';
import 'package:flutter_application_1000/features/reels/presentation/widget/add_Reel_Details.dart';
import 'package:flutter_application_1000/features/reels/presentation/widget/attach_product_services.dart';
import 'package:flutter_application_1000/features/reels/presentation/widget/preview_add_reel.dart';
import 'package:flutter_application_1000/features/reels/presentation/widget/publishing_option_widget.dart';
import 'package:flutter_application_1000/features/reels/presentation/widget/up;oad_reel_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class AddReelsPage extends StatelessWidget {
  AddReelsPage({super.key});
  XFile? vidoe = null;
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> form = GlobalKey();
    TextEditingController title = TextEditingController();
    TextEditingController descraption = TextEditingController();
    return BlocProvider(
      create: (context) => ReelsStateCubit(getIt<remouteDataReelsSource>()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            // bottomNavigationBar: BlocBuilder<ReelsStateCubit, reelsState>(
            //   builder: (context, state) {
            //     return CustomButtonWithIcon(
            //       type: 'add reel',
            //       iconButton: Icons.add,
            //       ontap: () {
            //         print(state.video!.path);
            //         // remouteDataReelsSource(dio: Dio()).addNewReels(state.video);
            //       },
            //     );
            //   },
            // ),
            appBar: AppBar(
              backgroundColor: Color(0xffffffff),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  BlocProvider.of<ReelsStateCubit>(context).getDataReels();
                },
                icon: Icon(Icons.arrow_back),
              ),
              title: Text(
                'Add New Reel',
                style: AppTextStyle.poppins418blueBlack,
              ),
              centerTitle: true,
            ),
            backgroundColor: AppColors.background,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Form(
                  key: form,
                  child: Column(
                    children: [
                      UploadReelWidget(
                        video: (value) {
                          print(value!.path);
                          vidoe = value;
                        },
                      ),
                      addReelDetailsWidget(
                        title: title,
                        descraption: descraption,
                      ),
                      // attachProductOrService(),
                      // PublishingOptionsWidget(),
                      // preview_add_reel_widget(),
                      BlocConsumer<ReelsStateCubit, reelsState>(
                        listener: (context, state) {
                          if (state.isSuccess == true) {
                            BlocProvider.of<ReelsStateCubit>(
                              context,
                            ).getDataReels();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: CustomSnakeBar(
                                  text: 'add reel is success',
                                ),
                                backgroundColor:
                                    Colors.transparent, // ⬅️ جعل الخلفية شفافة
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(
                                  top: 20, // مسافة من الأعلى
                                  left: 10,
                                  right: 10,
                                ),
                              ),
                            );
                            // BlocProvider.of<ReelsStateCubit>(
                            //   context,
                            // ).getDataReels();
                            Navigator.pop(context);
                          } else if (state.error != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: CustomSnakeBar(
                                  text: state.error!,
                                  isFailure: true,
                                ),
                                backgroundColor:
                                    Colors.transparent, // ⬅️ جعل الخلفية شفافة
                                elevation: 0,
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(
                                  top: 20, // مسافة من الأعلى
                                  left: 10,
                                  right: 10,
                                ),
                              ),
                            );
                          }
                        },
                        builder: (context, state) {
                          return CustomButtonWithIcon(
                            type: 'add reels',
                            iconButton: Icons.add,
                            ontap: () {
                              // print(state.video!.path);
                              // print(vidoe!.path);
                              // remouteDataReelsSource(dio: Dio()).addNewReel(
                              //   state.video,
                              //   title.text,
                              //   descraption.text,
                              // );
                              if (form.currentState!.validate()) {
                                if (vidoe != null) {
                                  // print(vidoe!.path);
                                  BlocProvider.of<ReelsStateCubit>(
                                    context,
                                  ).AddNewReel(
                                    vidoe,
                                    title.text,
                                    descraption.text,
                                  );
                                } else if (vidoe == null) {
                                  return ScaffoldMessenger.of(
                                    context,
                                  ).showSnackBar(
                                    SnackBar(
                                      content: CustomSnakeBar(
                                        isFailure: true,
                                        text: 'upload video , please',
                                      ),
                                      backgroundColor: Colors
                                          .transparent, // ⬅️ جعل الخلفية شفافة
                                      elevation: 0,
                                      behavior: SnackBarBehavior.floating,
                                      margin: EdgeInsets.only(
                                        top: 20, // مسافة من الأعلى
                                        left: 10,
                                        right: 10,
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
