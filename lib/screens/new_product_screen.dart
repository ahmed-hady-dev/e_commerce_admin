import 'package:e_commerce_admin/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class NewProductScreen extends StatelessWidget {
  NewProductScreen({Key? key}) : super(key: key);

  final ProductController productController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a Products'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 100,
                child: Card(
                  color: Colors.black,
                  margin: EdgeInsets.zero,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () async {
                            ImagePicker _picker = ImagePicker();
                            final XFile? _image = await _picker.pickImage(source: ImageSource.gallery);
                            if (_image == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('No Image was Selected', style: TextStyle()),
                                ),
                              );
                            }
                            if (_image == null) {}
                          },
                          icon: const Icon(Icons.add_circle, color: Colors.white)),
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
              buildTextFormField(
                hintText: 'Product ID',
                productController: productController,
                name: 'id',
              ),
              buildTextFormField(
                hintText: 'Product Name',
                productController: productController,
                name: 'name',
              ),
              buildTextFormField(
                hintText: 'Product Description',
                productController: productController,
                name: 'description',
              ),
              buildTextFormField(
                hintText: 'Product Category',
                productController: productController,
                name: 'category',
              ),
              const SizedBox(height: 10.0),
              _buildSlider(
                title: 'Price',
                name: 'price',
                productController: productController,
                controllerValue: productController.price,
              ),
              _buildSlider(
                title: 'Quantity',
                name: 'quantity',
                productController: productController,
                controllerValue: productController.quantity,
              ),
              const SizedBox(height: 10.0),
              _buildCheckbox(
                title: 'Recommended',
                name: 'isRecommended',
                productController: productController,
                controllerValue: productController.isRecommended,
              ),
              _buildCheckbox(
                title: 'Popular',
                name: 'isPopular',
                productController: productController,
                controllerValue: productController.isPopular,
              ),
              Center(
                  child: ElevatedButton(
                      onPressed: () {
                        print(productController.newProduct);
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      child: const Text('Save', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)))),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildCheckbox({
    required String title,
    required String name,
    required ProductController productController,
    bool? controllerValue,
  }) {
    return Row(
      children: <Widget>[
        SizedBox(width: 125, child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold))),
        Checkbox(
          value: (controllerValue == null) ? false : controllerValue,
          checkColor: Colors.black,
          activeColor: Colors.black12,
          onChanged: (value) {
            productController.newProduct.update(
              name,
              (_) => value,
              ifAbsent: () => value,
            );
          },
        ),
      ],
    );
  }

  Row _buildSlider({
    required String title,
    required String name,
    required ProductController productController,
    double? controllerValue,
  }) {
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
            value: (controllerValue == null) ? 0 : controllerValue,
            min: 0.0,
            max: 25,
            divisions: 10,
            activeColor: Colors.black,
            inactiveColor: Colors.black12,
            onChanged: (value) {
              productController.newProduct.update(
                name,
                (_) => value,
                ifAbsent: () => value,
              );
            },
          ),
        ),
      ],
    );
  }

  TextFormField buildTextFormField({
    required String hintText,
    required String name,
    required ProductController productController,
  }) {
    return TextFormField(
        decoration: InputDecoration(hintText: hintText),
        onChanged: (value) {
          productController.newProduct.update(
            name,
            (_) => value,
            ifAbsent: () => value,
          );
        });
  }
}
