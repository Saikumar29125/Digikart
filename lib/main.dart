import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    title: 'Digikart',
     debugShowCheckedModeBanner:false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: IntroductionScreen(),
    );
  }
}

class IntroductionScreen extends StatefulWidget {
  @override
  _IntroductionScreenState createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    _animation = Tween<double>(begin: 0.5, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToSignIn(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToSignIn(context),
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animation.value,
                    child: Text(
                      'DigiKart',
                      style: TextStyle(
                        fontSize: 45,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animation.value,
                    child: Icon(
                      Icons.shopping_cart,
                      size: 100,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _signIn(BuildContext context) {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isNotEmpty && password == 'password123') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid email or password. Please try again.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  void _loginAsGuest(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email or Phone',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _signIn(context),
                child: Text('Sign In'),
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateAccountPage()),
                  );
                },
                child: Text('Create an Account'),
              ),
              TextButton(
                onPressed: () => _loginAsGuest(context),
                child: Text('Login as Guest'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  void _createAccount(BuildContext context) {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (email.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        password == confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Account created successfully!'),
          duration: Duration(seconds: 3),
        ),
      );
      Navigator.pop(context); // Go back to SignInPage after creation
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter valid details.'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email or Phone',
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _confirmPasswordController,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _createAccount(context),
                child: Text('Create Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    HomePage(),
    OrdersPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false, // Disable back button
      child: Scaffold(
        appBar: AppBar(
          title: Text('Digikart'),
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ),
        drawer:Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: <Widget>[
      DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQx5c8-zDtJMdEw4zCdR8Rd0yHjpTXFjFpgi120WL3OAigFY9JucPUaY9EO_9mUQNEgt44&usqp=CAU'),
            ),
            
            SizedBox(height: 5),
            Text(
              'jack@gmail.com',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text('Settings'),
        onTap: () {
          Navigator.pop(context); // Close drawer
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SettingsPage()),
          );
        },
      ),
      ListTile(
        leading: Icon(Icons.mail),
        title: Text('Contact Us'),
        onTap: () {
          Navigator.pop(context); // Close drawer
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ContactUsPage()),
          );
        },
      ),
      ListTile(
        leading: Icon(Icons.logout),
        title: Text('Logout'),
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => IntroductionScreen()),
          );
        },
      ),
    ],
  ),
),




        body: _tabs[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: SwitchListTile(
          title: Text('Dark Mode'),
          value: _darkModeEnabled,
          onChanged: (value) {
            setState(() {
              _darkModeEnabled = value;
            });
          },
        ),
      ),
    );
  }
}

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                'https://cdn-icons-png.flaticon.com/512/4297/4297201.png',
              ),
            ),
            SizedBox(height: 20),
            Text(
              'DigiKart',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Contact Information:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Phone: 0866 67890',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Email: digiKartIndia@gmail.com',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'About Us:',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'At DigiKart, we specialize in selling a wide range of electronics and gadgets.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                // Open website
                Text('http://www.digiKartIndia.in');
              },
              child: Text(
                'Visit our website',
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrdersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'List of orders goes here.',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Map<String, dynamic>> products = [
    {'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlJT3lHArTqEq-RvaZKopsF_Z6we8rVdYoXw&s',
      'name': 'Victus Gaming Laptop 15',
      'price': 70000,
      'description': 'Powerful gaming laptop from HP.',
    },
    {
      'imageUrl':
          'https://www.reliancedigital.in/medias/Lenovo-IdeaPadSlim-LAptop-493838274-i-1-1200Wx1200H-300Wx300H?context=bWFzdGVyfGltYWdlc3wyNjg4NHxpbWFnZS9qcGVnfGltYWdlcy9oODYvaGMyLzEwMDYwMjIzMjgzMjMwLmpwZ3w1NTk1NTljZDU0YWJiM2FjMzZhMDYxNDc2Y2NkY2NlNTc3NDM2NGJmNWE1YjViMjgyMjRhMjkxY2EyNmFlMTdi',
      'name': 'Lenovo SlimPad3',
      'price': 50000,
      'description': 'Slim and lightweight laptop for everyday use.',
    },
    {
      'imageUrl':
          'https://in-media.apjonlinecdn.com/catalog/product/cache/b3b166914d87ce343d4dc5ec5117b502/c/0/c07991100_1_1.png',
      'name': 'HP Pavilion 15',
      'price': 60000,
      'description': 'Versatile laptop suitable for various tasks.',
    },
    {
      'imageUrl':
          'https://i.dell.com/is/image/DellContent/content/dam/ss2/product-images/dell-client-products/notebooks/g-series/g16-7630/media-gallery/black/notebook-g16-7630-nt-black-gallery-1.psd?fmt=png-alpha&pscan=auto&scl=1&hei=320&wid=427&qlt=100,1&resMode=sharp2&size=427,320&chrss=full',
      'name': 'Dell G16',
      'price': 80000,
      'description': 'High-performance gaming laptop from Dell.',
    },
    {
    'imageUrl':
          'https://i.gadgets360cdn.com/products/large/oneplus-nord-ce-3-lite-5g-DB-709x800-1680617419.jpg',
      'name': 'OnePlus Nord CE 3',
      'price': 18000,
    },
    {
      'imageUrl':
          'https://img.etimg.com/photo/msid-93779629,imgsize-43726/RedmiNote11Pro%2B5G.jpg',
      'name': 'Redmi Note 11Pro+ 5G',
      'price': 16000,
    },
    {
      'imageUrl':
          'https://rukminim2.flixcart.com/image/200/250/xif0q/mobile/c/k/9/g34-5g-pb1v0001in-motorola-original-imagwu4r4xze9jwz.jpeg?q=90&crop=false',
      'name': 'Moto G54',
      'price': 19000,
    },
    {
      'imageUrl':
          'https://5.imimg.com/data5/SELLER/Default/2023/2/JY/ZU/MM/153675560/xiaomi-mobile-phones-250x250.jpg',
      'name': 'Redmi 11 Lite',
      'price': 12000,
    },
    {
      'imageUrl':
          'https://in.pro.infinixmobility.com/media/catalog/product/cache/3fc35d798ea034524abc6812c3526e1f/x/6/x6851b_note40pro_5g_base1_2_1.png',
      'name': 'Infinix Note 40 Pro',
      'price': 25000,
    },
    {
      'imageUrl':
          'https://rukminim2.flixcart.com/image/850/1000/xif0q/mobile/g/f/i/galaxy-a15-5g-sm-a156ezbnins-samsung-original-imagwkgzv7vs8zd2.jpeg?q=90&crop=false',
      'name': 'Samsung Galaxy A15',
      'price': 19400,
    },
    {
      'imageUrl':
          'https://exstatic-in.iqoo.com/Oz84QB3Wo0uns8j1/1646199709016/849a70501e2e00abaeedcfabc6b2285a.png_w860-h860.webp',
      'name': 'iQOO 9 SE 5G',
      'price': 30000,
    },
    {
      'imageUrl':
          'https://www.lotmobiles.com/media/catalog/product/cache/882ea40e1a518d2f436622b2ec94acdf/b/l/blue_1_3_11.jpg',
      'name': 'Realme 12 Pro 5G',
      'price': 24000,
    },
    {
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlJT3lHArTqEq-RvaZKopsF_Z6we8rVdYoXw&s',
      'name': 'Victus Gaming Laptop 15',
      'price': 70000,
      'description': 'Powerful gaming laptop from HP.',
    },
    {
      'imageUrl':
          'https://www.reliancedigital.in/medias/Lenovo-IdeaPadSlim-LAptop-493838274-i-1-1200Wx1200H-300Wx300H?context=bWFzdGVyfGltYWdlc3wyNjg4NHxpbWFnZS9qcGVnfGltYWdlcy9oODYvaGMyLzEwMDYwMjIzMjgzMjMwLmpwZ3w1NTk1NTljZDU0YWJiM2FjMzZhMDYxNDc2Y2NkY2NlNTc3NDM2NGJmNWE1YjViMjgyMjRhMjkxY2EyNmFlMTdi',
      'name': 'Lenovo SlimPad3',
      'price': 50000,
      'description': 'Slim and lightweight laptop for everyday use.',
    },
    {
      'imageUrl':
          'https://in-media.apjonlinecdn.com/catalog/product/cache/b3b166914d87ce343d4dc5ec5117b502/c/0/c07991100_1_1.png',
      'name': 'HP Pavilion 15',
      'price': 60000,
      'description': 'Versatile laptop suitable for various tasks.',
    },
    {
      'imageUrl':
          'https://i.dell.com/is/image/DellContent/content/dam/ss2/product-images/dell-client-products/notebooks/g-series/g16-7630/media-gallery/black/notebook-g16-7630-nt-black-gallery-1.psd?fmt=png-alpha&pscan=auto&scl=1&hei=320&wid=427&qlt=100,1&resMode=sharp2&size=427,320&chrss=full',
      'name': 'Dell G16',
      'price': 80000,
      'description': 'High-performance gaming laptop from Dell.',
    },
    {
    'imageUrl':
          'https://i.gadgets360cdn.com/products/large/oneplus-nord-ce-3-lite-5g-DB-709x800-1680617419.jpg',
      'name': 'OnePlus Nord CE 3',
      'price': 18000,
    },
    {
      'imageUrl':
          'https://img.etimg.com/photo/msid-93779629,imgsize-43726/RedmiNote11Pro%2B5G.jpg',
      'name': 'Redmi Note 11Pro+ 5G',
      'price': 16000,
    },
    {
      'imageUrl':
          'https://rukminim2.flixcart.com/image/200/250/xif0q/mobile/c/k/9/g34-5g-pb1v0001in-motorola-original-imagwu4r4xze9jwz.jpeg?q=90&crop=false',
      'name': 'Moto G54',
      'price': 19000,
    },
    {
      'imageUrl':
          'https://5.imimg.com/data5/SELLER/Default/2023/2/JY/ZU/MM/153675560/xiaomi-mobile-phones-250x250.jpg',
      'name': 'Redmi 11 Lite',
      'price': 12000,
    },
    {
      'imageUrl':
          'https://in.pro.infinixmobility.com/media/catalog/product/cache/3fc35d798ea034524abc6812c3526e1f/x/6/x6851b_note40pro_5g_base1_2_1.png',
      'name': 'Infinix Note 40 Pro',
      'price': 25000,
    },
    {
      'imageUrl':
          'https://rukminim2.flixcart.com/image/850/1000/xif0q/mobile/g/f/i/galaxy-a15-5g-sm-a156ezbnins-samsung-original-imagwkgzv7vs8zd2.jpeg?q=90&crop=false',
      'name': 'Samsung Galaxy A15',
      'price': 19400,
    },
    {
      'imageUrl':
          'https://exstatic-in.iqoo.com/Oz84QB3Wo0uns8j1/1646199709016/849a70501e2e00abaeedcfabc6b2285a.png_w860-h860.webp',
      'name': 'iQOO 9 SE 5G',
      'price': 30000,
    },
    {
      'imageUrl':
          'https://www.lotmobiles.com/media/catalog/product/cache/882ea40e1a518d2f436622b2ec94acdf/b/l/blue_1_3_11.jpg',
      'name': 'Realme 12 Pro 5G',
      'price': 24000,
    } // Your list of products
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PRODUCTS'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle search functionality
              showSearch(context: context, delegate: ProductSearch(products));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return ProductGridItem(product: products[index]);
            },
          ),
        ),
      ),
    );
  }
}

