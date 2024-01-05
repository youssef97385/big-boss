
import 'package:bigboss/src/features/offers/data/models/offer_model.dart';
import 'package:bigboss/src/features/offers/domain/offer_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'offers_state.freezed.dart';

@freezed
abstract class OffersState with _$OffersState {
  const factory OffersState.initial() = _Initial;

  const factory OffersState.loading() = _Loading;

  const factory OffersState.error(String message) = _Error;

  const factory OffersState.success(
      List<OfferEntity> accounts) = _Success;
}
