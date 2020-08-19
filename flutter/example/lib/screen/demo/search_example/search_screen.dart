import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_remote_ui/flutter_remote_ui.dart' as rui;
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  static const routeName = "/demo/search";

  @override
  State<StatefulWidget> createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("search result"),
      ),
      body: buildBody(),
    );
  }

  String query;

  Future<List<dynamic>> fetchUI() async {
    final resp = await http.get("http://localhost:3001/search?query=$query");
    final jsonRaw = json.decode(resp.body);
    for (final r in jsonRaw) {
//      print(r);
    }
    return jsonRaw;
  }

  Widget buildRUI() {
    return FutureBuilder(
      builder: (c, s) {
        if (s.hasData) {
          print(s.data);
          return buildSearchResults(s.data);
        }
        if (s.hasError) {
          return Text("error: ${s.error}");
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
      future: fetchUI(),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            onChanged: (s) {
              setState(() {
                query = s;
              });
            },
          ),
          buildRUI()
        ],
      ),
    );
  }

  Widget buildSearchResults(data) {
    return ListView.builder(
      itemBuilder: (c, i) {
        var d = data[i];
        return SearchResultRow(
          icon:
              Icon(rui.RemoteIconData.fromUri("material://Icons.person").icon),
          title: Text(d["title"]["text"]),
          subtitle: Text(d["subtitle"]["text"]),
          onTap: () {
//            rui.RouteHandler.of(context).handle();
          },
        );
      },
      itemCount: data.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}

//@rui.LayoutConvert("search-result-row")
class SearchResultRow extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final Text title;
  final Text subtitle;
  final Widget meta;
  final Widget icon;
  final Function onTap;
  final List<Widget> tags;

  const SearchResultRow(
      {Key key,
      this.title,
      this.subtitle,
      this.icon,
      this.onTap,
      this.meta,
      this.margin,
      this.padding = const EdgeInsets.all(12),
      this.tags})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: padding,
        margin: margin,
        child: Row(
          children: [
            IconTheme(data: IconThemeData(color: Colors.grey), child: icon),
            SizedBox(
              width: 16,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _title(context),
                      if (meta != null) _meta(context)
                    ],
                  ),
                  _subtitle(context)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _title(BuildContext context) {
    return DefaultTextStyle(
        style: Theme.of(context).textTheme.subtitle1, child: title);
  }

  Widget _subtitle(BuildContext context) {
    return DefaultTextStyle(
        style: Theme.of(context).textTheme.overline, child: subtitle);
  }

  Widget _meta(BuildContext context) {
    return DefaultTextStyle(
        style:
            Theme.of(context).textTheme.overline.copyWith(color: Colors.grey),
        child: meta);
  }
}
