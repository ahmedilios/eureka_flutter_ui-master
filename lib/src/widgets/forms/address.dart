import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vega/src/resources/controllers/text.dart';
import 'package:vega/src/styles/input.dart';
import 'package:vega/src/widgets/forms/address/model.dart';
import 'package:vega/src/widgets/inputs/text.dart';

import 'address/bloc/bloc.dart';
import 'address/controller.dart';
import 'address/options.dart';

export 'address/options.dart';
export 'address/controller.dart';
export 'address/model.dart';

/// Formulário de endereço padrão.
///
/// Cria um formulário de validação com todos os campos habilitados e busca
/// automaticamente um endereço pelo CEP.
///
/// **Atenção**: Para que a troca de foco entre os campos funcione, deve haver
/// um [MaterialApp] ou [Scaffold] ancestral em algum ponto da árvore.
class AddressDataForm extends StatefulWidget {
  /// Controlador de endereço, necessário para o fluxo de dados.
  final AddressDataController controller;

  /// Endereço para ser inicialmente preenchido.
  final Address initial;

  /// Foco para o próximo nó caso houver outro formulário na sequência.
  ///
  /// Caso esta propriedade esteja `null`, o último campo esconderá o teclado.
  final FocusNode nextFocus;

  /// Habilita a busca automática de endereço pelo campo `zipCode`.
  final bool autoSearch;

  /// Espaçamento entre os campos.
  final double runSpacing;

  /// Estilo para os campos.
  final VegaInputStyle style;

  /// Opções de visibilidade dos campos.
  ///
  /// Define quais campos devem ou não aparecer.
  /// Todos os campos a serem exibidos
  final AddressDisplayOptions displayOptions;

  /// Opções de rótulo dos campos.
  final AddressLabelOptions labelOptions;

  AddressDataForm({
    @required this.controller,
    this.initial,
    this.nextFocus,
    this.autoSearch = true,
    this.runSpacing = 0.0,
    this.style = const VegaInputStyle(
      textCapitalization: TextCapitalization.words,
    ),
    this.labelOptions = const AddressLabelOptions(),
    this.displayOptions = const AddressDisplayOptions(),
  }) : assert(controller != null);

  @override
  _AddressDataFormState createState() => _AddressDataFormState();
}

class _AddressDataFormState extends State<AddressDataForm> {
  AddressBloc addressBloc;
  Map<GenericTextController, bool> controllerMap;

  @override
  void initState() {
    super.initState();
    widget.controller?.register(() => setState(() => null));
    addressBloc = AddressBloc()
      ..add(
        AddressSelect(
          address: widget.initial,
        ),
      );
    controllerMap = {
      widget.controller.descriptionController:
          widget.displayOptions.hasDescription,
      widget.controller.zipCodeController: widget.displayOptions.hasZipCode,
      widget.controller.cityController: widget.displayOptions.hasStateCity,
      widget.controller.neighborController: widget.displayOptions.hasNeighbor,
      widget.controller.streetController: widget.displayOptions.hasStreet,
      widget.controller.numberController: widget.displayOptions.hasNumber,
      widget.controller.complementController:
          widget.displayOptions.hasComplement,
    };
  }

  @override
  void dispose() {
    addressBloc?.close();
    super.dispose();
  }

  GenericTextController get lastController => controllerMap.entries
      .lastWhere(
        (entry) => entry.value,
        orElse: () => null,
      )
      ?.key;

  TextInputAction _action(GenericTextController controller) =>
      controller == lastController
          ? TextInputAction.done
          : TextInputAction.next;

  Widget _buildField({
    GenericTextController controller,
    GenericTextController nextController,
    String label = '',
    TextInputType type = TextInputType.text,
    Function(String) onChanged,
  }) =>
      VegaTextField(
        controller: controller,
        style: widget.style,
        next: nextController?.focusNode,
        textInputAction: _action(controller),
        keyboardType: type,
        onChanged: onChanged,
        label: label,
      );

  Widget get _description => _buildField(
        controller: widget.controller.descriptionController,
        nextController: widget.controller.zipCodeController,
        label: widget.labelOptions.description,
      );

  Widget get _zipCodeField => _buildField(
        controller: widget.controller.zipCodeController,
        nextController: widget.controller.stateController,
        type: TextInputType.number,
        label: widget.labelOptions.zipCode,
        onChanged: !widget.autoSearch
            ? null
            : (zipCode) {
                if (zipCode.length == 9) {
                  addressBloc.add(
                    AddressFind(zipCode: zipCode),
                  );
                }
              },
      );

  Widget get _stateField => _buildField(
        controller: widget.controller.stateController,
        nextController: widget.controller.cityController,
        label: widget.labelOptions.state,
      );

  Widget get _cityField => _buildField(
        controller: widget.controller.cityController,
        nextController: widget.controller.neighborController,
        label: widget.labelOptions.city,
      );

  Widget get _neighborField => _buildField(
        controller: widget.controller.neighborController,
        nextController: widget.controller.streetController,
        label: widget.labelOptions.neighbor,
      );

  Widget get _streetField => _buildField(
        controller: widget.controller.streetController,
        nextController: widget.controller.numberController,
        label: widget.labelOptions.street,
      );

  Widget get _numberField => _buildField(
        controller: widget.controller.numberController,
        nextController: widget.controller.complementController,
        type: TextInputType.number,
        label: widget.labelOptions.number,
      );

  Widget get _complementField => _buildField(
        controller: widget.controller.complementController,
        label: widget.labelOptions.complement,
      );

  Widget get _stateCityFields => Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.36,
              child: _stateField,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.52,
              child: _cityField,
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => BlocListener(
        bloc: addressBloc,
        listener: (context, state) {
          if (state is AddressSuccess && state.selectedAddress != null) {
            widget.controller?.refresh(state.selectedAddress);
          }
        },
        child: Wrap(
          runSpacing: widget.runSpacing,
          children: [
            if (widget.displayOptions.hasDescription) _description,
            if (widget.displayOptions.hasZipCode) _zipCodeField,
            if (widget.displayOptions.hasStateCity) _stateCityFields,
            if (widget.displayOptions.hasNeighbor) _neighborField,
            if (widget.displayOptions.hasStreet) _streetField,
            if (widget.displayOptions.hasNumber) _numberField,
            if (widget.displayOptions.hasComplement) _complementField,
          ],
        ),
      );
}
