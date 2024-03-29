import 'package:bigboss/src/core/utils/managers/database/hive_service.dart';
import 'package:bigboss/src/core/utils/managers/sql_database_manager/db_services.dart';
import 'package:bigboss/src/features/address/data/data_source/addresses_data_source.dart';
import 'package:bigboss/src/features/address/data/repository/address_repository.dart';
import 'package:bigboss/src/features/address/logic/address_cubit.dart';
import 'package:bigboss/src/features/home_page/data/home_source/accounts_data_source.dart';
import 'package:bigboss/src/features/home_page/data/home_source/categories_data_source.dart';
import 'package:bigboss/src/features/home_page/data/home_source/countries_data_source.dart';
import 'package:bigboss/src/features/home_page/data/home_source/home_data_source.dart';
import 'package:bigboss/src/features/home_page/domain/repository/home_repository.dart';
import 'package:bigboss/src/features/home_page/presentation/logic/accounts_cubit/accounts_cubit.dart';
import 'package:bigboss/src/features/home_page/presentation/logic/brands_bloc/brands_cubit.dart';
import 'package:bigboss/src/features/home_page/presentation/logic/categories_cubit/categories_cubit.dart';
import 'package:bigboss/src/features/home_page/presentation/logic/countries_cubit/countries_cubit.dart';
import 'package:bigboss/src/features/home_page/presentation/logic/slides_bloc/slides_cubit.dart';
import 'package:bigboss/src/features/order_feature/bloc/order_cubit.dart';
import 'package:bigboss/src/features/order_feature/data/order_data_source.dart';
import 'package:bigboss/src/features/orders_page/presentation/bloc/order_detail_cubit.dart';
import 'package:bigboss/src/features/orders_page/presentation/bloc/orders_bloc.dart';
import 'package:bigboss/src/features/otp-verifivation/data/data_source/send_otp_data_source.dart';
import 'package:bigboss/src/features/products_list/data/data_source/products_data_source.dart';
import 'package:bigboss/src/features/products_list/data/repository/products_repository.dart';
import 'package:bigboss/src/features/products_list/presentation/logic/products_list_cubit.dart';
import 'package:bigboss/src/features/search_page/cubit/search_cubit.dart';
import 'package:bigboss/src/features/search_page/data_source/search_product_data_source.dart';
import 'package:bigboss/src/features/search_page/data_source/search_repo.dart';
import 'package:bigboss/src/features/shopping_cart/data/repository/cart_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'app/logic/app_bloc.dart';
import 'app/logic/app_settings.dart';
import 'app/routes/router.gr.dart';
import 'core/utils/managers/database/database_manager.dart';
import 'core/utils/managers/http/check_endpoint_reachability.dart';
import 'core/utils/managers/http/domain_lookup.dart';
import 'core/utils/managers/http/http_manager.dart';
import 'core/utils/managers/notification/gms_notification_manager.dart';
import 'core/utils/managers/notification/notification_message_handler.dart';
import 'features/address/logic/add_address_cubit.dart';
import 'features/home_page/data/home_source/brands_data_source.dart';
import 'features/home_page/data/repository/home_repository_impl.dart';
import 'features/login/data/data_source/remote_data_source/login_data_source.dart';
import 'features/login/data/repository/login_repository_impl.dart';
import 'features/login/domain/repository/login_repository.dart';
import 'features/login/domain/use_cases/login_use_case.dart';
import 'features/login/presentation/logic/login_cubit.dart';
import 'features/menu_page/presentation/logic/delete_account_bloc/delete_account_cubit.dart';
import 'features/notification_page/data/data_source/notification_data_source.dart';
import 'features/notification_page/data/repository/notification_repository.dart';
import 'features/notification_page/presentation/cubit/notification_cubit.dart';
import 'features/offers/data/data_source/offer_data_source.dart';
import 'features/offers/data/repository/offer_repository.dart';
import 'features/offers/presentation/logic/offer_product_cubit.dart';
import 'features/offers/presentation/logic/offers_bloc.dart';
import 'features/order_feature/data/order_repository.dart';
import 'features/otp-verifivation/data/repository/send_otp_repository.dart';
import 'features/otp-verifivation/presentation/logic/send_otp_cubit.dart';
import 'features/otp-verifivation/presentation/logic/verify_phone_cubit.dart';
import 'features/register/presentation/bloc/register_cubit.dart';
import 'features/shopping_cart/presentation/logic/cart_cubit.dart';
import 'features/sub_categories/presentation/logic/sub_category_cubit/sub_category_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  initInjections(serviceLocator);
  serviceLocator.allowReassignment = true;
}

