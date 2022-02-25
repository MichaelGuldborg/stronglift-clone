import 'dart:convert';
import 'dart:developer';

void printJsonToDart(String? className, String s) {
  final source = jsonToDart(className, s);
  log(source);
}

String jsonToDart(String? className, String s) {
  final map = jsonDecode(s);
  return mapToDart(className, map);
}

String mapToDart(String? className, Map<String, dynamic> json) {
  /// Convert json to list of fields
  final List<ClassField> fields = json.keys.map((key) => ClassField.fromKeyValue(key, json[key])).toList();
  String source = '';

  void addLine(String line) {
    source += '\n$line';
  }

  /// print class with fields
  addLine('class $className {');
  for (var field in fields) {
    addLine('final ${field.type}? ${field.name};');
  }

  /// print class constructor
  addLine('');
  addLine('$className({');
  for (var field in fields) {
    addLine('this.${field.name},');
  }
  addLine('});');

  /// print factory method fromJson
  addLine('');
  addLine('factory $className.fromMap(Map<String, dynamic> map) {');
  addLine('return $className(');
  for (var field in fields) {
    addLine('${field.name}: map[\'${field.key}\'],');
  }
  addLine(');');
  addLine('}');

  /// print method toMap
  addLine('');
  addLine('Map<String, dynamic> toMap() {');
  addLine('return {');
  for (var field in fields) {
    addLine('\'${field.key}\': ${field.name},');
  }
  addLine('};');
  addLine('}');
  addLine('');
  addLine('}');

  /// Recursively print model source code of app model values
  final List<ClassField> appModelFields = fields.where((field) => field.isAppModel!).toList();
  appModelFields.toSet().toList().forEach((field) {
    addLine(mapToDart(field.type, json[field.key!]));
  });

  return source;
}

class ClassField {
  final String? key;
  final String? name;
  final String? type;
  final bool? isAppModel;

  ClassField({
    this.key,
    this.name,
    this.type,
    this.isAppModel,
  });

  factory ClassField.fromKeyValue(String key, dynamic value) {
    final String fieldName = snakeToCamelCase(key);

    // type name
    final Type runtimeType = value.runtimeType;
    final String runtimeTypeName = '$runtimeType';
    final bool isAppModel = runtimeTypeName.contains('HashMap');
    final String typeName = isAppModel ? capitalize(fieldName) : runtimeTypeName;
    return ClassField(
      key: key,
      name: fieldName,
      type: typeName,
      isAppModel: isAppModel,
    );
  }
}

String snakeToCamelCase(String name) {
  final List<String> words = name.split('_');
  final List<String> capitalWords = words.sublist(1).map((w) => capitalize(w)).toList();
  return words.first + capitalWords.join('');
}

String capitalize(String name) {
  if (name.isEmpty) return name;
  if (name.length == 1) return name.toUpperCase();
  return name.substring(0, 1).toUpperCase() + name.substring(1);
}
