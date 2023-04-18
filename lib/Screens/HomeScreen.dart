import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../Models/ProductModel.dart';
import '../ProviderHelper/HomeProvider.dart';
import 'DetailsPage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  static const _pageSize = 10;
  bool _isLast = false;
  //The PagingController class is used to manage pagination and provide the items to be displayed in the PagedGridView
  final PagingController<int, Product> _pagingController =
      PagingController(firstPageKey: 1);

  reload() {
    Provider.of<HomeProvider>(context, listen: false).resetPage();
    _pagingController.refresh();
    setState(() {});
  }

  @override
  void initState() {
    Provider.of<HomeProvider>(context, listen: false).resetPage();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  /* The _fetchPage method is used to fetch the next page of items to be displayed in the grid.
   It calls the fetchHome method of the HomeProvider to get the items and then appends them to the PagingController using the appendPage method.
   If the last page of items has been reached, the appendLastPage method is called instead.*/
  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems =
          await Provider.of<HomeProvider>(context, listen: false).fetchHome();
      setState(() {
        _isLast = newItems.length < _pageSize;
      });
      if (_isLast) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Photos", style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red[900],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                // The onRefresh callback is used to refresh the data displayed in the grid when the user pulls down on the screen.
                  // The resetPage method of the HomeProvider is called to reset the current page to 1,
                  // and the refresh method of the PagingController is called to fetch the new data.
                    onRefresh: () {
                      Provider.of<HomeProvider>(context, listen: false)
                          .resetPage();
                      return Future.sync(() {
                        _pagingController.refresh();
                      });
                    },
                    child: PagedGridView<int, Product>(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.28,
                        crossAxisSpacing: 2.0,
                        mainAxisSpacing: 2.0,
                      ),
                      pagingController: _pagingController,
                      builderDelegate: PagedChildBuilderDelegate(
                        animateTransitions: true,
                        itemBuilder: (context, item, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ImageView(
                                        imgPath: item.url??'',
                                      )));
                            },
                            child: Card(
                              elevation: 1,
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                height: 120,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            item.thumbnailUrl ?? ""),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          );
                        },
                        firstPageProgressIndicatorBuilder: (context) =>
                            const Center(
                              child: CupertinoActivityIndicator(
                          color: Colors.red,
                          radius: 20,
                        ),
                            ),
                        //AppLoader(),
                        newPageProgressIndicatorBuilder: (context) =>
                            const Center(
                              child: CupertinoActivityIndicator(
                          radius: 20,
                          color: Colors.red,
                        ),
                            ),
                        noItemsFoundIndicatorBuilder: (context) =>
                            const Center(child: Text("No Data Found")),
                      ),

                    )),
              )
            ],
          ),
        ));
  }
}
