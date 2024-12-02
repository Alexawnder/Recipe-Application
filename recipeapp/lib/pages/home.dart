import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'RecipeSearchList.dart'; 
import 'Fridge.dart';
import 'RecipeSearchList.dart';
import '../components/NavBar.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  final List<Map<String, dynamic>> savedRecipes; // the shared saved recipes list
  final Function(int) onItemTapped; 

  const MyHomePage({
    super.key,
    required this.title,
    required this.savedRecipes,
    required this.onItemTapped,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller = TextEditingController();

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
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center all elements vertically
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Center all elements horizontally
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
                        controller: _controller,
                        onSubmitted: (query) {
                          if (query.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RecipeSearchList(
                                  query: query, // passes the search query to the search page
                                  savedRecipes: widget.savedRecipes, // and passes the saved recipes 
                                  onSave: (recipe) {
                                    setState(() {
                                      if (widget.savedRecipes.any(
                                          (saved) => saved['label'] == recipe['label'])) {
                                        widget.savedRecipes.removeWhere(
                                            (saved) => saved['label'] == recipe['label']);
                                      } else {
                                        widget.savedRecipes.add(recipe);
                                      }
                                    });
                                  },
                                ),
                              ),
                            );
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: 'Enter a recipe name',
                          labelStyle: const TextStyle(
                            color: Color.fromRGBO(128, 116, 113, 1),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: const OutlineInputBorder(
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
              ],
            );
          },
        ),
      ),
      
    );
  }
}
