import 'package:bigboss/src/features/offers/data/models/offer_model.dart';
import 'package:bigboss/src/features/offers/data/repository/offer_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/common/data/models/error_model/error_model.dart';
import 'offers_state.dart';

class OffersCubit extends Cubit<OffersState> {
  OfferRepository repository;

  OffersCubit({required this.repository}) : super(const OffersState.initial()) {
    getOffers();
  }

  Future<void> getOffers() async {
    emit(const OffersState.loading());

    final result = await repository.getOffers();
    result.fold(
      (ErrorModel error) => emit(
        OffersState.error(error.error ?? ""),
      ),
      (List<OfferModel> offers) => emit(
        OffersState.success(offers),
      ),
    );
  }
}
