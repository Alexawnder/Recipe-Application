import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../types/ingredient.dart';
import 'package:provider/provider.dart';
import '../providers/FridgeContentsProvider.dart';

class Fridge extends StatelessWidget {
 
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('My Fridge'),
            ), // AppBar
            body: Consumer<FridgeContentsProvider>(
                builder: (context, fridgeContentsProvider, child) {
                    Map<Ingredient, int> contents = fridgeContentsProvider.fridgeContents;
                    return ListView.builder(
                        itemCount: contents.length,
                        itemBuilder: (context, index) {
                            Ingredient fridgeItem = contents.keys.elementAt(index);
                            return Card(
                                margin: const EdgeInsets.all(8.0),
                                child: ListTile(
                                    leading: Image.network(fridgeItem.image,
                                        width:50, height: 50, fit: BoxFit.cover),
                                    title: Text(
                                        fridgeItem.name,
                                        style: GoogleFonts.dancingScript(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF7EA16B),
                                        ),
                                    ),
                                ),
                            );
                        }
                    );
                }
            )
        );
    }
}


