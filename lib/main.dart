import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EspressoScreen(),
    );
  }
}

class EspressoScreen extends StatefulWidget {
  const EspressoScreen({super.key});

  @override
  State<EspressoScreen> createState() => _EspressoScreenState();
}

class _EspressoScreenState extends State<EspressoScreen> {
  String selectedChocolate = 'White Chocolate';
  String selectedSize = 'S';
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Main Image Section with Overlay
            Container(
              height: 413,
              child: Stack(
                children: [
                  // Background Image
                  Container(
                    margin: EdgeInsets.fromLTRB(13, 13, 13, 0),
                    height: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      image: DecorationImage(
                        image: AssetImage('assets/images/coffee_product.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Header Navigation
                  Positioned(
                    left: 24,
                    top: 49,
                    child: Row(
                      children: [
                        Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                            size: 16,
                          ),
                        ),
                        SizedBox(width: 259),
                        Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Product Information Overlay
                  Positioned(
                    left: 13,
                    top: 289,
                    child: Container(
                      width: 350,
                      height: 124,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.3),
                            Colors.black.withOpacity(0.3),
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Left side - Title and Rating
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Espresso',
                                      style: TextStyle(
                                        fontFamily: 'SF Pro Text',
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        height: 0.75,
                                      ),
                                    ),
                                    Text(
                                      'with chocolate',
                                      style: TextStyle(
                                        fontFamily: 'SF Pro Text',
                                        fontSize: 12,
                                        color: Colors.white.withOpacity(0.8),
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Color(0xFFD17842),
                                      size: 19,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      '4.8',
                                      style: TextStyle(
                                        fontFamily: 'SF Pro Text',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      '(6,098)',
                                      style: TextStyle(
                                        fontFamily: 'SF Pro Text',
                                        fontSize: 10,
                                        color: Colors.white.withOpacity(0.8),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // Right side - Coffee and Chocolate icons
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.local_cafe_outlined,
                                          color: Color(0xFFDDDDDD),
                                          size: 24,
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          'Coffee',
                                          style: TextStyle(
                                            fontFamily: 'SF Pro Text',
                                            fontSize: 12,
                                            color: Color(0xFFDDDDDD),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 30),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.water_drop_outlined,
                                          color: Color(0xFFDDDDDD),
                                          size: 24,
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          'Chocolate',
                                          style: TextStyle(
                                            fontFamily: 'SF Pro Text',
                                            fontSize: 12,
                                            color: Color(0xFFDDDDDD),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  'Medium Roasted',
                                  style: TextStyle(
                                    fontFamily: 'SF Pro Text',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Content Section
            Padding(
              padding: EdgeInsets.fromLTRB(23, 20, 23, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Description Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF444444),
                        ),
                      ),
                      SizedBox(height: 15),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12,
                            color: Color(0xFF444444),
                            height: 1.8,
                          ),
                          children: [
                            TextSpan(
                              text:
                                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vel tincidunt et ullamcorper eu, vivamus semper commodo............',
                            ),
                            TextSpan(
                              text: 'Read More',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF967259),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  // Choice of Chocolate Section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Choice of Chocolate',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF444444),
                        ),
                      ),
                      SizedBox(height: 15),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildChocolateChip('White Chocolate'),
                            SizedBox(width: 15),
                            _buildChocolateChip('Milk Chocolate'),
                            SizedBox(width: 15),
                            _buildChocolateChip('Dark Chocolate'),
                            SizedBox(width: 15),
                            _buildChocolateChip('Bittersweet Chocolate'),
                            SizedBox(width: 15),
                            _buildChocolateChip('Ruby Chocolate'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  // Size and Quantity Section
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Size Section
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Size',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF444444),
                              ),
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                _buildSizeButton('S'),
                                SizedBox(width: 20),
                                _buildSizeButton('M'),
                                SizedBox(width: 20),
                                _buildSizeButton('L'),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 54),
                      // Quantity Section
                      Column(
                        children: [
                          Text(
                            'Quantity',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF444444),
                            ),
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (quantity > 1) {
                                    setState(() {
                                      quantity--;
                                    });
                                  }
                                },
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF967259),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                              SizedBox(width: 26.4),
                              Text(
                                '$quantity',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF2F3548),
                                ),
                              ),
                              SizedBox(width: 26.4),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    quantity++;
                                  });
                                },
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF967259),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  // Price and Buy Now Section
                  Row(
                    children: [
                      // Price Section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Price',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              color: Color(0xFF777777),
                              height: 1.57,
                            ),
                          ),
                          SizedBox(height: 5),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '\$',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF967259),
                                  height: 0.92,
                                ),
                              ),
                              Text(
                                '4.20',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF444444),
                                  height: 0.92,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(width: 63),
                      // Buy Now Button
                      Expanded(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color(0xFF967259),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Center(
                            child: Text(
                              'Buy Now',
                              style: TextStyle(
                                fontFamily: 'SF Pro Text',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChocolateChip(String chocolate) {
    bool isSelected = selectedChocolate == chocolate;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedChocolate = chocolate;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF967259) : Colors.transparent,
          border: Border.all(color: Color(0xFF967259), width: 1),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(
          chocolate,
          style: TextStyle(
            fontFamily: 'SF Pro Text',
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Color(0xFF777777),
            height: 1.83,
          ),
        ),
      ),
    );
  }

  Widget _buildSizeButton(String size) {
    bool isSelected = selectedSize == size;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedSize = size;
        });
      },
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF967259) : Color(0xFFE8E8E8),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            size,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? Colors.white : Color(0xFF777777),
            ),
          ),
        ),
      ),
    );
  }
}
