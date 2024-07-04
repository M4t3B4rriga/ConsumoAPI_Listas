import 'dart:convert' as convert;
import 'package:consumo_apy/Pages/Models/Gif.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:consumo_apy/Pages/Models/Gif.dart';

class GifsPage extends StatefulWidget {
  const GifsPage({super.key});

  @override
  State<GifsPage> createState() => _GifsPageState();
}

class _GifsPageState extends State<GifsPage> {
  Future<List<Gif>> getGifs() async {
    var url =
        "https://api.giphy.com/v1/gifs/trending?api_key=MHN8WXCWvxMY0brXoVXsTX2GZ8480Idg&limit=10&offset=0&rating=g&bundle=messaging_non_clips";
    var response = await http.get(Uri.parse(url));

    const successfulRequest = 200;

    if (response.statusCode == successfulRequest) {
      var jsonResponse =
          convert.jsonDecode(response.body) as Map<String, dynamic>;

      List<dynamic> gifs = jsonResponse["data"];

      List<Gif> gifsMapped = List.empty(growable: true);
      for (var gif in gifs) {
        gifsMapped.add(
            Gif(name: gif["title"], url: gif["images"]["original"]["url"]));
      }

      return gifsMapped;
    } else {
      throw Exception("Error al cargar los GIFs");
    }
  }

  List<Gif> gifs = [];

  @override
  void initState() {
    super.initState();
    getGifs().then((response) {
      setState(() {
        gifs = response;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GIFs ListView"),
      ),
      body: ListView.builder(
        itemCount: gifs.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(gifs[index].name),
            leading: Image.network(gifs[index].url),
          );
        },
      ),
    );
  }
}
