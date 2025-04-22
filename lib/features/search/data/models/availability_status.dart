import 'package:hive/hive.dart';

part 'availability_status.g.dart';

@HiveType(typeId: 3) // Ensure this is unique across all your adapters
enum AvailabilityStatus {
  @HiveField(0)
  inStock,

  @HiveField(1)
  lowStock,

  @HiveField(2)
  outOfStock,
}
const Map<String, AvailabilityStatus> availabilityStatusValues = {
  "In Stock": AvailabilityStatus.inStock,
  "Low Stock": AvailabilityStatus.lowStock,
  "Out of Stock": AvailabilityStatus.outOfStock,
};
