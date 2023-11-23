

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/views/admin/admin_view.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';
import 'package:shop_app/presentation/widgets/Custom_button.dart';

class MoneySentView extends StatelessWidget {
  const MoneySentView({super.key});

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
          stream: FirebaseFirestore.instance.collection('moneyRequest')
              .where('status',isEqualTo:'confirm')
              .snapshots(),
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
                        crossAxisCount: 2,
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 4,
                        childAspectRatio:1.2
                    ),
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
                              Text("البريد الالكتروني "),
                              Custom_Text(text: posts['email'],
                                fontSize:21,color:Colors.black,
                                alignment:Alignment.center,
                              ),
                              const SizedBox(height: 11,),
                              Text('الاموال '),
                              Custom_Text(text: posts['money'].toString(),
                                fontSize:21,color:Colors.black,
                                alignment:Alignment.center,
                              ),
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

  final CollectionReference _updates =
  FirebaseFirestore.instance.collection('moneyRequest');
  await _updates
      .where('email', isEqualTo: posts['email'])
      .get().then((snapshot) {
    snapshot.docs.last.reference.update({
      'status':"confirm"
    }).then((value) {

      print("EDITED");
      //Get.offAll(AdminView());

    });
  });
}

