<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

Wrapper for https://www.radio-browser.info/

Documentation for the API can be found [here](https://de1.api.radio-browser.info/#General)

## Features

Contains wrapper methods for the following endpoints:
1. Stations
2. Countries
3. Languages
4. Tags
5. Codecs
6. Server details

## Getting started

Import the package:

```dart
import 'package:radio_browser_flutter/radio_browser_flutter.dart';
```

Initialize `RadioBrowserClient` before using it:

```dart
void main() async {
  await RadioBrowserClient.initialize(USER_AGENT);
  runApp(const MyApp());
}
```

Please keep the User-Agent descriptive as it helps the API maintainer.
It can be something like `<APP_NAME>/<APP_VERSION>`.

## Usage

Call the methods exposed by the API by using the client instance:

```dart
FutureBuilder(
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
      )
```