class ProductSearch extends SearchDelegate<String> {
  final List<Map<String, dynamic>> products;

  ProductSearch(this.products);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Map<String, dynamic>> searchedProducts = products
        .where((product) =>
            product['name'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: searchedProducts.length,
      itemBuilder: (context, index) {
        return ProductListItem(product: searchedProducts[index]);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Map<String, dynamic>> searchedProducts = products
        .where((product) =>
            product['name'].toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: searchedProducts.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(searchedProducts[index]['name']),
          onTap: () {
            query = searchedProducts[index]['name'];
            showResults(context);
          },
        );
      },
    );
  }
}

class ProductGridItem extends StatelessWidget {
  final Map<String, dynamic> product;

  ProductGridItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Image.network(
              product['imageUrl'],
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  product['name'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  '\u20B9${product['price']}',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: () {
                    // Implement add to cart functionality
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Added to cart: ${product['name']}'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  },
                  child: Text('Add to Cart'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductListItem extends StatelessWidget {
  final Map<String, dynamic> product;

  ProductListItem({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.network(
          product['imageUrl'],
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
        title: Text(product['name']),
        subtitle: product['description'] != null
            ? Text(product['description'])
            : Text('No description available'),
        trailing: Text('\u20B9${product['price']}'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsPage(product: product),
            ),
          );
        },
      ),
    );
  }
}

class ProductDetailsPage extends StatelessWidget {
  final Map<String, dynamic> product;

  ProductDetailsPage({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.network(
              product['imageUrl'],
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              product['name'],
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              product['description'],
              style: TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              '\u20B9${product['price']}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}