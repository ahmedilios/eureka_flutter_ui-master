import 'package:equatable/equatable.dart';
import 'package:altair/altair.dart';
import 'package:meta/meta.dart';

class PostShort extends Equatable implements ShortModel {
  final int id;
  final String title;
  final String body;

  @override
  List<Object> get props => [id];

  PostShort({
    @required this.id,
    @required this.title,
    @required this.body,
  });

  factory PostShort.fromJson(Map<String, dynamic> json) => PostShort(
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': this.id,
      'title': this.title,
      'body': this.body,
    };
  }
}

class PostDetailed extends Equatable implements DetailModel {
  final int id;
  final String title;
  final String body;

  @override
  List<Object> get props => [id];

  PostDetailed({
    @required this.id,
    @required this.title,
    @required this.body,
  });

  factory PostDetailed.fromJson(Map<String, dynamic> json) => PostDetailed(
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': this.id,
      'title': this.title,
      'body': this.body,
    };
  }
}
