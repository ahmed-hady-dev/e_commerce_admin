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
                      const Text('Add an Image',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              const Text('Product Information',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
              buildTextFormField(hintText: 'Product ID'),
              buildTextFormField(hintText: 'Product Name'),
              buildTextFormField(hintText: 'Product Description'),
              buildTextFormField(hintText: 'Product Category'),
              const SizedBox(height: 10.0),
              _buildSlider(title: 'Price'),
              _buildSlider(title: 'Quantity'),
              const SizedBox(height: 10.0),
              _buildCheckbox(title: 'Recommended'),
              _buildCheckbox(title: 'Popular'),
              Center(
                  child: ElevatedButton(
                      onPressed: () {
                        print('save');
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      child: const Text('Save', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)))),
            ],
          )),
    );
  }

  Row _buildCheckbox({required String title}) {
    return Row(
      children: <Widget>[
        SizedBox(width: 125, child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
        Checkbox(
          value: true,
          checkColor: Colors.black,
          activeColor: Colors.black12,
          onChanged: (value) {},
        ),
      ],
    );
  }

  Row _buildSlider({required String title}) {
    return Row(
      children: [
        SizedBox(
          width: 75,
          child: Text(title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
        ),
        Expanded(
          child: Slider(
            value: 0,
            min: 0.0,
            max: 25,
            divisions: 10,
            activeColor: Colors.black,
            inactiveColor: Colors.black12,
            onChanged: (value) {},
          ),
        ),
      ],
    );
  }

  TextFormField buildTextFormField({required String hintText}) {
    return TextFormField(
      decoration: InputDecoration(hintText: hintText),
    );
  }
}
