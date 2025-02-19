import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import '../model.dart';

class AddressEvent extends Equatable {
  final List _props;

  AddressEvent([this._props = const []]);

  @override
  List get props => _props;
}

class AddressReset extends AddressEvent {}

class AddressFind extends AddressEvent {
  final String zipCode;

  AddressFind({
    this.zipCode,
  }) : super([zipCode]);
}

class AddressSelect extends AddressEvent {
  final Address address;

  AddressSelect({
    @required this.address,
  });
}