void initInjections(GetIt serviceLocator) {
  //! Utls
  serviceLocator.registerLazySingleton<DomainLookup>(
    () => DomainLookupImpl(),
  );

  serviceLocator.registerLazySingleton<AppSettings>(
    () => AppSettings(databaseManager: serviceLocator()),
  );

  //! App

  //* Logic
  serviceLocator.registerLazySingleton<AppBloc>(
    () => AppBloc(domainLookup: serviceLocator()),
  );

  //* Router
  serviceLocator.registerLazySingleton<AppRouter>(
    () => AppRouter(),
  );
  //* Router
  serviceLocator.registerLazySingleton<HiveService>(
    () => HiveService(),
  );

  //! core

  //* Database
  serviceLocator.registerLazySingleton<DatabaseManager>(
    () => DatabaseManagerImpl(),
  );

  //* Network
  serviceLocator.registerLazySingleton<BaseOptions>(
    () => BaseOptions(
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        "charset": "utf-8",
        "Accept-Charset": "utf-8",
      },
      responseType: ResponseType.plain,
    ),
  );

  serviceLocator.registerLazySingleton<HttpManager>(
    () => HttpManagerImpl(
      baseOptions: serviceLocator(),
      databaseManager: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<CheckEndpointReachability>(
    () => CheckEndpointReachabilityImpl(),
  );

  ///login feature

  serviceLocator.registerFactory<OffersDataSource>(
    () => OffersDataSourceImpl(
      httpManager: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<SendOtpDataSource>(
    () => SendOtpDataSourceImpl(
      httpManager: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<SearchDataSource>(
    () => SearchDataSourceImpl(
      httpManager: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<LoginDataSource>(
    () => LoginDataSourceImpl(
      httpManager: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<NotificationDataSource>(
    () => NotificationDataSourceImpl(
      httpManager: serviceLocator(),
    ),
  );

  //* repositories

  serviceLocator.registerFactory<NotificationRepo>(
    () => NotificationRepoImpl(
      dataSource: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<OfferRepository>(
    () => OfferRepositoryImpl(
      offersDataSource: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<AddressRepository>(
    () => AddressRepositoryImpl(
      addressDataSource: serviceLocator(),
      databaseManager: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<SearchRepo>(
    () => SearchRepoImpl(
      dataSource: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<LoginRepository>(
    () => LoginRepositoryImpl(
      loginDataSource: serviceLocator(),
      gmsNotificationsManager: serviceLocator(),
    ),
  );

  //* use cases

  serviceLocator.registerFactory<Login>(
    () => Login(
      repository: serviceLocator(),
    ),
  );

  //* bloc/cubit

  serviceLocator.registerFactory<NotificationCubit>(
    () => NotificationCubit(
      repository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<OrderDetailCubit>(
    () => OrderDetailCubit(
      repository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<OffersCubit>(
    () => OffersCubit(
      repository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<OfferProductsCubit>(
    () => OfferProductsCubit(
      repository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<AddressCubit>(
    () => AddressCubit(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<VerifyPhoneCubit>(
    () => VerifyPhoneCubit(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<SendOtpCubit>(
    () => SendOtpCubit(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<SearchCubit>(
    () => SearchCubit(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<LoginCubit>(
    () => LoginCubit(
      login: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<DeleteAccounCubit>(
    () => DeleteAccounCubit(
      repository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<DBService>(
    () => DBService(),
  );

  //slides

  serviceLocator.registerFactory<AddressDataSource>(
    () => AddressDataSourceImpl(
      httpManager: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<HomeDataSource>(
    () => HomeDataSourceImpl(
      httpManager: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<BrandsDataSource>(
    () => BrandsDataSourceImpl(
      httpManager: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<OrderDataSource>(
    () => OrderDataSourceImpl(
      httpManager: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<CategoriesDataSource>(
    () => CategoriesDataSourceImpl(
      httpManager: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<CountriesDataSource>(
    () => CountriesDataSourceImpl(
      httpManager: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<AccountsDataSource>(
    () => AccountsDataSourceImpl(
      httpManager: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<ProductsDataSource>(
    () => ProductsDataSourceImpl(
      httpManager: serviceLocator(),
    ),
  );

  //* repositories

  serviceLocator.registerFactory<HomeRepository>(
    () => HomeRepositoryImpl(
      homeDataSource: serviceLocator(),
      brandsDataSource: serviceLocator(),
      categoriesDataSource: serviceLocator(),
      countriesDataSource: serviceLocator(),
      accountsDataSource: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<SendOtpRepository>(
    () => SendOtpRepositoryImpl(
      sendOtpDataSource: serviceLocator(),
      databaseManager: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<ProductRepository>(
    () => ProductRepositoryImpl(
      productsDataSource: serviceLocator(),
      offersDataSource: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<CartRepo>(
    () => CartRepoImpl(
      hiveService: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<OrderRepo>(
    () => OrderRepoImpl(
      orderDataSource: serviceLocator(),
      hiveService: serviceLocator(),
    ),
  );

  //* bloc/cubit

  serviceLocator.registerFactory<AddAddressCubit>(
    () => AddAddressCubit(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<OrdersBloc>(
    () => OrdersBloc(
      repository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<CartCubit>(
    () => CartCubit(
      cartRepo: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<SlidesCubit>(
    () => SlidesCubit(
      slidesRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<BrandsCubit>(
    () => BrandsCubit(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<CategoriesCubit>(
    () => CategoriesCubit(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<CountriesCubit>(
    () => CountriesCubit(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<OrderCubit>(
    () => OrderCubit(
      repo: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<RegisterCubit>(
    () => RegisterCubit(
      loginRepository: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<AccountsCubit>(
    () => AccountsCubit(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<ProductsListCubit>(
    () => ProductsListCubit(
      repository: serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<SubCategoryCubit>(
    () => SubCategoryCubit(
      repository: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<NotificationMessageHandler>(
    () => NotificationMessageHandlerImpl(),
  );

  serviceLocator.registerLazySingleton<GmsNotificationsManager>(
    () => GmsNotificationsManager(
      notificationMessageHandler: serviceLocator(),
    ),
  );
}
