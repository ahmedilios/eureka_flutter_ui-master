import 'package:altair/altair.dart';

import 'model.dart';
import 'repository.dart';

class PostBloc extends SimpleBloc<PostShort, PostDetailed, PostRepository> {
  @override
  final PostRepository repository;

  PostBloc(this.repository) : super();
}

class DistinctPostBloc
    extends SimpleBloc<PostShort, PostDetailed, PostRepository>
    with DistinctEventMixin {
  @override
  final PostRepository repository;

  DistinctPostBloc(this.repository) : super();
}
