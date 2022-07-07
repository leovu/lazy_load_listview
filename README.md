# lazy_load_listview

A new Flutter project.

## Example

    import 'package:flutter/material.dart';
    import 'package:lazy_load_listview/lazy_load_listview.dart';

    void main() {
      runApp(const MyApp());
    }

    class MyApp extends StatefulWidget {
      const MyApp({Key? key}) : super(key: key);

      @override
      State<MyApp> createState() => _MyAppState();
    }

    class _MyAppState extends State<MyApp> {
      List<int> _data = [1,2,3,4,5,6,7,8,9,10];
      bool isLastItem = false;
      @override
      void initState() {
        super.initState();
      }
      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: const Text('Plugin example app'),
            ),
            body: LazyLoadListview(
              length: _data.length,
              cellForRowAtIndex: (int index) {
                return cell(index);
              },
              onRefresh: () {
                _data = [1,2,3,4,5,6,7,8,9];
                isLastItem = false;
                setState(() {});
              },
              loadMoreItem: () async {
                int lastValue = _data[_data.length-1];
                for(int i=1;i<=10;i++) {
                  _data.add(lastValue+i);
                }
                lastValue = _data[_data.length-1];
                if(lastValue >= 200) {
                  isLastItem = true;
                }
                setState(() {});
              },
              isLastItem: isLastItem,
            ),
          ),
        );
      }

      Widget cell(int index) {
        return Center(child: Text('${_data[index]}'));
      }
    }
