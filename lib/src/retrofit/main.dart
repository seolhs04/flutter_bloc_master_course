import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_master_course/utilities/rest_client.dart';

class RetroFit extends StatefulWidget {
  const RetroFit({super.key});

  @override
  State<RetroFit> createState() => _RetroFitState();
}

class _RetroFitState extends State<RetroFit> {
  late RestClient client;

  renderNewsCard({required News news}) {
    return Card(
      child: Column(
        children: [
          Text(news.id.toString()),
          Text(news.title),
          Text(news.url),
        ],
      ),
    );
  }

  @override
  void initState() {
    Dio dio = Dio();
    client = RestClient(dio);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: const [],
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final ids = snapshot.data!;
        return ListView.builder(
          itemBuilder: (context, index) {
            return FutureBuilder(
              future: client.getNewsDetail(id: ids[index]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return renderNewsCard(news: snapshot.data!);
              },
            );
          },
        );
      },
    );
  }
}
