main() {
  final reg = RegExp(r'Future<ApiResponse<(.+)>>');
  final str = 'Future<ApiResponse<User>>';

  var firstMatch = reg.firstMatch(str);

  print(firstMatch.groupNames);
}