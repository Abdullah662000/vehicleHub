import 'package:vehiclehub_pakistan/data/datasources/remote/mechanic_remote_ds.dart';
import 'package:vehiclehub_pakistan/data/models/mechanic.dart';

class MechanicRepository {
  MechanicRepository({required MechanicRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  final MechanicRemoteDataSource _remoteDataSource;

  Future<List<Mechanic>> getMechanics({
    double? maxDistance,
    bool verifiedOnly = false,
  }) {
    return _remoteDataSource.getMechanics(
      maxDistance: maxDistance,
      verifiedOnly: verifiedOnly,
    );
  }

  Future<Mechanic> getMechanic(String id) => _remoteDataSource.getMechanic(id);
}
