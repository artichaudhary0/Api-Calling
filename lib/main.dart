import 'package:flutter/material.dart';
import 'package:untitled9/api_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PostsApi(),
    );
  }
}

class PostsApi extends StatefulWidget {
  const PostsApi({super.key});

  @override
  State<PostsApi> createState() => _PostsApiState();
}

class _PostsApiState extends State<PostsApi> {
  final ApiServices apiServices = ApiServices(); // instance
  Future<List<dynamic>>? posts; // get data

  @override
  void initState() {
    super.initState();
    posts = apiServices.sajjanAndDev();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: posts, // data in future
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error : ${snapshot.error}"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No posts found"),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final post = snapshot.data![index];
                  return ListTile(
                    title: Text(post['title']),
                    subtitle: Text(post['body']),
                  );
                });
          }
        },
      ),
    );
  }
}
