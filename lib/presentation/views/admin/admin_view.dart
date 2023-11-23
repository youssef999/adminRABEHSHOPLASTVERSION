import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/presentation/resources/assets_manager.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/views/admin/money/money_sent.dart';
import 'package:shop_app/presentation/views/admin/products/add_product.dart';
import 'package:shop_app/presentation/views/admin/sendNotifications/send_notifications.dart';
import 'package:shop_app/presentation/views/admin/txt.dart';
import 'package:shop_app/presentation/widgets/Custom_button.dart';
import 'ST/st_view.dart';
import 'cat/add_cat.dart';
import 'cat/all_cat.dart';
import 'money/min_money.dart';
import 'money/money_request_view.dart';
import 'orders/orders.dart';
import 'products/products_view.dart';

class AdminView extends StatelessWidget {
  const AdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:Colors.white,
      appBar:AppBar(
        toolbarHeight: 3,
        backgroundColor:ColorsManager.primary,
      ),
      body:Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            const SizedBox(height: 11,),
            SizedBox(
              height: 120,
              child:Image.asset(AssetsManager.Logo),
            ),
            const SizedBox(height: 20,),
            CustomButton(text:'اضف منتج جديد', onPressed:(){
              Get.to(const AddNewProduct());
              }, color1:ColorsManager.primary, color2: ColorsManager.primary2),
            const SizedBox(height: 20,),

            CustomButton(text:'جميع المنتجات ', onPressed:(){
              Get.to(ProductsView());
            }, color1:ColorsManager.primary, color2: ColorsManager.primary2),

            const SizedBox(height: 20,),

            CustomButton(text:'اضف قسم جديد  ', onPressed:(){
              Get.to(const AddNewCat());
            }, color1:ColorsManager.primary, color2: ColorsManager.primary2),

            const SizedBox(height: 20,),

            CustomButton(text:'جميع الاقسام  ', onPressed:(){
              Get.to(const CatView());
            }, color1:ColorsManager.primary, color2: ColorsManager.primary2),

            const SizedBox(height: 20,),

            CustomButton(text:'الإحصاءات', onPressed:(){

              Get.to(const StView());

              }, color1:ColorsManager.primary, color2: ColorsManager.primary2),

            const SizedBox(height: 20,),

            CustomButton(text:'ارسال اشعارات للمستخدمين', onPressed:(){


              Get.to(const SendNotificationsView());


            }, color1:ColorsManager.primary, color2: ColorsManager.primary2),



            CustomButton(text:'طلبات بانتظار الموافقة ', onPressed:(){
              Get.to( OrdersView(
                status: 'waiting',
              ));
            }, color1:ColorsManager.primary, color2: ColorsManager.primary2),
         // MoneyRequestView

            const SizedBox(height: 20,),

            CustomButton(text:'طلبات تمت الموافقة عليها ', onPressed:(){
              Get.to( OrdersView(
                status: 'accept',
              ));
            }, color1:ColorsManager.primary, color2: ColorsManager.primary2),

            const SizedBox(height: 20,),

            CustomButton(text:'طلبات تمت توصيلها  ', onPressed:(){

              Get.to( OrdersView(
                status: 'del',
              ));

            }, color1:ColorsManager.primary, color2: ColorsManager.primary2),


            const SizedBox(height: 20,),

            CustomButton(text:'طلبات تم رفضها  ', onPressed:(){
              Get.to( OrdersView(
                status: 'refuse',
              ));
            }, color1:ColorsManager.primary, color2: ColorsManager.primary2),


            //MinMoneyView
            const SizedBox(height: 18,),
            CustomButton(text:'اقل سعر للسحب  ', onPressed:(){

              Get.to(  MinMoneyView());

              }, color1:ColorsManager.primary, color2: ColorsManager.primary2),

            const SizedBox(height: 18,),
            CustomButton(text:'طلب سحب الاموال ', onPressed:(){
              Get.to( const MoneyRequestView(

              ));
            }, color1:ColorsManager.primary, color2: ColorsManager.primary2),

            const SizedBox(height: 11,),

            CustomButton(text:'الاموال المرسلة ', onPressed:(){
              Get.to( const MoneySentView(
              ));
            }, color1:ColorsManager.primary, color2: ColorsManager.primary2),


            const SizedBox(height: 18,),
            CustomButton(text:'نص استعمال التطبيق  ', onPressed:(){
              Get.to(const TxtView());

            }, color1:ColorsManager.primary, color2: ColorsManager.primary2),

          ],
        ),
      ),
    );
  }
}
