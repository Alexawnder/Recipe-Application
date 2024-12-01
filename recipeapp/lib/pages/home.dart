import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'RecipeSearchList.dart'; 
import '../components/NavBar.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

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
                                builder: (context) => RecipeSearchList(query: query),
                              ),
                            );
                          }
                        },
                        decoration: const InputDecoration(
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
              ],
            );
          },
        ),
      ),
    );
  }
}

