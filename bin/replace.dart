import 'dart:io';

void main(List<String> arguments) {
  final directory = Directory('lib');
  processFiles(directory);
}

// Функция для обработки всех файлов в указанной директории и ее поддиректориях
void processFiles(Directory directory) {
  directory.list(recursive: true).listen((file) {
    if (file is File && file.path.endsWith('.dart')) {
      processFile(file); // Обработка каждого файла
    }
  });
}

// Функция для обработки отдельного файла
void processFile(File file) {
  final lines = file.readAsLinesSync(); // Считывание всех строк файла
  final updatedLines = <String>[]; // Список для обновленных строк

  // Перебор каждой строки файла
  for (final line in lines) {
    final updatedLine = replaceAssetString(line); // Обработка строки с путем к ресурсу
    updatedLines.add(updatedLine); // Добавление обновленной строки в список
  }

  // Запись всех обновленных строк обратно в файл
  file.writeAsStringSync(updatedLines.join('\n'));
}

// Функция для замены строк с путем к ресурсу на массивы путей
String replaceAssetString(String line) {
  // Регулярное выражение для поиска строк вида `["assets/image/pic.png"]`
  final RegExp regex = RegExp(r'\[(".*\[*\].*")\]');

  // Замена найденной строки на результат обработки
  final replacedLine = line.replaceAllMapped(regex, (match) {
    final replacedString = processAssetString(match.group(1)!);
    return replacedString;
  });

  return replacedLine;
}

// Функция для обработки строки с путем к ресурсу и генерации массива путей
String processAssetString(String assetString) {
  // Регулярное выражение для извлечения диапазона чисел из строки
  final RegExp regex = RegExp(r'\[(.*?)\]');
  final Match? match = regex.firstMatch(assetString);

  if (match != null) {
    final extractedContent = match.group(1);
    final pathStart=assetString.split("[")[0];
    final pathEnd=assetString.split("]")[1];
    final List<String> parts=extractedContent!.split(':');
    final List<String> result=[];
    final from=int.parse(parts[0]);
    final fromStrLen=parts[0].length;
    final to=int.parse(parts[1]);

    // Генерация массива путей к ресурсам с учетом диапазона чисел
    for(int i=from; i<=to;i++){
      final String current=i.toString().padLeft(fromStrLen,'0');
      final String newPath="\t$pathStart$current$pathEnd";
      result.add(newPath);
    }
    assetString="[\n${result.join(",\n")}\n]"; // Сборка обновленной строки
  }
  return assetString;
}
