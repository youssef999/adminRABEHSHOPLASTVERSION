




import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shop_app/presentation/bloc/admin/admin-states.dart';
import 'package:shop_app/presentation/bloc/admin/admin_cubit.dart';
import 'package:shop_app/presentation/const/app_message.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/views/admin/admin_view.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';
import 'package:shop_app/presentation/widgets/Custom_button.dart';

import '../../widgets/custom_textformfield.dart';


class EditTxt extends StatelessWidget {
  DocumentSnapshot posts;

  EditTxt ({Key? key,required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AdminCubit(),
        child: BlocConsumer<AdminCubit, AdminStates>(

            listener: (context, state) {

              if(state is EditProductsSuccessState){
                appMessage(text: 'تم التعديل بنجاح');
                Get.offAll(const AdminView());
              }
            },

            builder: (context, state) {

              AdminCubit cubit = AdminCubit.get(context);
              //   List images=posts['image'];
              return Scaffold(
                appBar:AppBar(
                  toolbarHeight: 55,
                  backgroundColor:ColorsManager.primary,
                  leading:IconButton(
                    onPressed:(){
                      Get.back();
                    },
                    icon:
                    const
                    Icon(Icons.arrow_back_ios,color:Colors.white,),
                  ),
                ),
                body:Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: ListView(
                    children:  [
                      const SizedBox(height: 1,),


                      const SizedBox(height: 20,),
                      const Custom_Text(text: 'النص  ',
                        alignment:Alignment.center,
                        fontSize:25,color:Colors.black,
                      ),
                      const SizedBox(height: 10,),
                      CustomTextFormField(
                        controller:cubit.nameController,
                        color:Colors.black,
                        hint: posts['txt'],
                        max: 2,
                        obs: false,
                        obx: false,
                        ontap:(){},
                        type:TextInputType.text,
                      ),






                        const SizedBox(height: 22,),
                      CustomButton(text: " تعديل ",
                          onPressed: (){

                            cubit.EditDataInFireBase2(posts: posts);


                          }, color1:ColorsManager.primary,
                          color2: Colors.white),
                      const SizedBox(height: 30,),
                    ],
                  ),
                ),
              );
            }));
  }
}