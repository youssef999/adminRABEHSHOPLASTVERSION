



 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/presentation/views/admin/admin_view.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';
import 'package:shop_app/presentation/widgets/Custom_button.dart';

class NotificationSentView extends StatelessWidget {
  const NotificationSentView ({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          const SizedBox(height: 100,),
          const Custom_Text(text: 'تم ارسال الاشعار بنجاح ',
          alignment:Alignment.center,
            color:Colors.black,
            fontSize: 30,
          ),
          const SizedBox(height: 20,),
          CustomButton(text: 'عودة للادمن ',
              onPressed: (){

            Get.offAll(const AdminView());

              }, color1:Colors.black, color2: Colors.white)
        ],
      ),
    );
  }
}
