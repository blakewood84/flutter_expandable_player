import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({ Key? key }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool showBottomNav = true;
  int _selectedIndex = 0;
  void _onItemTapped(int index) => setState(() => _selectedIndex = index);

  toggleBottomNav(bool state) {
    setState(() => showBottomNav = state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: IndexedStack(
                  index: _selectedIndex,
                  children: [
                    FirstScreen(),
                    SecondScreen(),
                  ]
                )
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: MusicBar(toggle: toggleBottomNav)
          )
        ],
      ),
      bottomNavigationBar: Container(
        height: showBottomNav ? 100 : 0,
        width: double.infinity,
          child: showBottomNav ? BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: ''
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: ''
            ),
          ],
        ) : null,
      )
    );
  }
}


class MusicBar extends StatefulWidget {
  final Function toggle;
  const MusicBar({ Key? key, required this.toggle }) : super(key: key);

  @override
  _MusicBarState createState() => _MusicBarState();
}

class _MusicBarState extends State<MusicBar> {
  bool open = false;
  bool shrunk = true;

  Future shrinkWidget() async {
    Future.delayed(Duration(seconds: 1)).then((res) {
      setState(() => shrunk = true);
    });
    
  }

  @override
  Widget build(BuildContext context) {
    final Size size  = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        this.widget.toggle(false);
        setState(() => open = true);
        setState(() => shrunk = false);
      },
      child: AnimatedContainer(
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        height: open ? size.height : 70,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blueGrey[600],
          border: Border.all(
            color: Colors.black,
            width: 1
          ),
        ),
        child: open ? Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.red,
                  width: 1
                ),
              ),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                  IconButton(
                    icon: Icon(Icons.arrow_downward),
                    onPressed: () {
                      this.widget.toggle(true);
                      shrinkWidget();
                      setState(() => open = false);
                    },
                  )
                ],
              ),
            )
        ) : 
        Visibility(
          visible: shrunk,
          child: Row(
            children: [
              Container(
                height: double.infinity,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.red,
                  border: Border.all(
                    color: Colors.red,
                    width: 1
                  ),
                ),
              ),
              SizedBox(width: 10),
              Text(
                'Song Title',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('First Screen Text Info')
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}