import 'package:streams_streamtransformandcount/streams_streamtransformandcount.dart';
import 'package:test/test.dart';

void main() {
  test('transformAndCount counts transformed strings and handles errors',
      () async {
    var input = Stream.fromIterable(['hello', 'world', 'dart']).map(
        (s) => s.length > 4 ? s.toUpperCase() : throw Exception('Too short'));
    var count = await transformAndCount(input, (s) => 'Processed: $s');
    expect(count,
        equals(2)); // 'hello' and 'world' are processed, 'dart' throws an error
  });

  test('transformAndCount handles an empty stream', () async {
    var input = Stream<String>.empty();
    var count = await transformAndCount(input, (s) => 'Processed: $s');
    expect(count, equals(0));
  });
}
