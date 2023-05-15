import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/index.dart';
import '../../providers/index.dart';
import '../../services/index.dart';
import '../../widgets/index.dart';

class UpcomingScreen extends StatefulWidget {
  static const routeName = '/upcoming';

  const UpcomingScreen({super.key});

  @override
  State<UpcomingScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  final ScrollController _scrollController = ScrollController();
  final int _perPage = 10;
  late List<BookingInfo> _upcoming = [];
  int _page = 1;
  bool _isLoadMore = false;
  bool _isLoading = true;
  Timer? _debounce;

  @override
  void initState() {
    _scrollController.addListener(_loadMore);
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _scrollController.removeListener(_loadMore);
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMore() {
    if (_scrollController.position.extentAfter < _page * _perPage) {
      setState(() {
        _isLoadMore = true;
      });
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 100), () {
        setState(() {
          _page++;
          _refreshUpcoming();
        });
      });
    }
  }

  Future _refreshUpcoming() async {
    try {
      final scheduleProvider = Provider.of<ScheduleProvider>(context, listen: false);
      await scheduleProvider.fetchAndSetUpcomingClass(page: _page, perPage: _perPage);
      final response = scheduleProvider.bookings;

      if (mounted) {
        setState(() {
          _upcoming.addAll(response);
          _upcoming = _upcoming.toSet().toList(); // remove duplicates
          _isLoading = false;
          _isLoadMore = false;
        });
      }
    } on HttpException catch (error) {
      await Analytics.crashEvent(
        '_refreshUpcomingHttpExceptionCatch',
        exception: error.toString(),
        fatal: true,
      );
    } catch (error) {
      await Analytics.crashEvent(
        '_refreshUpcomingCatch',
        exception: error.toString(),
        fatal: true,
      );
    }
  }

  void _onRemove(String id) {
    setState(() {
      _upcoming.removeWhere((element) => element.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    context.read<Analytics>().setTrackingScreen('UPCOMING_SCREEN');
    if (_isLoading) _refreshUpcoming();

    return Column(
      children: <Widget>[
        _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Expanded(
                child: RefreshIndicator(
                  onRefresh: () => _refreshUpcoming(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: _upcoming.isEmpty
                        ? const Center(
                            child: FreeContentWidget('No available bookings'),
                          )
                        : ListView.builder(
                            controller: _scrollController,
                            itemCount: _upcoming.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: Card(
                                  elevation: 5,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  child: BookingCardWidget(
                                    booking: _upcoming[index],
                                    onRemove: _onRemove,
                                  ),
                                ),
                              );
                            },
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
          )
      ],
    );
  }
}
