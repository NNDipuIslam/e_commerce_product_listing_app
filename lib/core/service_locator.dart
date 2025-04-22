import 'package:dio/dio.dart';
import 'package:e_commerce_product_listing_app/core/exports.dart';
import 'package:e_commerce_product_listing_app/features/search/data/models/availability_status.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // Initialize Hive
  final appDir = await getApplicationDocumentsDirectory();
  Hive.init(appDir.path);

  // Register Hive adapters
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(ReviewModelAdapter());
  Hive.registerAdapter(AvailabilityStatusAdapter());

  // ✅ Open Hive box for products
  final productBox = await Hive.openBox<Product>('productBox');
  sl.registerSingleton<Box<Product>>(productBox);

  // Register Dio
  sl.registerLazySingleton<Dio>(() => Dio());

  // Update ApiService to use Dio
  sl.registerLazySingleton<ApiService>(() => ApiService(sl<Dio>()));

  // Register Data Sources
  sl.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSource(sl<Box<Product>>()));
  sl.registerLazySingleton<ProductRemoteDataSource>(() =>
      ProductRemoteDataSourceImpl(
          apiService: sl<ApiService>(),
          productLocalDataSource: sl<ProductLocalDataSource>()));

  // Register Repositories
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
        productRemoteDataSource: sl<ProductRemoteDataSource>(),
        productLocalDataSource: sl<ProductLocalDataSource>(),
      ));

  // Register Use Cases
  sl.registerLazySingleton<GetProducts>(
      () => GetProducts(sl<ProductRepository>()));

  // Register Blocs
  sl.registerFactory<SearchBloc>(
      () => SearchBloc(getProducts: sl<GetProducts>()));
}
