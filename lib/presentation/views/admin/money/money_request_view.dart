

 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/presentation/const/app_message.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/views/admin/admin_view.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';
import 'package:shop_app/presentation/widgets/Custom_button.dart';

class MoneyRequestView extends StatelessWidget {
  const MoneyRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          const SizedBox(height: 22,),
          MoneyRequestWidget()
        ],
      ),
    );
  }
  Widget MoneyRequestWidget() {
    return SizedBox(
      height: 1220000,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('moneyRequest')
              .where('status',isEqualTo:'wait')
              .snapshots(),
          builder:
              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                return ListView.builder(
                    // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //     crossAxisCount: 1,
                    //     crossAxisSpacing: 2,
                    //     mainAxisSpacing: 4,
                    //     childAspectRatio:0.5
                    // ),
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot posts = snapshot.data!.docs[index];
                      if (snapshot.data == null) {
                        return const CircularProgressIndicator();
                      }
                      return 
                      Card(
                        child:Column(
                          children: [
                            const SizedBox(height: 11,),
                            const Text("الايميل "),
                            Custom_Text(text: posts['email'],
                            fontSize:21,color:Colors.black,
                              alignment:Alignment.center,
                            ),
                            const SizedBox(height: 11,),
                            const Text("الاسم "),
                            Custom_Text(text: posts['name'].toString(),
                              fontSize:21,color:Colors.black,
                              alignment:Alignment.center,
                            ),
                            const SizedBox(height: 11,),
                            const Text("الاموال "),
                            Custom_Text(text: posts['money'].toString(),
                              fontSize:21,color:Colors.black,
                              alignment:Alignment.center,
                            ),
                            const SizedBox(height: 11,),
                            const SizedBox(height: 11,),
                            const Text("رقم الهاتف  "),
                            (posts['phone'].toString().length>2)?
                            Custom_Text(text: posts['phone'].toString(),
                              fontSize:21,color:Colors.black,
                              alignment:Alignment.center,
                            ):const SizedBox(),
                            const SizedBox(height: 11,),
                            const Text("رقم الحساب "),
                            Custom_Text(text: posts['num'].toString(),
                              fontSize:16,color:Colors.black,
                              alignment:Alignment.center,
                            ),
                            const SizedBox(height: 11,),
                            CustomButton(text: 'تم ارسال الارباح',
                                onPressed: (){
                                  EditDataInFireBase(posts: posts);
                                  EditOrderDataInFireBase(posts: posts);

                                }, color1:Colors.black, color2: Colors.white),
                            const SizedBox(height: 11,),
                          ],
                        ),
                      );
                    });
            }
          }),
    );
  }
}

 EditDataInFireBase
     ({required DocumentSnapshot posts})async{

  print(posts['email']);

   final CollectionReference _updates =
   FirebaseFirestore.instance.collection('moneyRequest');
   await _updates
       .where('email', isEqualTo: posts['email']).
  // where('status',isNotEqualTo: 'confirm')
   where('money',isEqualTo: posts['money'])
       .get().then((snapshot) {
     snapshot.docs.last.reference.update({
       'status':"confirm"
     }).then((value) {


     });
   });
 }

 EditOrderDataInFireBase
     ({required DocumentSnapshot posts})async{


  print("ORDERIDS");
  List ordeIds=posts['orderIds']
      .toString().split(',');

  print(ordeIds);
  print(ordeIds[0].toString().replaceAll('[', '')
  .replaceAll(']', '')

  );
  print("/////");

   print(posts['email']);

  for (int i=0;i<posts['orderIds'].length;i++){

     final CollectionReference _updates =
     FirebaseFirestore.instance.collection('orders');
     await _updates
         .where('user_email', isEqualTo: posts['email']).
     // where('status',isNotEqualTo: 'confirm')
     where('order_id',isEqualTo:
     posts['orderIds'][i].replaceAll('[', '')
         .replaceAll(']', '')
   //  posts['orderIds'][i]
     )


         .get().then((snapshot) {
       snapshot.docs.first.reference.update({
         'commetion_status':"sent"
       }).then((value) {
         print("EDITED");

       });
     });
   }
  Future.delayed(const Duration(seconds: 2)).then((value) {
    appMessage(text: 'تم الارسال');
    Get.offAll(const AdminView());
  });


 }

