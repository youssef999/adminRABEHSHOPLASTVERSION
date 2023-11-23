

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/presentation/resources/color_manager.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';

class OrdersView extends StatefulWidget {


  String status;

  OrdersView({Key? key, required this.status}) : super(key: key);

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {

  @override
  void initState() {
    print("ST==="+widget.status);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar:AppBar(
        leading:IconButton(
          icon:const Icon(Icons.arrow_back_ios,
            size: 26,
          ),
          onPressed:(){
            Get.back();
          },
        ),
        elevation: 0,
        toolbarHeight: 55,
        backgroundColor:ColorsManager.primary,
      ),
      body: ListView(
        children: [
          if(widget.status=='waiting')
          OrdersWidget()
          else if(widget.status=='del')
            DelordersWidget()
          else if(widget.status=='accept')
            OrdersApprovedWidget()
          else if(widget.status=='refuse')
              OrdersCanceledWidget()
        ],
      ),
    );


  }

  Widget OrdersWidget() {
    print("HERE");
     if(widget.status=='accept'){
      print("here accept");
      return Container(
        height: 7661100,
        color: ColorsManager.primary2,
        child: StreamBuilder(
            stream:
            FirebaseFirestore.instance.collection('orders')
                .where('status',isEqualTo: 'sent')
                .orderBy('date', descending: true)
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
                        String status='';
                        if(posts['status']=='refuse'){
                          status='ملغي';
                        }
                        else if(posts['status']=='accept'){
                          status='تم الموافقة علي الطلب';
                        }
                        else if(posts['status']=='sent'){
                          status='تم الارسال ';
                        }
                        else if(posts['status']=='del'){
                          status='تم التسليم ';
                        }

                        //
                        else if (posts['status']=='waiting'){
                          status='بانتظار الموافقة';
                        }
                        if (snapshot.data == null) {
                          return const CircularProgressIndicator();
                        }
                        List order = posts['order'];
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Card(
                            color: Colors.grey[100],
                            child: Column(
                              children: [
                                const SizedBox(height: 20,),
                                const Custom_Text(text: 'Order Id : ',
                                  fontSize: 18,color: Colors.black,
                                  alignment: Alignment.center,),
                                const SizedBox(height: 6,),
                                const SizedBox(height: 10,),
                                Column(
                                  children: [
                                    const Custom_Text(text: 'البريد الالكتروني ',
                                      fontSize: 18,
                                      alignment: Alignment.center,),
                                    Custom_Text(text: posts['user_email'],
                                        fontSize: 16,
                                        alignment: Alignment.center,
                                        color: Colors.grey),
                                    const SizedBox(height: 10,),
                                    const Custom_Text(text: 'الاسم  ',
                                      fontSize: 18,
                                      alignment: Alignment.center,),

                                    Custom_Text(text: posts['user_name'],
                                        fontSize: 16,
                                        alignment: Alignment.center,
                                        color: Colors.grey),
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                Column(
                                  children: [
                                    const Custom_Text(text: 'بيانات العنوان',
                                      fontSize: 28,
                                      alignment: Alignment.center,),
                                    const Custom_Text(text: 'العنوان',
                                      fontSize: 18,
                                      alignment: Alignment.center,),
                                    Custom_Text(text: posts['address'],
                                        fontSize: 16,
                                        alignment: Alignment.center,
                                        color: Colors.grey),
                                    const Custom_Text(text: 'نوع التوصيل',
                                      fontSize: 18,
                                      alignment: Alignment.center,),
                                    Custom_Text(text: posts['home'],
                                        fontSize: 16,
                                        alignment: Alignment.center,
                                        color: Colors.grey),
                                    const Custom_Text(text: 'الطابق ',
                                      fontSize: 18,
                                      alignment: Alignment.center,),
                                    Custom_Text(text: posts['floor'],
                                        fontSize: 18,
                                        alignment: Alignment.center,
                                        color: Colors.grey),
                                    const Custom_Text(text: 'الهاتف ',
                                      fontSize: 18,
                                      alignment: Alignment.center,),
                                    Custom_Text(text: posts['phone'],
                                        fontSize: 18,
                                        alignment: Alignment.center,
                                        color: Colors.grey),
                                  ],
                                ),
                                const Divider(thickness: 0.7, color: Colors
                                    .grey,),
                                (posts['date'] != null) ?
                                Column(
                                  children: [
                                    const SizedBox(height: 10,),
                                    Row(children: [
                                      const SizedBox(width: 11,),
                                      const Custom_Text(text: 'تاريخ الطلب',
                                        fontSize: 16,
                                        color: ColorsManager.primary,),
                                      const SizedBox(width: 11,),
                                      Custom_Text(text: posts['date'],
                                        fontSize: 16,
                                        color: Colors.grey,)
                                    ],),

                                    const SizedBox(height: 10,),
                                    Row(children: [
                                      const SizedBox(width: 11,),
                                      const Custom_Text(text: 'توقيت الطلب',
                                        fontSize: 16,
                                        color: ColorsManager.primary,),
                                      const SizedBox(width: 11,),
                                      Custom_Text(text: posts['time'],
                                        fontSize: 16,
                                        color: Colors.grey,)
                                    ],)
                                  ],
                                ) : const SizedBox(),
                                const SizedBox(height: 10,),
                                const Custom_Text(text: 'الطلب ',
                                  fontSize: 28,
                                  alignment: Alignment.center,),
                                for(int i = 0; i < order.length; i++)
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            height: 100,
                                            width: 80,
                                            child: Image.network(order[i]['image']),
                                          ),

                                          SizedBox(
                                            height: 110,
                                            width: 90,
                                            child: Image.network(order[i]['image']),
                                          ),
                                          const SizedBox(width: 11,),
                                          Custom_Text(text: order[i]['name'],
                                              fontSize: 18,
                                              alignment: Alignment.center),
                                          const SizedBox(width: 18,),

                                          Column(
                                            children: [
                                              const Custom_Text(text: 'السعر',
                                                  fontSize: 20,
                                                  alignment: Alignment.center),
                                              Custom_Text(text: order[i]['price'],
                                                  fontSize: 19,
                                                  alignment: Alignment.center),
                                            ],
                                          ),
                                          const SizedBox(width: 19,),
                                          Custom_Text(
                                              text: " X " + order[i]['quant'],
                                              fontSize: 21,
                                              alignment: Alignment.center),
                                        ],
                                      ),
                                      const Divider(
                                        thickness: 0.7, color: Colors.grey,)
                                    ],
                                  ),

                                const SizedBox(height: 10,),
                                Custom_Text(text: "الاجمالي = " + posts['total']+" "+posts['currency'],
                                  fontSize: 28,
                                  alignment: Alignment.center,),
                                const SizedBox(height: 10,),
                                Column(
                                  children: [
                                    const Custom_Text(
                                        text: 'حالة الطلب ',
                                        fontSize: 24,
                                        alignment: Alignment.center),


                                    Custom_Text(
                                        text: status,
                                        fontSize: 24,
                                        color:Colors.pink,
                                        alignment: Alignment.center),

                                    const SizedBox(height: 20,),
                                    InkWell(
                                      child: const Card(
                                        color:Colors.red,
                                        child:Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: Custom_Text(
                                            text: ' رفض ',
                                            fontSize: 21,
                                            alignment:Alignment.center,
                                            color:ColorsManager.primary2,
                                          ),
                                        ),
                                      ),
                                      onTap:(){
                                        EditOrderStatus(posts: posts, status: 'refuse');
                                      },
                                    )
                                  ],
                                ),

                              ],
                            ),),
                        );
                      });
              }
            }
        ),
      );
    }

    else if(widget.status=='refuse'){
      print("here refused");
      return Container(
        height: 7661100,
        color: ColorsManager.primary2,
        child: StreamBuilder(
            stream:
            FirebaseFirestore.instance.collection('orders')
                .where('status',isEqualTo: 'refuse')
                .orderBy('date', descending: true)
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
                        String status='';
                        if(posts['status']=='refuse'){
                          status='ملغي';
                        }
                        else if(posts['status']=='accept'){
                          status='تم الموافقة علي الطلب';
                        }
                        else if (posts['status']=='waiting'){
                          status='بانتظار الموافقة';
                        }
                        if (snapshot.data == null) {
                          return const CircularProgressIndicator();
                        }
                        if (snapshot.data == null) {
                          return const CircularProgressIndicator();
                        }
                        List order = posts['order'];
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Card(
                            color: Colors.grey[100],
                            child: Column(
                              children: [
                                const SizedBox(height: 20,),
                                const Custom_Text(text: 'Order Id : ',
                                  fontSize: 18,color: Colors.black,
                                  alignment: Alignment.center,),
                                const SizedBox(height: 6,),
                                const SizedBox(height: 10,),
                                Column(
                                  children: [
                                    const Custom_Text(text: 'البريد الالكتروني ',
                                      fontSize: 18,
                                      alignment: Alignment.center,),
                                    Custom_Text(text: posts['user_email'],
                                        fontSize: 16,
                                        alignment: Alignment.center,
                                        color: Colors.grey),
                                    const SizedBox(height: 10,),
                                    const Custom_Text(text: 'الاسم  ',
                                      fontSize: 18,
                                      alignment: Alignment.center,),
                                    Custom_Text(text: posts['user_name'],
                                        fontSize: 16,
                                        alignment: Alignment.center,
                                        color: Colors.grey),
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                Column(
                                  children: [
                                    const Custom_Text(text: 'بيانات العنوان',
                                      fontSize: 28,
                                      alignment: Alignment.center,),
                                    const Custom_Text(text: 'العنوان',
                                      fontSize: 18,
                                      alignment: Alignment.center,),
                                    Custom_Text(text: posts['address'],
                                        fontSize: 16,
                                        alignment: Alignment.center,
                                        color: Colors.grey),
                                    const Custom_Text(text: 'المبني ',
                                      fontSize: 18,
                                      alignment: Alignment.center,),
                                    Custom_Text(text: posts['home'],
                                        fontSize: 16,
                                        alignment: Alignment.center,
                                        color: Colors.grey),
                                    const Custom_Text(text: 'الطابق ',
                                      fontSize: 18,
                                      alignment: Alignment.center,),
                                    Custom_Text(text: posts['floor'],
                                        fontSize: 18,
                                        alignment: Alignment.center,
                                        color: Colors.grey),
                                    const Custom_Text(text: 'الهاتف ',
                                      fontSize: 18,
                                      alignment: Alignment.center,),
                                    Custom_Text(text: posts['phone'],
                                        fontSize: 18,
                                        alignment: Alignment.center,
                                        color: Colors.grey),
                                  ],
                                ),
                                const Divider(thickness: 0.7, color: Colors
                                    .grey,),
                                (posts['date'] != null) ?
                                Column(
                                  children: [
                                    const SizedBox(height: 10,),
                                    Row(children: [
                                      const SizedBox(width: 11,),
                                      const Custom_Text(text: 'تاريخ الطلب',
                                        fontSize: 16,
                                        color: ColorsManager.primary,),
                                      const SizedBox(width: 11,),
                                      Custom_Text(text: posts['date'],
                                        fontSize: 16,
                                        color: Colors.grey,)
                                    ],),

                                    const SizedBox(height: 10,),
                                    Row(children: [
                                      const SizedBox(width: 11,),
                                      const Custom_Text(text: 'توقيت الطلب',
                                        fontSize: 16,
                                        color: ColorsManager.primary,),
                                      const SizedBox(width: 11,),
                                      Custom_Text(text: posts['time'],
                                        fontSize: 16,
                                        color: Colors.grey,)
                                    ],)
                                  ],
                                ) : const SizedBox(),
                                const SizedBox(height: 10,),
                                const Custom_Text(text: 'الطلب ',
                                  fontSize: 28,
                                  alignment: Alignment.center,),
                                for(int i = 0; i < order.length; i++)
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          const SizedBox(width: 11,),
                                          SizedBox(
                                            height: 110,
                                            width: 80,
                                            child: Image.network(order[i]['image']),
                                          ),
                                          const SizedBox(width: 11,),
                                          Custom_Text(text: order[i]['name'],
                                              fontSize: 18,
                                              alignment: Alignment.center),
                                          const SizedBox(width: 16,),
                                          Column(
                                            children: [
                                              const Custom_Text(text: 'السعر',
                                                  fontSize: 17,
                                                  alignment: Alignment.center),
                                              Custom_Text(text: order[i]['price'],
                                                  fontSize: 19,
                                                  alignment: Alignment.center),
                                            ],
                                          ),
                                          const SizedBox(width: 16,),
                                          Custom_Text(
                                              text: " X " + order[i]['quant'],
                                              fontSize: 21,
                                              alignment: Alignment.center),
                                        ],
                                      ),
                                      const Divider(
                                        thickness: 0.7, color: Colors.grey,)
                                    ],
                                  ),

                                const SizedBox(height: 10,),
                                Custom_Text(text: "${"الاجمالي = " + posts['total']} "+posts['currency'],
                                  fontSize: 28,
                                  alignment: Alignment.center,),
                                const SizedBox(height: 10,),
                                Column(
                                  children: [
                                    const Custom_Text(
                                        text: 'حالة الطلب ',
                                        fontSize: 24,
                                        alignment: Alignment.center),


                                    Custom_Text(
                                        text: status,
                                        fontSize: 24,
                                        color:Colors.pink,
                                        alignment: Alignment.center),

                                    const SizedBox(height: 11,),
                                    InkWell(
                                      child: const Card(
                                        color:Colors.red,
                                        child:Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: Custom_Text(
                                            text: ' موافقة  ',
                                            fontSize: 21,
                                            alignment:Alignment.center,
                                            color:ColorsManager.primary2,
                                          ),
                                        ),
                                      ),
                                      onTap:(){
                                        EditOrderStatus(posts: posts, status: 'accept');
                                      },
                                    )
                                  ],
                                ),


                              ],
                            ),),
                        );
                      });
              }
            }
        ),
      );
    }

    else{
      return Container(
        height: 7961100,
        color: ColorsManager.primary2,
        child: StreamBuilder(
            stream:
            FirebaseFirestore.instance.collection('orders')
            .where('status',isEqualTo: 'waiting')
                .orderBy('date', descending: true)
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
                        String status='';
                        if(posts['status']=='refuse'){
                          status='ملغي';
                        }
                        else if(posts['status']=='confirm'){
                          status='تم الموافقة علي الطلب';
                        }
                        else if (posts['status']=='waiting'){
                          status='بانتظار الموافقة';
                        }
                        if (snapshot.data == null) {
                          return const CircularProgressIndicator();
                        }
                        List order = posts['order'];
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Card(
                            color: Colors.grey[100],
                            child: Column(
                              children: [
                                const SizedBox(height: 20,),
                                const Custom_Text(text: 'Order Id : ',
                                  fontSize: 18,color: Colors.black,
                                  alignment: Alignment.center,),
                                const SizedBox(height: 6,),
                                Custom_Text(text: posts['order_id'],
                                  fontSize: 18,color: Colors.black,
                                  alignment: Alignment.center,),
                                const SizedBox(height: 3),
                                const SizedBox(height: 10,),
                                Column(
                                  children: [
                                    const Custom_Text(text: 'البريد الالكتروني ',
                                      fontSize: 18,
                                      alignment: Alignment.center,),
                                    Custom_Text(text: posts['user_email'],
                                        fontSize: 16,
                                        alignment: Alignment.center,
                                        color: Colors.grey),
                                    const SizedBox(height: 10,),
                                    const Custom_Text(text: 'الاسم  ',
                                      fontSize: 18,
                                      alignment: Alignment.center,),
                                    Custom_Text(text: posts['user_name'],
                                        fontSize: 16,
                                        alignment: Alignment.center,
                                        color: Colors.grey),
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                Column(
                                  children: [
                                    const Custom_Text(text: 'بيانات العنوان',
                                      fontSize: 28,
                                      alignment: Alignment.center,),
                                    const Custom_Text(text: 'العنوان',
                                      fontSize: 18,
                                      alignment: Alignment.center,),
                                    Custom_Text(text: posts['address'],
                                        fontSize: 16,
                                        alignment: Alignment.center,
                                        color: Colors.grey),
                                    const Custom_Text(text: 'نوع التوصيل',
                                      fontSize: 18,
                                      alignment: Alignment.center,),
                                    Custom_Text(text: posts['home'],
                                        fontSize: 16,
                                        alignment: Alignment.center,
                                        color: Colors.grey),
                                    // const Custom_Text(text: 'الطابق ',
                                    //   fontSize: 18,
                                    //   alignment: Alignment.center,),
                                    // Custom_Text(text: posts['floor'],
                                    //     fontSize: 18,
                                    //     alignment: Alignment.center,
                                    //     color: Colors.grey),
                                    const Custom_Text(text: 'الهاتف ',
                                      fontSize: 18,
                                      alignment: Alignment.center,),
                                    Custom_Text(text: posts['phone'],
                                        fontSize: 18,
                                        alignment: Alignment.center,
                                        color: Colors.grey),
                                  ],
                                ),
                                const Divider(thickness: 0.7, color: Colors
                                    .grey,),
                                (posts['date'] != null) ?
                                Column(
                                  children: [
                                    const SizedBox(height: 10,),
                                    Row(children: [
                                      const SizedBox(width: 11,),
                                      const Custom_Text(text: 'تاريخ الطلب',
                                        fontSize: 16,
                                        color: ColorsManager.primary,),
                                      const SizedBox(width: 11,),
                                      Custom_Text(text: posts['date'],
                                        fontSize: 16,
                                        color: Colors.grey,)
                                    ],),

                                    const SizedBox(height: 10,),
                                    Row(children: [
                                      const SizedBox(width: 11,),
                                      const Custom_Text(text: 'توقيت الطلب',
                                        fontSize: 16,
                                        color: ColorsManager.primary,),
                                      const SizedBox(width: 11,),
                                      Custom_Text(text: posts['time'],
                                        fontSize: 16,
                                        color: Colors.grey,)
                                    ],)
                                  ],
                                ) : const SizedBox(),
                                const SizedBox(height: 10,),
                                const Custom_Text(text: 'الطلب ',
                                  fontSize: 28,
                                  alignment: Alignment.center,),
                                for(int i = 0; i < order.length; i++)
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            height: 110,
                                            width: 80,
                                            child: Image.network(order[i]['image']),
                                          ),
                                          SizedBox(
                                            width:125,
                                            child: Wrap(
                                                children:[
                                                  Center(
                                                    child: Text(
                                                        order[i]['name'].toString(),
                                                        maxLines:2,
                                                        style: GoogleFonts.tajawal(
                                                          color:ColorsManager.primary,fontSize: 13,fontWeight: FontWeight.bold,
                                                          textBaseline: TextBaseline.alphabetic,
                                                        )
                                                    ),
                                                  ),
                                                ]
                                            ),
                                          ),

                                          const SizedBox(width: 10,),
                                          Column(
                                            children: [
                                              const Custom_Text(text: 'السعر',
                                                  fontSize: 14,
                                                  alignment: Alignment.center),
                                              Custom_Text(text: order[i]['price'],
                                                  fontSize: 15,
                                                  alignment: Alignment.center),
                                            ],
                                          ),
                                          const SizedBox(width: 10,),
                                          Custom_Text(
                                              text: " X " + order[i]['quant'],
                                              fontSize: 15,
                                              alignment: Alignment.center),
                                        ],
                                      ),
                                      const Divider(
                                        thickness: 0.7, color: Colors.grey,)
                                    ],
                                  ),

                                const SizedBox(height: 10,),
                                Custom_Text(text: "${"الاجمالي = " + posts['total']} "+posts['currency'],
                                  fontSize: 28,
                                  alignment: Alignment.center,),
                                const SizedBox(height: 10,),
                                Column(
                                  children: [

                                    const Custom_Text(
                                        text: 'حالة الطلب ',
                                        fontSize: 24,
                                        alignment: Alignment.center),



                                    Custom_Text(
                                        text: status,
                                        fontSize: 24,
                                        color:Colors.pink,
                                        alignment: Alignment.center),
                                  ],
                                ),
                                const SizedBox(height: 11,),
                                Row(
                                  children:  [
                                    const SizedBox(width: 10,),
                                    InkWell(
                                      child:  const Card(
                                        color:Colors.blue,
                                        child:Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Custom_Text(
                                            text: 'تم الارسال ',
                                            fontSize: 21,
                                            alignment:Alignment.center,
                                            color:ColorsManager.primary2,
                                          ),
                                        ),
                                      ),
                                      onTap:(){
                                        EditOrderStatus(posts: posts, status: 'sent');
                                      },
                                    ),
                                    const SizedBox(width: 6,),
                                    InkWell(
                                      child:  const Card(
                                        color:Colors.blue,
                                        child:Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Custom_Text(
                                            text: 'تم التسليم  ',
                                            fontSize: 21,
                                            alignment:Alignment.center,
                                            color:ColorsManager.primary2,
                                          ),
                                        ),
                                      ),
                                      onTap:(){
                                        EditOrderStatus(posts: posts, status: 'del');
                                      },
                                    ),
                                    const SizedBox(width: 6,),
                                    InkWell(
                                      child:  const Card(
                                        color:Colors.red,
                                        child:Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Custom_Text(
                                            text: 'رفض ',
                                            fontSize: 21,
                                            alignment:Alignment.center,
                                            color:ColorsManager.primary2,
                                          ),
                                        ),
                                      ),
                                      onTap:(){
                                        EditOrderStatus(posts: posts, status: 'refuse');
                                      },
                                    ),

                                  ],
                                ),
                                const SizedBox(height: 12,),

                                (posts['status']!='waiting')?
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    child:  const Card(
                                      color:Colors.red,
                                      child:Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Custom_Text(
                                          text: 'حذف',
                                          fontSize: 21,
                                          alignment:Alignment.center,
                                          color:ColorsManager.primary2,
                                        ),
                                      ),
                                    ),
                                    onTap:(){
                                      DeleteDataInFireBase(posts: posts);
                                    },
                                  ),
                                ):const SizedBox(),

                                const SizedBox(height: 22,),


                              ],
                            ),),
                        );
                      });
              }
            }
        ),
      );
    }
  }


  Widget DelordersWidget(){
    return Container(
      height: 7961100,
      color: ColorsManager.primary2,
      child: StreamBuilder(
          stream:
          FirebaseFirestore.instance.collection('orders')
              .where('status',isEqualTo: 'del')
              .orderBy('date', descending: true)
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
                      String status='';
                      if(posts['status']=='refuse'){
                        status='ملغي';
                      }
                      else if(posts['status']=='sent'){
                        status='تم الارسال ';
                      }
                      else if(posts['status']=='del'){
                        status='تم التسليم ';
                      }
                      else if(posts['status']=='confirm'){
                        status='تم الموافقة علي الطلب';
                      }
                      else if (posts['status']=='waiting'){
                        status='بانتظار الموافقة';
                      }
                      if (snapshot.data == null) {
                        return const CircularProgressIndicator();
                      }
                      List order = posts['order'];
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Card(
                          color: Colors.grey[100],
                          child: Column(
                            children: [
                              const SizedBox(height: 20,),
                              const Custom_Text(text: 'Order Id : ',
                                fontSize: 18,color: Colors.black,
                                alignment: Alignment.center,),
                              const SizedBox(height: 6,),
                              Custom_Text(text: posts['order_id'],
                                fontSize: 18,color: Colors.black,
                                alignment: Alignment.center,),
                              const SizedBox(height: 3),
                              const SizedBox(height: 10,),
                              Column(
                                children: [
                                  const Custom_Text(text: 'البريد الالكتروني ',
                                    fontSize: 18,
                                    alignment: Alignment.center,),
                                  Custom_Text(text: posts['user_email'],
                                      fontSize: 16,
                                      alignment: Alignment.center,
                                      color: Colors.grey),
                                  const SizedBox(height: 10,),
                                  const Custom_Text(text: 'الاسم  ',
                                    fontSize: 18,
                                    alignment: Alignment.center,),
                                  Custom_Text(text: posts['user_name'],
                                      fontSize: 16,
                                      alignment: Alignment.center,
                                      color: Colors.grey),
                                ],
                              ),
                              const SizedBox(height: 10,),
                              Column(
                                children: [
                                  const Custom_Text(text: 'بيانات العنوان',
                                    fontSize: 28,
                                    alignment: Alignment.center,),
                                  const Custom_Text(text: 'العنوان',
                                    fontSize: 18,
                                    alignment: Alignment.center,),
                                  Custom_Text(text: posts['address'],
                                      fontSize: 16,
                                      alignment: Alignment.center,
                                      color: Colors.grey),
                                  const SizedBox(height: 5,),
                                  const Custom_Text(text: 'نوع التوصيل',
                                    fontSize: 18,
                                    alignment: Alignment.center,),
                                  Custom_Text(text: posts['home'],
                                      fontSize: 16,
                                      alignment: Alignment.center,
                                      color: Colors.grey),
                                  const Custom_Text(text: 'الهاتف ',
                                    fontSize: 18,
                                    alignment: Alignment.center,),
                                  Custom_Text(text: posts['phone'],
                                      fontSize: 18,
                                      alignment: Alignment.center,
                                      color: Colors.grey),
                                ],
                              ),
                              const Divider(thickness: 0.7, color: Colors
                                  .grey,),
                              (posts['date'] != null) ?
                              Column(
                                children: [
                                  const SizedBox(height: 10,),
                                  Row(children: [
                                    const SizedBox(width: 11,),
                                    const Custom_Text(text: 'تاريخ الطلب',
                                      fontSize: 16,
                                      color: ColorsManager.primary,),
                                    const SizedBox(width: 11,),
                                    Custom_Text(text: posts['date'],
                                      fontSize: 16,
                                      color: Colors.grey,)
                                  ],),

                                  const SizedBox(height: 10,),
                                  Row(children: [
                                    const SizedBox(width: 11,),
                                    const Custom_Text(text: 'توقيت الطلب',
                                      fontSize: 16,
                                      color: ColorsManager.primary,),
                                    const SizedBox(width: 11,),
                                    Custom_Text(text: posts['time'],
                                      fontSize: 16,
                                      color: Colors.grey,)
                                  ],)
                                ],
                              ) : const SizedBox(),
                              const SizedBox(height: 10,),
                              const Custom_Text(text: 'الطلب ',
                                fontSize: 28,
                                alignment: Alignment.center,),
                              for(int i = 0; i < order.length; i++)
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 100,
                                          width: 80,
                                          child: Image.network(order[i]['image']),
                                        ),
                                        SizedBox(
                                          width:125,
                                          child: Wrap(
                                              children:[
                                                Center(
                                                  child: Text(
                                                      order[i]['name'].toString(),
                                                      maxLines:2,
                                                      style: GoogleFonts.tajawal(
                                                        color:ColorsManager.primary,
                                                        fontSize: 14,fontWeight: FontWeight.bold,
                                                        textBaseline: TextBaseline.alphabetic,
                                                      )
                                                  ),
                                                ),
                                              ]
                                          ),
                                        ),

                                        const SizedBox(width: 6,),
                                        Column(
                                          children: [
                                            const Custom_Text(text: 'السعر',
                                                fontSize: 15,
                                                alignment: Alignment.center),
                                            Custom_Text(text: order[i]['price'],
                                                fontSize: 16,
                                                alignment: Alignment.center),
                                          ],
                                        ),
                                        const SizedBox(width: 7,),
                                        Custom_Text(
                                            text: " X " + order[i]['quant'],
                                            fontSize: 15,
                                            alignment: Alignment.center),
                                      ],
                                    ),
                                    const Divider(
                                      thickness: 0.7, color: Colors.grey,)
                                  ],
                                ),

                              const SizedBox(height: 10,),
                              Custom_Text(text: "${"الاجمالي = " + posts['total']} "+posts['currency'],
                                fontSize: 28,
                                alignment: Alignment.center,),
                              const SizedBox(height: 10,),
                              Column(
                                children: [

                                  const Custom_Text(
                                      text: 'حالة الطلب ',
                                      fontSize: 24,
                                      alignment: Alignment.center),



                                  Custom_Text(
                                      text: status,
                                      fontSize: 24,
                                      color:Colors.pink,
                                      alignment: Alignment.center),
                                ],
                              ),
                              const SizedBox(height: 11,),

                              (posts['status']!='waiting')?
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  child:  const Card(
                                    color:Colors.red,
                                    child:Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Custom_Text(
                                        text: 'حذف',
                                        fontSize: 21,
                                        alignment:Alignment.center,
                                        color:ColorsManager.primary2,
                                      ),
                                    ),
                                  ),
                                  onTap:(){
                                    DeleteDataInFireBase(posts: posts);
                                  },
                                ),
                              ):const SizedBox(),

                              const SizedBox(height: 22,),


                            ],
                          ),),
                      );
                    });
            }
          }
      ),
    );

  }

  Widget OrdersApprovedWidget(){
      return Container(
        height: 7961100,
        color: ColorsManager.primary2,
        child: StreamBuilder(
            stream:
            FirebaseFirestore.instance.collection('orders')
            .where('status',isEqualTo: 'sent')
                .orderBy('date', descending: true)
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
                        String status='';
                        if(posts['status']=='refuse'){
                          status='ملغي';
                        }
                        else if(posts['status']=='sent'){
                          status='تم الارسال ';
                        }
                        else if(posts['status']=='del'){
                          status='تم التسليم ';
                        }
                        else if(posts['status']=='confirm'){
                          status='تم الموافقة علي الطلب';
                        }
                        else if (posts['status']=='waiting'){
                          status='بانتظار الموافقة';
                        }
                        if (snapshot.data == null) {
                          return const CircularProgressIndicator();
                        }
                        List order = posts['order'];
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Card(
                            color: Colors.grey[100],
                            child: Column(
                              children: [
                                const SizedBox(height: 20,),
                                const Custom_Text(text: 'Order Id : ',
                                  fontSize: 18,color: Colors.black,
                                  alignment: Alignment.center,),
                                const SizedBox(height: 6,),
                                Custom_Text(text: posts['order_id'],
                                  fontSize: 18,color: Colors.black,
                                  alignment: Alignment.center,),
                                const SizedBox(height: 3),
                                const SizedBox(height: 10,),
                                Column(
                                  children: [
                                    const Custom_Text(text: 'البريد الالكتروني ',
                                      fontSize: 18,
                                      alignment: Alignment.center,),
                                    Custom_Text(text: posts['user_email'],
                                        fontSize: 16,
                                        alignment: Alignment.center,
                                        color: Colors.grey),
                                    const SizedBox(height: 10,),
                                    const Custom_Text(text: 'الاسم  ',
                                      fontSize: 18,
                                      alignment: Alignment.center,),
                                    Custom_Text(text: posts['user_name'],
                                        fontSize: 16,
                                        alignment: Alignment.center,
                                        color: Colors.grey),
                                  ],
                                ),
                                const SizedBox(height: 10,),
                                Column(
                                  children: [
                                    const Custom_Text(text: 'بيانات العنوان',
                                      fontSize: 28,
                                      alignment: Alignment.center,),
                                    const Custom_Text(text: 'العنوان',
                                      fontSize: 18,
                                      alignment: Alignment.center,),
                                    Custom_Text(text: posts['address'],
                                        fontSize: 16,
                                        alignment: Alignment.center,
                                        color: Colors.grey),
                                   const SizedBox(height: 5,),
                                    const Custom_Text(text: 'الهاتف ',
                                      fontSize: 18,
                                      alignment: Alignment.center,),
                                    Custom_Text(text: posts['phone'],
                                        fontSize: 18,
                                        alignment: Alignment.center,
                                        color: Colors.grey),
                                  ],
                                ),
                                const Divider(thickness: 0.7, color: Colors
                                    .grey,),
                                (posts['date'] != null) ?
                                Column(
                                  children: [
                                    const SizedBox(height: 10,),
                                    Row(children: [
                                      const SizedBox(width: 11,),
                                      const Custom_Text(text: 'تاريخ الطلب',
                                        fontSize: 16,
                                        color: ColorsManager.primary,),
                                      const SizedBox(width: 11,),
                                      Custom_Text(text: posts['date'],
                                        fontSize: 16,
                                        color: Colors.grey,)
                                    ],),

                                    const SizedBox(height: 10,),
                                    Row(children: [
                                      const SizedBox(width: 11,),
                                      const Custom_Text(text: 'توقيت الطلب',
                                        fontSize: 16,
                                        color: ColorsManager.primary,),
                                      const SizedBox(width: 11,),
                                      Custom_Text(text: posts['time'],
                                        fontSize: 16,
                                        color: Colors.grey,)
                                    ],)
                                  ],
                                ) : const SizedBox(),
                                const SizedBox(height: 10,),
                                const Custom_Text(text: 'الطلب ',
                                  fontSize: 28,
                                  alignment: Alignment.center,),
                                for(int i = 0; i < order.length; i++)
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          const SizedBox(width: 5,),
                                          SizedBox(
                                            width:150,
                                            child: Wrap(
                                                children:[
                                                  Center(
                                                    child: Text(
                                                        order[i]['name'].toString(),
                                                        maxLines:2,
                                                        style: GoogleFonts.tajawal(
                                                          color:ColorsManager.primary,fontSize: 15,fontWeight: FontWeight.bold,
                                                          textBaseline: TextBaseline.alphabetic,
                                                        )
                                                    ),
                                                  ),
                                                ]
                                            ),
                                          ),

                                          const SizedBox(width: 10,),
                                          Column(
                                            children: [
                                              const Custom_Text(text: 'السعر',
                                                  fontSize: 17,
                                                  alignment: Alignment.center),
                                              Custom_Text(text: order[i]['price'],
                                                  fontSize: 16,
                                                  alignment: Alignment.center),
                                            ],
                                          ),
                                          const SizedBox(width: 10,),
                                          Custom_Text(
                                              text: " X " + order[i]['quant'],
                                              fontSize: 16,
                                              alignment: Alignment.center),
                                        ],
                                      ),
                                      const Divider(
                                        thickness: 0.7, color: Colors.grey,)
                                    ],
                                  ),

                                const SizedBox(height: 10,),
                                Custom_Text(text: "${"الاجمالي = " + posts['total']} "+posts['currency'],
                                  fontSize: 28,
                                  alignment: Alignment.center,),
                                const SizedBox(height: 10,),
                                Column(
                                  children: [

                                    const Custom_Text(
                                        text: 'حالة الطلب ',
                                        fontSize: 24,
                                        alignment: Alignment.center),



                                    Custom_Text(
                                        text: status,
                                        fontSize: 24,
                                        color:Colors.pink,
                                        alignment: Alignment.center),
                                  ],
                                ),
                                const SizedBox(height: 11,),
                                Row(
                                  children:  [
                                  //xxx
                                    const SizedBox(width: 33,),
                                    InkWell(
                                      child:  const Card(
                                        color:Colors.blue,
                                        child:Padding(
                                          padding: EdgeInsets.all(2.0),
                                          child: Custom_Text(
                                            text: 'تم التسليم  ',
                                            fontSize: 21,
                                            alignment:Alignment.center,
                                            color:ColorsManager.primary2,
                                          ),
                                        ),
                                      ),
                                      onTap:(){
                                        EditOrderStatus(posts: posts, status: 'del');
                                      },
                                    ),
                                    const SizedBox(width: 6,),
                                    InkWell(
                                      child:  const Card(
                                        color:Colors.red,
                                        child:Padding(
                                          padding: EdgeInsets.all(12.0),
                                          child: Custom_Text(
                                            text: 'رفض ',
                                            fontSize: 21,
                                            alignment:Alignment.center,
                                            color:ColorsManager.primary2,
                                          ),
                                        ),
                                      ),
                                      onTap:(){
                                        EditOrderStatus(posts: posts, status: 'refuse');
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12,),

                                (posts['status']!='waiting')?
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    child:  const Card(
                                      color:Colors.red,
                                      child:Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Custom_Text(
                                          text: 'حذف',
                                          fontSize: 21,
                                          alignment:Alignment.center,
                                          color:ColorsManager.primary2,
                                        ),
                                      ),
                                    ),
                                    onTap:(){
                                      DeleteDataInFireBase(posts: posts);
                                    },
                                  ),
                                ):const SizedBox(),

                                const SizedBox(height: 22,),


                              ],
                            ),),
                        );
                      });
              }
            }
        ),
      );

  }

  Widget OrdersCanceledWidget() {
    return Container(
      height: 7961100,
      color: ColorsManager.primary2,
      child: StreamBuilder(
          stream:
          FirebaseFirestore.instance.collection('orders')
              .where('status',isEqualTo: 'refuse')
              .orderBy('date', descending: true)
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
                      String status='';
                      if(posts['status']=='refuse'){
                        status='ملغي';
                      }
                      else if(posts['status']=='confirm'){
                        status='تم الموافقة علي الطلب';
                      }
                      else if (posts['status']=='waiting'){
                        status='بانتظار الموافقة';
                      }
                      if (snapshot.data == null) {
                        return const CircularProgressIndicator();
                      }
                      List order = posts['order'];
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Card(
                          color: Colors.grey[100],
                          child: Column(
                            children: [
                              const SizedBox(height: 20,),
                              const Custom_Text(text: 'Order Id : ',
                                fontSize: 18,color: Colors.black,
                                alignment: Alignment.center,),
                              const SizedBox(height: 6,),
                              Custom_Text(text: posts['order_id'],
                                fontSize: 18,color: Colors.black,
                                alignment: Alignment.center,),
                              const SizedBox(height: 3),
                              const SizedBox(height: 10,),
                              Column(
                                children: [
                                  const Custom_Text(text: 'البريد الالكتروني ',
                                    fontSize: 18,
                                    alignment: Alignment.center,),
                                  Custom_Text(text: posts['user_email'],
                                      fontSize: 16,
                                      alignment: Alignment.center,
                                      color: Colors.grey),
                                  const SizedBox(height: 10,),
                                  const Custom_Text(text: 'الاسم  ',
                                    fontSize: 18,
                                    alignment: Alignment.center,),
                                  Custom_Text(text: posts['user_name'],
                                      fontSize: 16,
                                      alignment: Alignment.center,
                                      color: Colors.grey),
                                ],
                              ),
                              const SizedBox(height: 10,),
                              Column(
                                children: [
                                  const Custom_Text(text: 'بيانات العنوان',
                                    fontSize: 28,
                                    alignment: Alignment.center,),
                                  const Custom_Text(text: 'العنوان',
                                    fontSize: 18,
                                    alignment: Alignment.center,),
                                  Custom_Text(text: posts['address'],
                                      fontSize: 16,
                                      alignment: Alignment.center,
                                      color: Colors.grey),
                                  const Custom_Text(text: 'نوع التوصيل',
                                    fontSize: 18,
                                    alignment: Alignment.center,),
                                  Custom_Text(text: posts['home'],
                                      fontSize: 16,
                                      alignment: Alignment.center,
                                      color: Colors.grey),

                                  const Custom_Text(text: 'الهاتف ',
                                    fontSize: 18,
                                    alignment: Alignment.center,),
                                  Custom_Text(text: posts['phone'],
                                      fontSize: 18,
                                      alignment: Alignment.center,
                                      color: Colors.grey),
                                ],
                              ),
                              const Divider(thickness: 0.7, color: Colors
                                  .grey,),
                              (posts['date'] != null) ?
                              Column(
                                children: [
                                  const SizedBox(height: 10,),
                                  Row(children: [
                                    const SizedBox(width: 11,),
                                    const Custom_Text(text: 'تاريخ الطلب',
                                      fontSize: 16,
                                      color: ColorsManager.primary,),
                                    const SizedBox(width: 11,),
                                    Custom_Text(text: posts['date'],
                                      fontSize: 16,
                                      color: Colors.grey,)
                                  ],),

                                  const SizedBox(height: 10,),
                                  Row(children: [
                                    const SizedBox(width: 11,),
                                    const Custom_Text(text: 'توقيت الطلب',
                                      fontSize: 16,
                                      color: ColorsManager.primary,),
                                    const SizedBox(width: 11,),
                                    Custom_Text(text: posts['time'],
                                      fontSize: 16,
                                      color: Colors.grey,)
                                  ],)
                                ],
                              ) : const SizedBox(),
                              const SizedBox(height: 10,),
                              const Custom_Text(text: 'الطلب ',
                                fontSize: 28,
                                alignment: Alignment.center,),
                              for(int i = 0; i < order.length; i++)
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          height: 100,
                                          width: 80,
                                          child: Image.network(order[i]['image']),
                                        ),
                                        SizedBox(
                                          width:125,
                                          child: Wrap(
                                              children:[
                                                Center(
                                                  child: Text(
                                                      order[i]['name'].toString(),
                                                      maxLines:2,
                                                      style: GoogleFonts.tajawal(
                                                        color:ColorsManager.primary,
                                                        fontSize: 14,fontWeight: FontWeight.bold,
                                                        textBaseline: TextBaseline.alphabetic,
                                                      )
                                                  ),
                                                ),
                                              ]
                                          ),
                                        ),

                                        const SizedBox(width: 6,),
                                        Column(
                                          children: [
                                            const Custom_Text(text: 'السعر',
                                                fontSize: 16,
                                                alignment: Alignment.center),
                                            Custom_Text(text: order[i]['price'],
                                                fontSize: 16,
                                                alignment: Alignment.center),
                                          ],
                                        ),
                                        const SizedBox(width: 7,),
                                        Custom_Text(
                                            text: " X " + order[i]['quant'],
                                            fontSize: 16,
                                            alignment: Alignment.center),
                                      ],
                                    ),
                                    const Divider(
                                      thickness: 0.7, color: Colors.grey,)
                                  ],
                                ),

                              const SizedBox(height: 10,),
                              Custom_Text(text: "${"الاجمالي = " + posts['total']} "+posts['currency'],
                                fontSize: 28,
                                alignment: Alignment.center,),
                              const SizedBox(height: 10,),
                              Column(
                                children: [

                                  const Custom_Text(
                                      text: 'حالة الطلب ',
                                      fontSize: 24,
                                      alignment: Alignment.center),



                                  Custom_Text(
                                      text: status,
                                      fontSize: 24,
                                      color:Colors.pink,
                                      alignment: Alignment.center),
                                ],
                              ),
                              const SizedBox(height: 11,),
                              Row(
                                children:  [
                                  const SizedBox(width: 44,),

                                  const SizedBox(width: 32,),
                                  InkWell(
                                    child:  const Card(
                                      color:Colors.blue,
                                      child:Padding(
                                        padding: EdgeInsets.all(12.0),
                                        child: Custom_Text(
                                          text: 'موافقة ',
                                          fontSize: 21,
                                          alignment:Alignment.center,
                                          color:ColorsManager.primary2,
                                        ),
                                      ),
                                    ),
                                    onTap:(){
                                      EditOrderStatus(posts: posts, status: 'confirm');
                                    },
                                  ),

                                ],
                              ),
                              const SizedBox(height: 12,),

                              (posts['status']!='waiting')?
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  child:  const Card(
                                    color:Colors.red,
                                    child:Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Custom_Text(
                                        text: 'حذف',
                                        fontSize: 21,
                                        alignment:Alignment.center,
                                        color:ColorsManager.primary2,
                                      ),
                                    ),
                                  ),
                                  onTap:(){
                                    DeleteDataInFireBase(posts: posts);
                                  },
                                ),
                              ):const SizedBox(),

                              const SizedBox(height: 22,),


                            ],
                          ),),
                      );
                    });
            }
          }
      ),
    );

  }
}


DeleteDataInFireBase ({required DocumentSnapshot posts})async{

  final CollectionReference _updates =
  FirebaseFirestore.instance.collection('orders');
  await _updates
      .where('order_id', isEqualTo: posts['order_id'])
      .get().then((snapshot) {
    snapshot.docs.last.reference.delete()
        .then((value) {
      print("DELETED");

    });
  });

}

EditOrderStatus ({
  required DocumentSnapshot posts,required String status})async{
  final CollectionReference _updates =
  FirebaseFirestore.instance.collection('orders');
  await _updates
      .where('order_id', isEqualTo: posts['order_id'])
      .get().then((snapshot) {
    snapshot.docs.last.reference.update({
      'status':status,
      // 'rate': 0.0,
    }).then((value) {
      //  appMessage(text: 'تم تعديل الحالة بنجاح ');
      // Get.offAll(const AdminView());
      print("EDITED");
    });
  });
}