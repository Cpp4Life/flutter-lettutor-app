import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/index.dart';
import '../../providers/index.dart';
import '../../services/index.dart';
import '../index.dart';

class EbookTabWidget extends StatefulWidget {
  final List<CourseCategory> categories;
  final Map<String, String> levels;
  final Language lang;

  const EbookTabWidget(this.categories, this.levels, this.lang, {super.key});

  @override
  State<EbookTabWidget> createState() => _EbookTabWidgetState();
}

class _EbookTabWidgetState extends State<EbookTabWidget> {
  final TextEditingController _ebookCtrl = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final int _perPage = 10;
  int _page = 1;
  String _selectedCategory = '';
  String _searchResult = '';
  List<Ebook> _ebooks = [];
  bool _isLoadMore = false;
  bool _isLoading = true;
  Timer? _debounce;

  @override
  void initState() {
    _scrollController.addListener(loadMore);
    super.initState();
  }

  @override
  void dispose() {
    _ebookCtrl.dispose();
    _scrollController.removeListener(loadMore);
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void onSelect(String id) {
    setState(() {
      _selectedCategory = (_selectedCategory == id ? '' : id);
      _page = 1;
      _ebooks = [];
      _isLoading = true;
    });
  }

  void handleSearch(String value) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _searchResult = value;
        _page = 1;
        _ebooks = [];
        _isLoading = true;
      });
    });
  }

  void loadMore() {
    if (_scrollController.position.extentAfter < _page * _perPage) {
      setState(() {
        _isLoadMore = true;
      });
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 100), () {
        _page++;
        fetchEbooks();
      });
    }
  }

  void fetchEbooks() async {
    try {
      final ebookProvider = Provider.of<EbookProvider>(context, listen: false);
      await ebookProvider.fetchAndSetEbooksWithPagination(
        page: _page,
        size: _perPage,
        q: _searchResult,
        categoryId: _selectedCategory,
      );
      final ebookResult = ebookProvider.ebooks;
      if (!mounted) return;

      setState(() {
        _ebooks.addAll(ebookResult);
        _ebooks = _ebooks.toSet().toList(); // remove duplicated
        _isLoadMore = false;
        _isLoading = false;
      });
    } on HttpException catch (error) {
      await Analytics.crashEvent(
        'fetchEbooksHttpExceptionCatch',
        exception: error.toString(),
        fatal: true,
      );
    } catch (error) {
      await Analytics.crashEvent(
        'fetchEbooksCatch',
        exception: error.toString(),
        fatal: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) fetchEbooks();

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 15),
          child: SearchBarWidget(
            title: widget.lang.ebookSearchHint,
            controller: _ebookCtrl,
            onChanged: handleSearch,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 15, bottom: 15),
          child: CourseCategoryChipWidget(widget.categories, _selectedCategory, onSelect),
        ),
        _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Expanded(
                child: _ebooks.isEmpty
                    ? const FreeContentWidget('No available ebooks')
                    : ListView.builder(
                        controller: _scrollController,
                        itemCount: _ebooks.length,
                        itemBuilder: (context, index) => Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          child: EbookItemWidget(
                            id: _ebooks[index].id,
                            name: _ebooks[index].name as String,
                            description: _ebooks[index].description as String,
                            imageUrl: _ebooks[index].imageUrl as String,
                            level: widget.levels[_ebooks[index].level] as String,
                            fileUrl: _ebooks[index].fileUrl as String,
                          ),
                        ),
                      ),
              ),
        if (_isLoadMore)
          const SizedBox(
            height: 48,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
