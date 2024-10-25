// To parse this JSON data, do
//
//     final productmodelapi = productmodelapiFromJson(jsonString);

import 'dart:convert';

Productmodelapi productmodelapiFromJson(String str) => Productmodelapi.fromJson(json.decode(str));



class Productmodelapi {
    List<Product> products;

    Productmodelapi({
        required this.products,
    });

    factory Productmodelapi.fromJson(Map<String, dynamic> json) => Productmodelapi(
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    );

   
}

class Product {
    int id;
    String title;
    
    double price;
   
    String thumbnail;

    Product({
        required this.id,
        required this.title,
        
        required this.price,
        
        required this.thumbnail,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
       
        price: json["price"]?.toDouble(),
       
        thumbnail: json["thumbnail"],
    );

}