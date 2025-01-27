import 'package:exchange/data/home_data.dart';
import 'package:exchange/models/SingleProductModel.dart';
import 'package:exchange/widgets/singleProduct_widget.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController? _textEditingController = TextEditingController();
  List<SingleProductModel> ProductsDataOnSearch = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: buildAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: false,
            centerTitle: true,
            backgroundColor: Colors.deepPurple,
            title: Text('OLX'),
            actions: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
            ],
            bottom: AppBar(
              backgroundColor: Colors.deepPurple,
              title: Container(
                width: double.infinity,
                height: 40,
                color: Colors.white,
                child: Center(
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        ProductsDataOnSearch = ProductsData.where((element) => element.productName.toLowerCase().contains(value.toLowerCase())).toList();
                        print(ProductsDataOnSearch);
                        
                      });
                    },
                    controller: _textEditingController,
                    decoration: InputDecoration(
                        hintText: 'Search for something',
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: Icon(Icons.camera_alt)),
                  ),
                ),
              ),
            ),
          ),
          // Other Sliver Widgets
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                child: Center(
                  child: ListView.builder(
                    itemCount:_textEditingController!.text.isNotEmpty ? ProductsDataOnSearch.length: ProductsData.length,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var data = _textEditingController!.text.isNotEmpty ? ProductsDataOnSearch[index] : ProductsData[index];
                      return SingleProductWidget(
                        productImage: data.productImage,
                        productName: data.productName,
                        productPrice: data.productPrice,
                        onPressed: () {},
                      );
                    },
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
      
    );
  }
}
