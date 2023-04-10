import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../model/Nasa.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../responsive.dart';
import 'components/header.dart';

import 'components/storage_details.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<PostModel> _posts = []; // Lista para almacenar los posts obtenidos

  Future<void> _getPosts() async {
    // Realiza una petición HTTP para obtener los posts
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    if (response.statusCode == 200) {
      // Si la petición fue exitosa
      final List<dynamic> jsonList = jsonDecode(response.body);
      // Mapea los datos obtenidos a objetos PostModel
      final posts = jsonList.map((json) => PostModel.fromJson(json)).toList();

      setState(() {
        _posts = posts; // Actualiza la lista de posts en el estado
      });
    } else {
      throw Exception('Error al obtener los posts'); // Manejo de errores
    }
  }

  @override
  void initState() {
    super.initState();
    _getPosts(); // Llama a la función de obtención de posts en la inicialización
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Header(),
          SizedBox(height: defaultPadding),
          Expanded(
            flex: 5,
            child: ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                final post = _posts[index];
                return Stack(children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: FadeInImage(
                        fit: BoxFit.fill,
                        placeholder: const AssetImage('assets/loading.gif'),
                        image: NetworkImage(post.url),
                      ),
                    ),
                  ),
                  Positioned(
                      child: Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Text(post.id.toString()),
                      ),
                      Container(
                        child: Text(post.title),
                        padding: EdgeInsets.fromLTRB(50, 50, 0, 20),
                      ),
                    ],
                  ))
                ]);
              },
            ),
          ),
          if (!Responsive.isMobile(context)) SizedBox(width: defaultPadding),
          // On Mobile means if the screen is less than 850 we dont want to show it
          if (!Responsive.isMobile(context))
            Expanded(
              flex: 2,
              child: StarageDetails(),
            ),
        ],
      ),
    );
  }
}
