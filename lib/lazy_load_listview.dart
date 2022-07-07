import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:pull_to_refresh/pull_to_refresh.dart';

typedef CellForRowAtIndex = Widget Function(int index);

class LazyLoadListview extends StatefulWidget {
  //TODO: Data length
  final int? length;
  //TODO: Widget build for per row
  final CellForRowAtIndex cellForRowAtIndex;
  //TODO: Check last Item for not load more
  final bool isLastItem;
  //TODO: Load more action
  final Function? loadMoreItem;
  //TODO: Refresh action
  final Function? onRefresh;
  //TODO: Load more indicator widget
  final Widget? loadMoreIndicator;
  //TODO: End load more announcement widget
  final Widget? endLoadingWidget;
  //TODO: Empty data widget
  final Widget? emptyWidget;
  //TODO: Padding for listview
  final EdgeInsetsGeometry? padding;
  //TODO: Physics for listview
  final ScrollPhysics? physics;
  //TODO: ShrinkWrap for listview
  final bool? shrinkWrap;
  //TODO: Separator Widget
  final Widget? separator;
  //TODO: Padding for seperator
  final double? separatorPadding;
  //TODO: Vertical for listview
  final bool? isVertical;
  //TODO: Text for refresh completed of pull to refersh widget
  final String? refreshCompleted;

  const LazyLoadListview(
      {Key? key,
        required this.length,
        required this.cellForRowAtIndex,
        this.loadMoreItem,
        this.loadMoreIndicator,
        this.onRefresh,
        this.endLoadingWidget,
        this.emptyWidget,
        this.padding,
        this.separatorPadding,
        this.physics,
        this.shrinkWrap,
        this.separator,
        this.isVertical=true,
        this.refreshCompleted,
        this.isLastItem = false})
      : super(key: key);
  @override
  State<LazyLoadListview> createState() => _State();
}

class _State extends State<LazyLoadListview>
    with SingleTickerProviderStateMixin {
  bool isLoadMore = false;
  final RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (widget.onRefresh != null) {
      await widget.onRefresh!();
    }
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (widget.onRefresh != null) {
      await widget.onRefresh!();
    }
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return (widget.length == null || widget.length == 0)
        ? widget.emptyWidget ?? Container()
        : SmartRefresher(
      enablePullDown: true,
      enablePullUp: false,
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      header: WaterDropHeader(
        complete: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.done,
              color: Colors.grey,
            ),
            Container(
              width: 15.0,
            ),
            Text(
              widget.refreshCompleted ?? "Refresh completed!",
              style: const TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
      child: ListView.separated(
          padding: widget.padding,
          physics: widget.physics,
          shrinkWrap: widget.shrinkWrap??false,
          scrollDirection: widget.isVertical == null ? Axis.vertical : widget.isVertical! ? Axis.vertical:Axis.horizontal,
          separatorBuilder: (_, index) => (widget.separator??Container(height: widget.separatorPadding??10.0,)),
          itemCount: widget.length! + 1,
          itemBuilder: (BuildContext context, int position) {
            if(position == 0) {
              loadMore();
            }
            else if (position >= (widget.length! * 0.6).round()) {
              loadMore();
            }
            if (position == widget.length!) {
              if (widget.isLastItem) {
                return widget.endLoadingWidget ??
                    const SizedBox(
                        height: 30.0,
                        child: Center(
                          child: Text(
                            "This is the last item",
                            style: TextStyle(color: Colors.black),
                          ),
                        ));
              } else {
                return widget.loadMoreIndicator ??
                    const SizedBox(
                      height: 30.0,
                      child: Center(
                        child: CupertinoActivityIndicator(
                          color: Colors.black,
                        ),
                      ),
                    );
              }
            }
            return widget.cellForRowAtIndex(position);
          }),
    );
  }
  void loadMore() async {
    if(!widget.isLastItem) {
      if (widget.loadMoreItem != null) {
        if(!isLoadMore) {
          await Future.delayed(const Duration(milliseconds: 200));
          isLoadMore = true;
          await widget.loadMoreItem!();
          isLoadMore = false;
        }
      }
    }
  }
}
