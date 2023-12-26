import 'package:bigboss/src/features/offers/data/models/offer_model.dart';
import 'package:bigboss/src/features/offers/data/repository/offer_repository.dart';
import 'package:bigboss/src/features/products_list/domain/entiities/product_endtity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/data/models/error_model/error_model.dart';
import 'offer_products_state.dart';
import 'offers_state.dart';

class OfferProductsCubit extends Cubit<OfferProductsState> {
  OfferRepository repository;

  OfferProductsCubit({required this.repository}) : super(const OfferProductsState.initial()) ;

  Future<void> getProductsByOfferId(id) async {
    emit(const OfferProductsState.loading());

    final result = await repository.getProductsByOfferId(id);
    result.fold(
          (ErrorModel error) => emit(
        OfferProductsState.error(error.error ?? ""),
      ),
          (List<ProductEntity> products) => emit(
        OfferProductsState.success(products),
      ),
    );
  }
}
