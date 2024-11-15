import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

const appId = '630a63de';
const appKey = '2ebdde9075b8b570315e2734bd35f0ce';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> recipes = [];

  Future<void> fetchRecipes(String query) async {
    final url = Uri.parse(
        'https://api.edamam.com/search?q=$query&app_id=$appId&app_key=$appKey');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      setState(() {
        recipes = (data['hits'] as List)
            .map((hit) => hit['recipe'] as Map<String, dynamic>)
            .toList();
      });
    } else {
      print('Failed to fetch recipes: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFF9DEC9),
      body: Center(
        child: OrientationBuilder(
          builder: (context, orientation) {
            double logoSize = (orientation == Orientation.portrait)
                ? screenWidth * 0.4 // Portrait: 40% of screen width
                : screenHeight * 0.3;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center all elements vertically
              crossAxisAlignment: CrossAxisAlignment.center, // Center all elements horizontally
              children: [
                // Cook Logo Section
                Image.asset(
                  'assets/images/cookLogo.png',
                  width: logoSize,
                  height: logoSize,
                ),

                Padding(
                  padding: EdgeInsets.only(
                      top: (orientation == Orientation.portrait)
                          ? screenHeight * 0.02
                          : screenHeight * 0.02),
                  child: Text(
                    widget.title,
                    style: GoogleFonts.dancingScript(
                      fontSize: screenWidth * 0.075,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF7EA16B),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 1.0),
                  child: SizedBox(
                    width: screenWidth * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextField(
                        onSubmitted: fetchRecipes,
                        decoration: InputDecoration(
                          labelText: 'Enter a recipe name',
                          labelStyle: TextStyle(
                            color: Color(0xFF807471),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF807471),
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // List of recipes
                Expanded(
                  child: ListView.builder(
                    itemCount: recipes.length,
                    itemBuilder: (context, index) {
                      var recipe = recipes[index];
                      var label = recipe['label'];
                      var imageUrl = recipe['image'];
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: ListTile(
                          leading: Image.network(imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                          title: Text(
                            label,
                            style: GoogleFonts.dancingScript(
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF7EA16B),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
