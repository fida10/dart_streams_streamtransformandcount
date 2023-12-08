/// Support for doing something awesome.
///
/// More dartdocs go here.
library;

import 'dart:async';

export 'src/streams_streamtransformandcount_base.dart';

/*
Practice Question 1: Stream Transform and Count

Task:

Create a function transformAndCount that takes a Stream<String> and a 
transformation function (String Function(String)). 
It should apply the transformation to each string in the stream, 
count the number of transformed strings, and 
return a Future<int> with the count. Handle any errors by logging them and 
excluding the errored elements from the count.
 */

Future<int> transformAndCount(
    Stream<String> input, String Function(String) callback) async {
  int count = 0;
  StreamController<String> controller = StreamController<String>();

  // Listen to the original input stream
  input.listen(
    (data) {
      try {
        controller.add(callback(data));
      } catch (e) {
        print("Error thrown on data! Error: $e");
      }
    },
    onError: (error) {
      print("Error thrown on data! Stream will proceed Error: $error");
    },
    onDone: () {
      controller.close();
    },
    cancelOnError: false, //Continue listening even if there's an error
  );

  // Use async for loop to iterate over the new stream
  await for (var result in controller.stream) {
    print("Transformation: ${callback(result)}");
    count++;
  }

  return count;
}
