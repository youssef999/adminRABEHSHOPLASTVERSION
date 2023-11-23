

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/presentation/widgets/Custom_button.dart';

import '../../widgets/Custom_Text.dart';
import 'edit_txt.dart';

class TxtView extends StatelessWidget {
  const TxtView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(

        leading: IconButton(
          icon:const Icon(Icons.arrow_back_ios,color:Colors.white,

          ),
          onPressed:(){
            Get.back();
          },
        ),
        backgroundColor:Colors.black,
      ),
      body:Column(
        children: [
          const SizedBox(height: 31,),
          TXTWidget()
        ],
      ),
    );
  }
}

Widget TXTWidget() {
  return SizedBox(
    height: 120,
    child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('txt')
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              return ListView.builder(

                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot posts = snapshot.data!.docs[index];
                    if (snapshot.data == null) {
                      return const CircularProgressIndicator();
                    }
                    return InkWell(
                      child: Column(
                        children: [
                          Custom_Text(text: posts['txt'],fontSize:17,alignment:Alignment.center,
                            fontWeight:FontWeight.bold,
                          ),
                          const SizedBox(height: 22,),
                          CustomButton(text: 'تعديل',
                              onPressed: (){
                            Get.to(EditTxt(
                              posts: posts,
                            ));
                              }, color1:Colors.black, color2:Colors.white),
                          const SizedBox(height: 22,),
                        ],
                      ),
                    );
                  });
          }
        }),
  );
}