import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttersamplestart/providers/movie_provider.dart';
import 'package:fluttersamplestart/view/widgets/tab_bar_widget.dart';



class SearchPage extends StatelessWidget {
final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Column(
              children: [
                Consumer(
                  builder: (context, ref, child) {
                    return TextFormField(
                      autofocus: true,
                      controller: searchController,
                      onFieldSubmitted: (val) {
                        if (val.isEmpty) {
                          showDialog(context: context, builder: (context) =>
                              AlertDialog(
                                content: Text('please provide searchText'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      }, child: Text('close'))
                                ],
                              ));
                        } else {
                          ref.read(movieSearchProvider.notifier).getMovieData(searchText: val);
                          searchController.clear();
                        }
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          hintText: 'Search Movie'
                      ),
                    );
                  }
                ),
                Expanded(child: TabBarWidget(true))
              ],
            ),
          ),
        )
    );
  }
}
