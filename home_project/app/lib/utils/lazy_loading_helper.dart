import 'package:flutter/material.dart';

class LazyLoadingList<T> extends StatefulWidget {
  final Future<List<T>> Function(int offset) fetchData;
  final Widget Function(BuildContext, T) itemBuilder;
  final int batchSize;

  const LazyLoadingList({
    Key? key,
    required this.fetchData,
    required this.itemBuilder,
    this.batchSize = 20,
  }) : super(key: key);

  @override
  _LazyLoadingListState<T> createState() => _LazyLoadingListState<T>();
}

class _LazyLoadingListState<T> extends State<LazyLoadingList<T>> {
  final ScrollController _scrollController = ScrollController();
  List<T> _items = [];
  bool _isFetching = false;
  bool _hasMoreData = true;

  @override
  void initState() {
    super.initState();
    _loadMoreData();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _loadMoreData() async {
    if (_isFetching || !_hasMoreData) return;

    setState(() {
      _isFetching = true;
    });

    List<T> newItems = await widget.fetchData(_items.length);
    if (newItems.length < widget.batchSize) {
      _hasMoreData = false;
    }

    setState(() {
      _items.addAll(newItems);
      _isFetching = false;
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _loadMoreData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _hasMoreData ? _items.length + 1 : _items.length,
      itemBuilder: (context, index) {
        if (index >= _items.length) {
          return Center(child: CircularProgressIndicator());
        }
        return widget.itemBuilder(context, _items[index]);
      },
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }
}