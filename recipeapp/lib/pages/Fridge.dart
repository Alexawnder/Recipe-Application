import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'types/Ingredient.dart';
class Fridge extends StatelessWidget {

    List<Ingredient> fridgeContents;
    
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('My Fridge'),
            ), // AppBar
            body: ListView.builder(
                itemCount: fridgeContents.length,
                itemBuilder: (context, index) {
                    Ingredient fridgeItem = fridgeContents[index];
                    return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: ListTile(
                            leading: Image.network(fridgeItem

    }

}


