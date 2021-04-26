part of 'shop_layout_cubit.dart';

@immutable
abstract class ShopLayoutState {}

class ShopLayoutInitial extends ShopLayoutState {}
class ShopLayoutChangeNabBar extends ShopLayoutState {}
class ShopLayoutLoadingState extends ShopLayoutState {}
class ShopLayoutSuccessState extends ShopLayoutState {}
class ShopLayoutError extends ShopLayoutState {
  final String error;

  ShopLayoutError(this.error);
}
