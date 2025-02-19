import 'dart:async';

import 'package:altair/altair.dart';
import 'package:bloc/bloc.dart';

import '../model.dart';
import 'events.dart';
import 'repository.dart';
import 'states.dart';

export 'events.dart';
export 'states.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final addressRepository = AddressRepository();

  @override
  AddressState get initialState => AddressUninitialized();

  List<Address> get addresses => (state is AddressContentState)
      ? (state as AddressContentState).addresses
      : _oldState?.addresses;

  AddressContentState _oldState;

  void _saveCurrentState() =>
      (state is AddressContentState) ? _oldState = state : null;

  @override
  Stream<AddressState> mapEventToState(AddressEvent event) async* {
    _saveCurrentState();
    if (event is AddressReset) yield initialState;
    if (event is AddressFind) yield* _find(event);
    if (event is AddressSelect) yield* _select(event);
  }

  Stream<AddressState> _select(AddressSelect event) async* {
    yield AddressSuccess.fromOldState(
      _oldState,
      selectedAddress: event?.address,
    );
  }

  Stream<AddressState> _find(AddressFind event) async* {
    final response = await addressRepository.findByZipCode(
      zipCode: event.zipCode,
    );
    if (response.isSuccessful) {
      yield AddressSuccess.fromOldState(
        _oldState,
        selectedAddress: response.data,
      );
    } else {
      yield* _sendError(response);
    }
  }

  Stream<AddressState> _sendError(RepositoryResponse response) async* {
    yield AddressFail.fromOldState(
      _oldState,
      error: response.error,
    );
  }
}
