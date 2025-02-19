import 'package:altair/altair.dart';

import '../common/api.dart';
import 'model.dart';

class PostRepository extends SimpleRepository<PostShort, PostDetailed> {
  @override
  Api get api => Api.instance;

  @override
  SimpleRepositoryConfig<PostShort, PostDetailed> get config =>
      SimpleRepositoryConfig(
        modelUrl: () => 'posts',
        shortFromJson: (json) => PostShort.fromJson(json),
        detailFromJson: (json) => PostDetailed.fromJson(json),
        backupConfig: BackupConfig.all,
      );
}
