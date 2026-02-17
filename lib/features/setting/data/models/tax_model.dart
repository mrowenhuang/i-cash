import 'dart:convert';

import 'package:i_cash/features/setting/domain/entities/tax_entites.dart';

class TaxModel implements TaxEntites {
  @override
  final String? activeTax;
  @override
  final String? nameTax;
  @override
  final String? percentTax;

  const TaxModel({this.activeTax, this.nameTax, this.percentTax});

  /// ENTITY -> MODEL
  factory TaxModel.fromEntity(TaxEntites entity) {
    return TaxModel(
      activeTax: entity.activeTax,
      nameTax: entity.nameTax,
      percentTax: entity.percentTax,
    );
  }

  /// MAP -> MODEL
  factory TaxModel.fromMap(Map<String, dynamic> map) {
    return TaxModel(
      activeTax: map['activeTax'] as String?,
      nameTax: map['nameTax'] as String?,
      percentTax: map['percentTax'] as String?,
    );
  }

  /// MODEL -> MAP
  Map<String, dynamic> toMap() {
    return {
      'activeTax': activeTax,
      'nameTax': nameTax,
      'percentTax': percentTax,
    };
  }

  /// JSON
  String toJson() => json.encode(toMap());
  factory TaxModel.fromJson(String source) =>
      TaxModel.fromMap(json.decode(source));

  /// COPY
  TaxModel copyWith({String? activeTax, String? nameTax, String? percentTax}) {
    return TaxModel(
      activeTax: activeTax ?? this.activeTax,
      nameTax: nameTax ?? this.nameTax,
      percentTax: percentTax ?? this.percentTax,
    );
  }

  @override
  String toString() =>
      'TaxModel(activeTax: $activeTax, nameTax: $nameTax, percentTax: $percentTax)';

  @override
  set activeTax(String? value) {
    // TODO: implement activeTax
  }

  @override
  set nameTax(String? value) {
    // TODO: implement nameTax
  }

  @override
  set percentTax(String? value) {
    // TODO: implement percentTax
  }

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  @override
  // TODO: implement stringify
  bool? get stringify => throw UnimplementedError();
}
