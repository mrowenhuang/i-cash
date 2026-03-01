part of 'tax_bloc.dart';

sealed class TaxState extends Equatable {
  const TaxState();

  @override
  List<Object> get props => [];
}

final class TaxInitial extends TaxState {}

final class LoadingGetTaxState extends TaxState {
  @override
  List<Object> get props => [];
}

class SuccessGetTaxState extends TaxState {
  final List<TaxEntites> taxData;

  const SuccessGetTaxState({required this.taxData});

  @override
  List<Object> get props => [taxData];
}

final class FailedGetTaxState extends TaxState {
  final String message;

  const FailedGetTaxState({required this.message});

  @override
  List<Object> get props => [message];
}
