import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/components/product_card.dart';
import 'package:whatsapp/models/product.dart';
import 'package:whatsapp/services/product_services.dart';

class ProductsScreen extends StatefulWidget {
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen>
    with AutomaticKeepAliveClientMixin {
  List<Product> _products = [];
  int _currentPage = 1;
  bool _viewStream = true;
  bool _isLoading = true;
  ScrollController _listScollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getProducts();
    _listScollController.addListener(() {
      double maxScroll = _listScollController.position.maxScrollExtent;
      double currentScroll = _listScollController.position.pixels;

      if (maxScroll - currentScroll <= 200) {
        if (!_isLoading) {
          _getProducts(page: _currentPage + 1);
        }
      }
    });
  }

  _getProducts({int page: 1, bool refresh: false}) async {
    setState(() {
      _isLoading = true;
    });
    var response = await ProductService.getProducts(page);
    setState(() {
      if (refresh) _products.clear();
      _products.addAll(response['products']);
      _currentPage = response['current_page'];
      _isLoading = false;
    });
  }

  Widget loadingView() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Future<Null> _handleRefresh() async {
    await _getProducts(refresh: true);
    return null;
  }

  Widget streamList() {
    return _products.length == 0 && _isLoading
        ? loadingView()
        : _products.length == 0
            ? listIsEmpty()
            : RefreshIndicator(
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 0),
                  itemCount: _products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ProductCard(product: _products[index]);
                  },
                ),
                onRefresh: _handleRefresh,
              );
  }

  Widget moduleListView() {
    return _products.length == 0 && _isLoading
        ? loadingView()
        : _products.length == 0
            ? listIsEmpty()
            : RefreshIndicator(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    padding: EdgeInsets.only(top: 0),
                    itemCount: _products.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ProductCard(product: _products[index]);
                    }),
                onRefresh: _handleRefresh,
              );
  }

  Widget headList() {
    return SliverAppBar(
      primary: false,
      pinned: true,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      actions: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _viewStream = true;
              });
            },
            child: Icon(
              Icons.view_stream,
              color: _viewStream ? Colors.grey[900] : Colors.grey[500],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: GestureDetector(
            onTap: () {
              setState(() {
                _viewStream = false;
              });
            },
            child: Icon(
              Icons.view_module,
              color: _viewStream ? Colors.grey[500] : Colors.grey[900],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        controller: _listScollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return _products.length != 0 ? <Widget>[headList()] : [];
        },
        body: _viewStream ? streamList() : moduleListView());
  }

  Widget listIsEmpty() {
    return Center(
      child: Text('محصولی برای نمایش وجود ندارد'),
    );
  }

  // برای اینکه state ما پس از ساختن زنده بماند و تغییر نکند از with AutomaticKeepAliveClientMixin استفاده میکنیم که متد زیر را باید override بکنیم ( باید برابر true بکنیم )
  @override
  bool get wantKeepAlive => true;
}
