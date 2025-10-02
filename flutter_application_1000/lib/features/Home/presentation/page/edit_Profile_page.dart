import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1000/Core/network/service_locator.dart';
import 'package:flutter_application_1000/Core/style/app_Colors.dart';
import 'package:flutter_application_1000/Core/style/app_text_style.dart';
import 'package:flutter_application_1000/features/Home/data/remouteData/home_page_state.dart';
import 'package:flutter_application_1000/features/Home/data/remouteData/remoute_dealer_data_source.dart';
import 'package:flutter_application_1000/features/Home/presentation/manager/home_page_cubit.dart';
import 'package:flutter_application_1000/features/Home/presentation/page/Log_in_page.dart';
import 'package:flutter_application_1000/features/Home/presentation/page/edit_Prodect_page.dart';
import 'package:flutter_application_1000/features/Home/presentation/page/home_Page1.dart';
import 'package:flutter_application_1000/features/Home/presentation/widget/Change_status_store.dart';
import 'package:flutter_application_1000/features/Home/presentation/widget/Custom_Button_With_icon.dart';
import 'package:flutter_application_1000/features/Home/presentation/widget/Location_selection_widget.dart';
import 'package:flutter_application_1000/features/Home/presentation/widget/Select_Store_type_widget.dart';
import 'package:flutter_application_1000/features/Home/presentation/widget/bottom_navigationBar_of_Edit_Store.dart';
import 'package:flutter_application_1000/features/Home/presentation/widget/contectI_info_widget.dart';
import 'package:flutter_application_1000/features/Home/presentation/widget/form_edit_profile_widget.dart';
import 'package:flutter_application_1000/features/Home/presentation/widget/upload_logo_store_widget.dart';
import 'package:flutter_application_1000/features/reels/presentation/widget/Custom_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class EditStoreProfile extends StatefulWidget {
  EditStoreProfile({
    super.key,
    required this.storeName,
    required this.phone,
    required this.location,
    required this.email,
    required this.storeDescription,
    required this.closeTime,
    required this.openTime,
    required this.lat,
    required this.log,
  });
  final TextEditingController storeName;
  final TextEditingController storeDescription;
  final TextEditingController phone;
  final TextEditingController location;
  final TextEditingController email;
  final String closeTime;
  final String openTime;
  final String lat;
  final String log;
 
  @override
  State<EditStoreProfile> createState() => _EditStoreProfileState();
}

class _EditStoreProfileState extends State<EditStoreProfile> {
  late String latValue;
  late String lonValue;
  late String close;
  late String start;
  List<String> days = [];
  @override
  void initState() {
    // TODO: implement initState
    close = widget.closeTime;
    start = widget.openTime;
    latValue = widget.lat;
    lonValue = widget.log;
    super.initState();
  }
GlobalKey<FormState> form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    late bool isAvaiable = true;
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: Color(0xffffffff),
        title: 'Edit Store',
        subtitle: '',
        ontap: () {
          BlocProvider.of<HomePageCubit>(context).getDataProfile();
        },
      ),
      backgroundColor: AppColors.background,
      // appBar: AppBar(),
      // bottomNavigationBar: BottonNavigationOfEditStore(isAvaialble: isAvaiable),
      body: BlocListener<HomePageCubit, HomepageState>(
        listener: (context, state) {
          if (state.isSuccessEditProduct == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: CustomSnakeBar(text: 'Add Car is Success'),
                backgroundColor: Colors.transparent, // ⬅️ جعل الخلفية شفافة
                elevation: 0,
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.only(
                  top: 20, // مسافة من الأعلى
                  left: 10,
                  right: 10,
                ),
              ),
            );
            BlocProvider.of<HomePageCubit>(context).getDataProfile();
            Navigator.pop(context);
          } else if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: CustomSnakeBar(
                  text: 'failure edit Store ',
                  isFailure: true,
                ),
                backgroundColor: Colors.transparent, // ⬅️ جعل الخلفية شفافة
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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
            child: Center(
              child: Form(
                key: form,
                child: Column(
                  children: [
                    formEditProfileWidget(
                      storeName: widget.storeName,
                      storeDescription: widget.storeDescription,
                    ),
                    // AddStoreLogoWidget(),
                    ContactInfoWidget(phone: widget.phone,email: widget.email,),
                    locationSelectWidget(
                      lat: (value) {
                        latValue = value;
                      },
                      lon: (value) {
                        lonValue = value;
                      },
                      location: widget.location,
                      linkGoogle: widget.email,
                    ),
                    // storeTypeSelectWidget(),
                    changeStatusStoreWidget(
                      openungTime: (String value) {
                        start = value;
                      },
                      closeTime: (String value) {
                        close = value;
                        print(value);
                      },
                      day: (daysSelected) {
                        print(daysSelected);
                        days = daysSelected;
                      },
                    ),

                    // selectStoreStatus(
                    //   toggleStatus: (value) {
                    //     // print(value);
                    //     isAvaiable = value;
                    //     print(isAvaiable);
                    //   },
                    // ),
                    BottonNavigationOfEditStore(
                      reset: () {
                        widget.storeName.text = '';
                        widget.storeDescription.text = '';
                        widget.phone.text = '';
                        days = [];
                      },
                      onTap: () {
                            if (form.currentState!.validate()) {
                               BlocProvider.of<HomePageCubit>(context).EditDataProfile(
                          widget.storeName.text,
                          widget.storeDescription.text,
                          widget.phone.text,
                          close.toString(),
                          start.toString(),
                          latValue,
                          lonValue,
                          days,
                        );
                            }
                       
                      },
                      isAvaialble: isAvaiable,
                      name: widget.storeName.text,
                      descraption: widget.storeDescription.text,
                      phone: widget.phone.text,
                      email: widget.email.text,
                      location: widget.location.text,
                      linkGoogle: widget.email.text,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
