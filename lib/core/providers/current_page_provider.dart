import 'package:hooks_riverpod/hooks_riverpod.dart';

final currentPageProvider = StateProvider<int>((ref) {
  return 0;
});