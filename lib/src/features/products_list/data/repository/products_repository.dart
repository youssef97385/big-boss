import 'package:bigboss/src/features/products_list/data/data_source/products_data_source.dart';
import 'package:bigboss/src/features/products_list/data/models/product_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/common/data/models/error_model/error_model.dart';
import '../../../../core/utils/helpers/error_parser.dart';
import '../../domain/entiities/product_endtity.dart';
import '../models/products_categories_enum.dart';

abstract class ProductRepository {
  Future<Either<ErrorModel, ProductsEntity>> getProducts(
      ProductCatsEnum productCatsEnum, int id, int pageNumber);

  Future<Either<ErrorModel,ProductsEntity>> getProductsBySubCategoryId(
      int id,int page);
}

class ProductRepositoryImpl implements ProductRepository {
  final ProductsDataSource productsDataSource;

  ProductRepositoryImpl({required this.productsDataSource});

  @override
  Future<Either<ErrorModel, ProductsEntity>> getProducts(productCatsEnum, id,
      int pageNumber) async {
    try {
      print("TTTTTTT====== $pageNumber");
      String path = "";
      if (productCatsEnum == ProductCatsEnum.account) {
        path =
        "EproductsByAccountIdP?PageNumber=$pageNumber&PageSize=20&accountId=$id";
      }
      if (productCatsEnum == ProductCatsEnum.subcategory) {
        path = "EproductsBySubCategoryId?subCategoryId=$id";
      }
      if (productCatsEnum == ProductCatsEnum.brand) {
        path = "EproductsByBrandIdP?PageNumber=$pageNumber&PageSize=20&brandId=$id";
      }
      if (productCatsEnum == ProductCatsEnum.country) {
        path = "EproductsByCountryIdP?PageNumber=$pageNumber&PageSize=20&countryId=$id";
      }

      final result = await productsDataSource.getProducts(path: path);

      List<ProductEntity> products = [];
      for (ProductModel model in result?.data ?? []) {
        String link = "";
        if (model.link?.isNotEmpty ?? false) {
          link = model.link?[0] ?? "";
        }
        products.add(ProductEntity(
          id: model.id,
          image: link,
          name: model.enName,
          description: model.enDescription,
          shippingDetails: model.enShippingDetails,
          prices: model.priceLists ?? [],
          stringColors: model.colors ?? "",
          stringSizes: model.sizes ?? "",
        ));
      }
      ProductsEntity productsEntity = ProductsEntity(products: products,
          pageNumber: result?.pageNumber ?? 0,
          totalPages: result?.totalPages ?? 0);


      return Right(productsEntity);
    } catch (e, stackTrace) {
      print("ERROR Prod $e");
      return Left(errorParse(e, stackTrace));
    }
  }

  @override
  Future<Either<ErrorModel, ProductsEntity>> getProductsBySubCategoryId(
      int id,int page) async {
    try {
      final result =
      await productsDataSource.getProductsBySubCategoryId(id: id,page: page);

      List<ProductEntity> products = [];
      for (ProductModel model in result?.data ?? []) {
        String link = "";
        if (model.link?.isNotEmpty ?? false) {
          link = model.link?[0] ?? "";
        }
        products.add(ProductEntity(
          id: model.id,
          image: link,
          name: model.enName,
          description: model.enDescription,
          shippingDetails: model.enShippingDetails,
          prices: model.priceLists ?? [],
          stringColors: model.colors ?? "",
          stringSizes: model.sizes ?? "",
        ));
      }
      ProductsEntity productsEntity = ProductsEntity(products: products,
          pageNumber: result?.pageNumber ?? 0,
          totalPages: result?.totalPages ?? 0);
      return Right(productsEntity);
    } catch (e, stackTrace) {
      print("ERROR Prod $e");
      return Left(errorParse(e, stackTrace));
    }
  }
}
