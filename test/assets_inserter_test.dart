import 'package:flutter_test/flutter_test.dart';

import '../bin/replace.dart';

void main() {
  test('path with template', () {
    const String originalContent = 'return ["assets/image/pic[00:1].png"];';

    const String expectedContent = '''
return [
\t"assets/image/pic00.png",
\t"assets/image/pic01.png"
];''';
    final updatedContent = replaceAssetString(originalContent);
    expect(updatedContent, expectedContent);
  });

  test('path without template', () {
    const String originalContent = 'return ["assets/image/pic.png"];';

    const String expectedContent = 'return ["assets/image/pic.png"];';
    final updatedContent = replaceAssetString(originalContent);
    expect(updatedContent, expectedContent);
  });
}
