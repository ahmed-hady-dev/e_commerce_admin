import 'package:flutter/material.dart';

class NewProductScreen extends StatelessWidget {
  const NewProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a Products'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                  height: 100,
                  child: Card(
                    color: Colors.black,
                    margin: EdgeInsets.zero,
                    child: Row(
                      children: [
                        IconButton(onPressed: () {}, icon: const Icon(Icons.add_circle, color: Colors.white)),
                        Text('Add an Image',
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white))
                      ],
                    ),
                  ))
            ],
          )),
    );
  }
}
