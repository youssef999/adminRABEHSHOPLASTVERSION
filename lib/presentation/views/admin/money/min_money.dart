


 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/presentation/const/app_message.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';
import 'package:shop_app/presentation/widgets/Custom_button.dart';
import 'package:shop_app/presentation/widgets/custom_textformfield.dart';

import '../admin_view.dart';

class MinMoneyView extends StatelessWidget {

 MinMoneyView({super.key});

  TextEditingController minPrice=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(
        backgroundColor:ColorsManager.primary,
        toolbarHeight: 55,
        leading:IconButton(
          onPressed:(){
            Get.back();
          },
          icon:const Icon(Icons.arrow_back_ios,color:Colors.white,),
        ),
      ),
      body:ListView(
        children: [
          const SizedBox(height: 20,),
          MoneyRequestWidget(),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextFormField(hint: 'اقل سعر للسحب ',
                obx: false, ontap:(){

                }, type: TextInputType.text
                , obs: false, color: Colors.black,
                controller:minPrice),
          ),

          const SizedBox(height: 22,),
          CustomButton(text: 'تعديل',
              onPressed: (){
            appMessage(text: 'تم التعديل');
                EditDataInFireBase();
              }, color1: Colors.black, color2: Colors.white)
        ],
      ),
    );
  }
  EditDataInFireBase
      ()async{
    final CollectionReference _updates =
    FirebaseFirestore.instance.collection('minMoneyRequest');
    await _updates
        //.where('email', isEqualTo: posts['email'])
        .get().then((snapshot) {
      snapshot.docs.last.reference.update({
        'number':int.parse(minPrice.text)
      }).then((value) {
        print("EDITED");
        Get.offAll(const AdminView());

      });
    });
  }

}
 Widget MoneyRequestWidget() {
   return SizedBox(
     height: 78,
     child: StreamBuilder(
         stream: FirebaseFirestore.instance.
         collection('minMoneyRequest').snapshots(),
         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
           if (!snapshot.hasData) {
             return const Center(child: CircularProgressIndicator());
           }
           switch (snapshot.connectionState) {
             case ConnectionState.waiting:
               return const Center(child: CircularProgressIndicator());
             default:
               return GridView.builder(
                   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                       crossAxisCount: 1,
                       crossAxisSpacing: 2,
                       mainAxisSpacing: 4,
                       childAspectRatio:0.98
                   ),
                   physics: const NeverScrollableScrollPhysics(),
                   itemCount: snapshot.data!.docs.length,
                   itemBuilder: (context, index) {
                     DocumentSnapshot posts = snapshot.data!.docs[index];
                     if (snapshot.data == null) {
                       return const CircularProgressIndicator();
                     }
                     return
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Card(
                           child:Column(
                             children: [
                               const Custom_Text(text: 'اقل سعر للسحب الان ',
                                 fontSize:21,color:Colors.black,
                                 alignment:Alignment.center,
                               ),
                               const SizedBox(height: 5,),
                               Custom_Text(text: posts['number'].toString(),
                                 fontSize:21,color:Colors.black,
                                 alignment:Alignment.center,
                               ),

                             ],
                           ),
                         ),
                       );
                   });
           }
         }),
   );
 }