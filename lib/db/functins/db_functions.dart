import 'package:hive_flutter/hive_flutter.dart';

import '../songs.dart';


Box<AllSongs> getSongBox() {
  return Hive.box<AllSongs>('AllSongs');
}

Box<List> getlibrarybox() {
  return Hive.box<List>('Library');
}