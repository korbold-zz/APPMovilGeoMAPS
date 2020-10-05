import 'package:busmart/features/home/data/models/json_model.dart';
import 'package:busmart/features/home/data/repositories/home_data_repository_impl.dart';

abstract class HomeDomainRepositoryINTERFACE {
  List<Routes> getRoutesEntities();
}
