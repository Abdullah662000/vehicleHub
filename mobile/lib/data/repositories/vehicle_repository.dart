import 'package:vehiclehub_pakistan/data/datasources/remote/vehicle_remote_ds.dart';
import 'package:vehiclehub_pakistan/data/models/service_record.dart';
import 'package:vehiclehub_pakistan/data/models/vehicle.dart';

class VehicleRepository {
  VehicleRepository({required VehicleRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  final VehicleRemoteDataSource _remoteDataSource;

  Future<List<Vehicle>> getVehicles() => _remoteDataSource.getVehicles();

  Future<Vehicle> getVehicle(String id) => _remoteDataSource.getVehicle(id);

  Future<List<ServiceRecord>> getServiceTimeline(String vehicleId) {
    return _remoteDataSource.getServiceTimeline(vehicleId);
  }

  Future<Vehicle> createVehicle({
    required String make,
    required String model,
    required int year,
    required String reg,
    required String fuelType,
    required String transmission,
    int mileage = 0,
  }) {
    return _remoteDataSource.createVehicle({
      'make': make,
      'model': model,
      'year': year,
      'reg': reg,
      'fuelType': fuelType,
      'transmission': transmission,
      'mileage': mileage,
      'photo': _photoKeyForModel(model),
    });
  }

  static String _photoKeyForModel(String model) {
    final m = model.toLowerCase();
    if (m.contains('civic')) return 'civic';
    if (m.contains('sportage')) return 'sportage';
    if (m.contains('hilux')) return 'hilux';
    if (m.contains('alto')) return 'alto';
    if (m.contains('city')) return 'city';
    if (m.contains('tucson')) return 'tucson';
    if (m.contains('mg')) return 'mg';
    if (m.contains('corolla')) return 'corolla';
    return 'corolla';
  }
}
