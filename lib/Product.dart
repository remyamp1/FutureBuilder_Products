import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:futurebuilder_products/Data_Model.dart';
import 'package:futurebuilder_products/details.dart';
import 'package:http/http.dart'as http;
class Api extends StatefulWidget {
  const Api({super.key});

  @override
  State<Api> createState() => _ApiState();
}

class _ApiState extends State<Api> {
late Future<Productmodelapi?> futureData;
  @override
  void initState(){
    super.initState();
     futureData = getData();
  }
  Future<Productmodelapi?> getData() async{
    try {
      String url="https://dummyjson.com/products";
      http.Response res=await http.get(Uri.parse(url));
      if(res.statusCode ==200){
        return Productmodelapi.fromJson(json.decode(res.body));
   
      }
      else{
        throw Exception('Failed to load data');
      }
  
    } catch (e) {
     debugPrint (e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API "),
        
      ),
      body: FutureBuilder<Productmodelapi?>(
        future: futureData,
       builder: (context,snapshot){
        if (snapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        } else if (snapshot.hasError){
          return Center(child: Text('Error:${snapshot.error}'));
        } else if (snapshot.hasData && snapshot.data !=null){
          final products=snapshot.data!.products;
        return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,),
     itemCount: products.length,
       itemBuilder: (context,index){
        final product =products[index];
        return GestureDetector(
          onTap: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>ApiDemo(
              product: product,
         
            )));
          },
          child: Container(
            height: 300,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black,
            width: 2),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 231, 223, 223),
                blurRadius: 0,
                spreadRadius: 1,
              )
            ]),
            margin: EdgeInsets.all(8.0),
            padding: EdgeInsets.all(8.0),
           child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                    
                Image.network(product.thumbnail,width: 100,height: 65,),
            
                
                Text(product.title,style: TextStyle(fontSize: 10),),
               

                Row(
                  children: [
                    SizedBox(width: 30),
                    Text("\$${product.price.toString()}"),
                    SizedBox(width: 5),
               
                   Icon(Icons.favorite,size: 15,)
              
                  ],
                )
              ]
            ),
          
      
        )
        );
      });
        }
        else {
          return Center(child: Text('No Data Available'),);
        }
  })
    );
  }
}