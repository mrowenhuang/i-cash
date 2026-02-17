// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class TaxEntites extends Equatable {
  String? nameTax;
  String? percentTax;
  String? activeTax;

  TaxEntites({this.nameTax, this.percentTax, this.activeTax});

  @override
  List<Object?> get props => [nameTax, percentTax, activeTax];
}
