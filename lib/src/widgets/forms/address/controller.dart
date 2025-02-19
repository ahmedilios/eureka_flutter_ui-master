import 'package:vega/src/resources/controllers/notifier.dart';
import '../../../resources/controllers/text.dart';
import '../../../validators/group.dart';
import 'model.dart';

class AddressDataController extends NotifierController {
  final descriptionController = TextController.required();
  final zipCodeController = MaskedTextController(
    mask: '00000-000',
    groupValidator: GroupValidator.required,
  );
  final stateController = TextController.required();
  final cityController = TextController.required();
  final neighborController = TextController.required();
  final streetController = TextController.required();
  final numberController = TextController.required();
  final complementController = TextController.required();
  final latController = TextController();
  final lngController = TextController();

  void clear() {
    zipCodeController.clear();
    cityController.clear();
    stateController.clear();
    neighborController.clear();
    streetController.clear();
    numberController.clear();
    descriptionController.clear();
    complementController.clear();
    latController.clear();
    lngController.clear();
    notify();
  }

  Address get generated => Address(
        neighbor: neighborController.text,
        zipCode: zipCodeController.text,
        city: cityController.text,
        complement: complementController.text,
        description: descriptionController.text,
        state: stateController.text,
        lat: latController.text,
        lng: lngController.text,
        number: numberController.text,
        street: streetController.text,
      );

  void refresh(
    Address address,
  ) {
    neighborController.text = address?.neighbor ?? neighborController.text;
    zipCodeController.text = address?.zipCode ?? zipCodeController.text;
    cityController.text = address?.city ?? cityController.text;
    complementController.text =
        address?.complement ?? complementController.text;
    descriptionController.text =
        address?.description ?? descriptionController.text;
    stateController.text = address?.state ?? stateController.text;
    latController.text = address?.lat ?? latController.text;
    lngController.text = address?.lng ?? lngController.text;
    numberController.text = address?.number ?? numberController.text;
    streetController.text = address?.street ?? streetController.text;
    notify();
  }
}
