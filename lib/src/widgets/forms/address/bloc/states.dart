import 'package:altair/altair.dart';
import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import '../model.dart';

class AddressState extends Equatable {
  final List _props;

  AddressState([this._props = const []]);

  @override
  List get props => _props;
}

class AddressUninitialized extends AddressState {}

class AddressLoading extends AddressState {}

class AddressFail extends AddressContentState {
  final ErrorModel error;

  AddressFail({
    @required this.error,
    List<Address> addresses,
  }) : super(addresses: addresses);

  factory AddressFail.fromOldState(
    AddressContentState oldState, {
    ErrorModel error,
    List<Address> addresses,
  }) =>
      AddressFail(
        addresses: addresses ?? oldState?.addresses,
        error: error ?? (oldState is AddressFail ? oldState.error : null),
      );

  @override
  List get props => super.props..add(error);
}

class AddressSuccess extends AddressContentState {
  final Address selectedAddress;

  AddressSuccess({
    List<Address> addresses,
    this.selectedAddress,
  }) : super(addresses: addresses);

  @override
  List get props => super.props..add(selectedAddress);

  factory AddressSuccess.fromOldState(
    AddressContentState oldState, {
    List<Address> addresses,
    Address selectedAddress,
  }) =>
      AddressSuccess(
        addresses: addresses ?? oldState?.addresses,
        selectedAddress: selectedAddress ??
            (oldState is AddressSuccess ? oldState?.selectedAddress : null),
      );
}

abstract class AddressContentState extends AddressState {
  final List<Address> addresses;

  AddressContentState({
    this.addresses,
  }) : super([addresses]);
}
