
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/presentation/bloc/cart/cart_cubit.dart';
import 'package:shop_app/presentation/bloc/cart/cart_states.dart';
import 'package:shop_app/presentation/const/app_message.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/views/admin/admin_view.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';
import 'package:shop_app/presentation/widgets/Custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'edit_product.dart';


class AdminProductDetails extends StatelessWidget {

  DocumentSnapshot posts;
  String tag;
  AdminProductDetails({Key? key,required this.posts,required this.tag}) : super(key: key);

  List data=[];


  @override
  Widget build(BuildContext context) {

    return  BlocProvider(
        create: (BuildContext context) => CartCubit(),
        child: BlocConsumer<CartCubit, CartStates>(
            listener: (context, state) {
              if(state is DeleteProductsSuccessState){
                appMessage(text: 'تم الحذف بنجاح');
                Get.offAll(const AdminView());
              }
            },
            builder: (context, state) {
              CartCubit cubit = CartCubit.get(context);
              return Scaffold(
                backgroundColor:Colors.grey[100],
                appBar: AppBar(
                  toolbarHeight: 2,
                  backgroundColor:ColorsManager.primary,
                ),
                body:SingleChildScrollView(
                  child: Column(
                    children:  [
                      // const SizedBox(height: 10,),
                      Hero(
                        tag: tag,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:BorderRadius.circular(21),
                              color:Colors.grey[100]
                          ),
                          width: MediaQuery.of(context).size.width,
                          //height: 600,
                          child:Image.network(posts['image'],
                              fit:BoxFit.cover
                          ),
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(
                            borderRadius:BorderRadius.circular(22),
                            color:ColorsManager.primary2,
                            shape: BoxShape.rectangle
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Custom_Text(text: posts['name'],
                                  color:ColorsManager.primary
                                  ,fontSize:16,alignment:Alignment.center,),

                                const SizedBox(width: 60,),

                              ],
                            ),
                            const SizedBox(height: 20,),


                            const SizedBox(height: 20,),
                            const Divider(
                              endIndent:0.8,
                              thickness: 0.7,
                            ),

                            const SizedBox(height: 10,),
                            Custom_Text(text:" ${posts['price']}   ",
                              color:ColorsManager.primary,
                              fontSize:22,alignment:Alignment.center,),
                            const SizedBox(height: 22,),
                            CustomButton(text: 'تعديل ', onPressed:(){

                              Get.to(EditProduct(
                                posts: posts,
                              ));


                            }, color1: ColorsManager.primary, color2: ColorsManager.primary2),
                            const SizedBox(height: 22,),
                            CustomButton(text: ' حذف  ', onPressed:(){

                              cubit.DeleteDataInFireBase(
                                posts: posts
                              );
                            }, color1: ColorsManager.primary, color2: ColorsManager.primary2),
                            const SizedBox(height: 50,),
                          ],
                        ),
                      ),


                    ],
                  ),
                ),
              );
            }));

  }
}








