import 'package:flutter/material.dart';
import 'package:radio_browser_flutter/radio_browser_flutter.dart';

void main() async {
  await RadioBrowserClient.initialize("");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ).copyWith(
          secondary: Colors.pink,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: RadioBrowserClient.instance.codecs.fetch(),
        builder: ((context, AsyncSnapshot<List<Codec>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text(snapshot.error?.toString() ?? "Something went wrong");
          }
          var data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: ((context, index) {
              return ListTile(title: Text(data[index].name));
            }),
          );
        }),
      ),
    );
  }
}
