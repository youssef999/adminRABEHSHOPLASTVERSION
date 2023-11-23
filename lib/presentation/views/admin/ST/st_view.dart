


 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app/presentation/widgets/Custom_Text.dart';


class StView extends StatefulWidget {
  const StView({super.key});

  @override
  State<StView> createState() => _StViewState();
}

 List<Map<String, dynamic>> ordersList = [];
 List<Map<String, dynamic>>usersList = [];
 List<Map<String, dynamic>>productsList = [];
 List<Map<String, dynamic>>acceptedOrderList = [];
 List<Map<String, dynamic>>refusedOrderList = [];
 List<Map<String, dynamic>>moneyRequestList = [];


int numOfOrders=0;
int numOfUsers=0;
int numOfProducts=0;
int numOfAcceptedOrders=0;
int numOfRefusedOrders=0;
int numOfMoneyRequests=0;



class _StViewState extends State<StView> {

  Future<void> fetchNumOrders() async {

    print("MINNN");
    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('orders').get();

      try{
        List<Map<String, dynamic>> data

        = querySnapshot.docs.map((DocumentSnapshot doc) =>
        doc.data() as Map<String, dynamic>).toList();

        setState(() {
     ordersList = data;
        numOfOrders=ordersList.length;
        });

      }catch(e){
        print("E.......");
        print(e);
        print("E.......");
      }
    }
    catch (error) {
      print("Error fetching data: $error");
    }
  }


  Future<void> fetchAcceptedNumOrders() async {

    print("MINNN");
    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('orders')
          .where('status',isEqualTo:'confirm')
          .get();

      try{
        List<Map<String, dynamic>> data

        = querySnapshot.docs.map((DocumentSnapshot doc) =>
        doc.data() as Map<String, dynamic>).toList();

        setState(() {
         acceptedOrderList = data;
          numOfAcceptedOrders=acceptedOrderList.length;
        });

      }catch(e){
        print("E.......");
        print(e);
        print("E.......");
      }
    }
    catch (error) {
      print("Error fetching data: $error");
    }
  }

  Future<void> fetchrefusedNumOrders() async {

    print("MINNN");
    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('orders')
          .where('status',isEqualTo:'refuse')
          .get();

      try{
        List<Map<String, dynamic>> data

        = querySnapshot.docs.map((DocumentSnapshot doc) =>
        doc.data() as Map<String, dynamic>).toList();

        setState(() {
          refusedOrderList = data;
          numOfRefusedOrders=refusedOrderList.length;
        });

      }catch(e){
        print("E.......");
        print(e);
        print("E.......");
      }
    }
    catch (error) {
      print("Error fetching data: $error");
    }
  }


  Future<void> fetchNumProducts() async {

    print("MINNN");
    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('products')
          .get();

      try{
        List<Map<String, dynamic>> data

        = querySnapshot.docs.map((DocumentSnapshot doc) =>
        doc.data() as Map<String, dynamic>).toList();

        setState(() {
          productsList = data;
          numOfProducts=productsList.length;
        });

      }catch(e){
        print("E.......");
        print(e);
        print("E.......");
      }
    }
    catch (error) {
      print("Error fetching data: $error");
    }
  }

  Future<void> fetchNumUsers() async {

    print("MINNN");
    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('users').get();

      try{
        List<Map<String, dynamic>> data

        = querySnapshot.docs.map((DocumentSnapshot doc) =>
        doc.data() as Map<String, dynamic>).toList();

        setState(() {
     usersList= data;
          numOfUsers=usersList.length;
        });

      }catch(e){
        print("E.......");
        print(e);
        print("E.......");
      }
    }
    catch (error) {
      print("Error fetching data: $error");
    }
  }

  Future<void> fetchNumMoneyRequests() async {

    print("MINNN");
    try {
      QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('moneyRequest').get();

      try{
        List<Map<String, dynamic>> data

        = querySnapshot.docs.map((DocumentSnapshot doc) =>
        doc.data() as Map<String, dynamic>).toList();

        setState(() {
          moneyRequestList= data;
     numOfMoneyRequests=moneyRequestList.length;
        });

      }catch(e){
        print("E.......");
        print(e);
        print("E.......");
      }
    }
    catch (error) {
      print("Error fetching data: $error");
    }
  }

  @override
  void initState() {

    fetchNumUsers();
    fetchNumProducts();
    fetchNumMoneyRequests();
    fetchNumOrders();
    fetchAcceptedNumOrders();
    fetchrefusedNumOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar:AppBar(
        backgroundColor:Colors.black,
        leading:IconButton(
          icon:const Icon(Icons.arrow_back_ios,
          color:Colors.white,
          ),
          onPressed:(){
            Get.back();
          },
        ),
      ),
     body:Padding(
       padding: const EdgeInsets.all(8.0),
       child: ListView(
       children: [
         const SizedBox(height: 2,),
         SizedBox(
           height: 210,
           width: MediaQuery.of(context).size.width,
           child:Image.asset('assets/images/st.webp',
           fit:BoxFit.fill,
           ),
         ),
         const SizedBox(height: 36,),
         const Custom_Text(text: 'عدد المنتجات في المتجر الان',
         fontSize: 25,color:Colors.black,
           alignment:Alignment.center,
         ),
         const SizedBox(height: 11,),
         Custom_Text(text: numOfProducts.toString(),
         fontSize: 23,
           alignment:Alignment.center,
           color:Colors.blueAccent,
         ),


         const Custom_Text(text: 'عدد المستخدمين ',
           fontSize: 25,color:Colors.black,
           alignment:Alignment.center,
         ),
         const SizedBox(height: 11,),
         Custom_Text(text: numOfUsers.toString(),
           fontSize: 23,
           alignment:Alignment.center,
           color:Colors.blueAccent,
         ),



         const Custom_Text(text: 'عدد الطلبات علي المتجر',
           fontSize: 25,color:Colors.black,
           alignment:Alignment.center,
         ),
         const SizedBox(height: 11,),
          Custom_Text(text: numOfProducts.toString(),
           fontSize: 23,
           alignment:Alignment.center,
           color:Colors.blueAccent,
         ),

         const Custom_Text(text: 'عدد الطلبات  التي تمت الموافقة عليها',
           fontSize: 25,color:Colors.black,
           alignment:Alignment.center,
         ),
         const SizedBox(height: 11,),

          Custom_Text(text: numOfAcceptedOrders.toString(),
           fontSize: 23,
           alignment:Alignment.center,
           color:Colors.blueAccent,
         ),


         const Custom_Text(text: 'عدد الطلبات  التي تم رفضها ',
           fontSize: 23,color:Colors.black,
           alignment:Alignment.center,
         ),
         const SizedBox(height: 11,),
         Custom_Text(text: numOfRefusedOrders.toString(),
           fontSize: 23,
           alignment:Alignment.center,
           color:Colors.blueAccent,
         ),

         const Custom_Text(text: 'عدد طلبات سحب اموال داخل المتجر',
           fontSize: 23,color:Colors.black,
           alignment:Alignment.center,
         ),
         const SizedBox(height: 11,),
         Custom_Text(text: numOfMoneyRequests.toString(),
           fontSize: 23,
           alignment:Alignment.center,
           color:Colors.blueAccent,
         ),
       ],
       ),
     )
    );
  }
}
