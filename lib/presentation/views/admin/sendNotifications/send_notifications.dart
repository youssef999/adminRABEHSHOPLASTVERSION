


 import 'dart:convert';
 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/presentation/views/admin/admin_view.dart';
import 'package:shop_app/presentation/views/admin/motifcation_sent.dart';
import 'package:shop_app/presentation/widgets/Custom_button.dart';
import 'package:shop_app/presentation/widgets/custom_textformfield.dart';

class SendNotificationsView extends StatefulWidget {
  const SendNotificationsView({super.key});

  @override
  State<SendNotificationsView> createState() => _SendNotificationsViewState();
}

class _SendNotificationsViewState extends State<SendNotificationsView> {

  TextEditingController title=TextEditingController();
  TextEditingController body=TextEditingController();


  @override
  void initState() {
    fetcTokens();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {

    title.dispose();
    body.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    return  Scaffold(
      appBar:AppBar(
        backgroundColor:Colors.black,
        leading:IconButton(onPressed: (){
          Get.offAll(const AdminView());
        }, icon: const Icon(Icons.arrow_back_ios)),
      ),
      body:Padding(
        padding: const EdgeInsets.all(19.0),
        child: Column(
          children: [
            const SizedBox(height: 73,),
            CustomTextFormField(hint: 'العنوان',
                obx: false, ontap: (){

                }, type: TextInputType.text, obs: false, color: Colors.black,

                controller: title),
            const SizedBox(height: 21,),

            CustomTextFormField(hint: 'محتوي الاشعار',
                obx: false, ontap: (){

                }, type: TextInputType.text, obs: false, color: Colors.black,

                controller: body),
            const SizedBox(height: 21,),

            InkWell(
              child: const Card(
                color:Colors.white,
                child:Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("ارسال الاشعارات الان "),
                ),
              ),
              onTap:(){

                print("HERE");
                sendNotificationNow
                  (token: tokens, title: title.text,
                    body: body.text);

                Future.delayed(const Duration(seconds: 2)).then((value) {

                 // Get.offAll(const NotificationSentView());
               //   Get.back();
                Get.offAll(const AdminView());

                });




              },
            ),
            // CustomButton(text: 'ارسال الاشعارات الان ',
            //     onPressed: (){
            //
            //
            //   print("HERE");
            //     sendNotificationNow
            //     (token: tokens, title: title.text,
            //         body: body.text);
            //    // Get.offAll(const AdminView());
            //
            //
            //     }, color1:Colors.black, color2: Colors.white)
          ],
        ),
      ),
    );
  }
}
 List<Map<String, dynamic>>tokenist = [];
 List<String>tokens = [];

 Future<void> fetcTokens() async {

   tokens=[];
   tokenist=[];

   print("MINNN");
   print(tokenist.length);
   print("///MIN");
   try {
     QuerySnapshot querySnapshot =
     await FirebaseFirestore.instance
         .collection('tokens').get();

     try{
       List<Map<String, dynamic>> data

       = querySnapshot.docs.map((DocumentSnapshot doc) =>
       doc.data() as Map<String, dynamic>).toList();


        tokenist = data;
         for(int i=0;i<tokenist.length;i++){
           tokens.add(tokenist[i]['token'].toString());
         }
         print("TOKENS==$tokens");
     }
     catch(e){
       print("E.......");
       print(e);
       print("E.......");
     }
   }
   catch (error) {
     print("Error fetching data: $error");
   }
 }

//
//  sendNotificationNow
//      ({required List token,
//    required String title,required String body}) async
//
//  {
//
//    print("T==");
//    print(token);
//
//    print("T==");
//    var responseNotification;
//    Map<String, String> headerNotification =
//    {
//      'Content-Type': 'application/json',
//      'Authorization':
//      'key=AAAAAhgtFZQ:APA91bGXxhm9fmKeoXql3LyIJdhLt2mi3-Go6DXPjkgDGQAuUaH42wRJx-GgxQ0biJb05fdPlDfIJ4OBwgLNrLHXQneDT41lE4Sk08wHzVOm4VdpYOtIakEyunbU5wfDIpUI4VkoKBHh'
//    };
//    Map bodyNotification =
//    {
//      "body":body,
//      "title":title
//    };
//
//    Map dataMap =
//    {
//      "click_action": "FLUTTER_NOTIFICATION_CLICK",
//      "id": "1",
//      "status": "done",
//      //   "rideRequestId": docId
//    };
//
//
//
//
//    for(int i=0;i<token.length;i++){
// //eEWWgSxoQvasSukvAAFkw9:APA91bFEesKoS0j36CePYsIjw6cmnjRwjbD0VehxxCLPrHHbC26026wFKSQi_JjW5hqZTYoUqS70dtgkAdUMI83CUfZqYPlx9pv12Sf-s8tHpFmE1qno1_uFxMhgEozl0H5-KIGQLBuh
//
//
//
//      print(token[i]);
//      print('IIII');
//      Map officialNotificationFormat =
//      {
//        "notification": bodyNotification,
//        "data": dataMap,
//        "priority": "high",
//        "to": token[i],
//      };
//
//
//      try{
//        print('try send notification');
//        responseNotification = http.post(
//          Uri.parse
//            ("https://fcm.googleapis.com/fcm/send"),
//          headers: headerNotification,
//          body: jsonEncode(officialNotificationFormat),
//        ).then((value) {
//          print('NOTIFICATION SENT ==$value');
//        });
//      }
//      catch(e){
//        print("NOTIFICATION ERROR===$e");
//      }
//    }
//
//    Get.offAll(const AdminView());
//    return   responseNotification;
//  }


 sendNotificationNow
     ({required List token,required String title
   ,required String body}) async

 {


   var responseNotification;
   Map<String, String> headerNotification =
   {
     'Content-Type': 'application/json',
     'Authorization':'key=AAAA91_AArE:APA91bGEiGL8ZWZfusMpn9b_V64nhLgz8ZuSLoVV-wQW8t1LUOSW7FCqYRT2q5EEGgA1wd2WBjbGWPc6ZxITAZ9H_nWLe9hkyKKFOmmMwYQF2RTW-2IkZ_b_2UK5KNzr-wCsOuBrX_4L'
   };
   Map bodyNotification =
   {
     "body":body,
     "title":title
   };

   Map dataMap =
   {
     "click_action": "FLUTTER_NOTIFICATION_CLICK",
     "id": "1",
     "status": "done",
     //   "rideRequestId": docId
   };




   for(int i=0;i<token.length;i++ ) {

     Map officialNotificationFormat =
     {
       "notification": bodyNotification,
       "data": dataMap,
       "priority": "high",
       "to": token[i],
     };


     try{
       print('try send notification2222');
       responseNotification = http.post(
         Uri.parse("https://fcm.googleapis.com/fcm/send"),
         headers: headerNotification,
         body: jsonEncode(officialNotificationFormat),
       ).then((value) {
         print('NOTIFICATION SENT ==$value');

       });
     }
     catch(e){
       print("NOTIFICATION ERROR===$e");
     }
   }



   return   responseNotification;

 }