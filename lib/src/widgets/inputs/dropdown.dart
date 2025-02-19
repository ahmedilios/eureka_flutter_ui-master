import 'package:flutter/material.dart';
import '../../styles/input.dart';
import '../../resources/controllers/dropdown.dart';

export '../../resources/controllers/dropdown.dart';

/// Widget de Dropdown.
///
/// Funciona com um [DropDownController] que estabelece os itens disponíveis e
/// recupera a seleção do usuário. A customização é feita por uma instância da
/// [VegaInputStyle].
///
/// Exemplo:
/// ```
/// DropDownWidget(
///   controller: DropDownController(),
///   style: VegaInputStyle(
///     innerDecoration: InputDecoration(
///       border: OutlineInputBorder(
///         borderRadius: BorderRadius.circular(10),
///       ),
///     ),
///   ),
/// ),
/// ```
class DropDownWidget<T extends VegaDropDownItem> extends StatefulWidget {
  final DropDownController<T> controller;
  final VegaInputStyle style;
  final String hint;

  DropDownWidget({
    @required this.controller,
    this.style = const VegaInputStyle(),
    this.hint = 'Selecione uma opção',
  }) : assert(controller != null);

  @override
  _DropDownWidgetState createState() => _DropDownWidgetState<T>();
}

class _DropDownWidgetState<T extends VegaDropDownItem>
    extends State<DropDownWidget> {
  @override
  void initState() {
    super.initState();
    widget.controller?.register(() => setState(() => null));
  }

  @override
  Widget build(BuildContext context) => Center(
        child: Container(
          decoration: widget.style?.outerDecoration,
          padding: widget.style?.padding,
          child: DropdownButtonFormField<T>(
            isExpanded: true,
            hint: Text(
              widget.hint,
              style: widget.style?.textStyle,
            ),
            value: widget.controller?.selected,
            validator: (selection) =>
                (widget.controller?.requireSelect ?? false) && selection == null
                    ? 'Campo obrigatório'
                    : null,
            onChanged: (value) => setState(
              () => widget.controller?.selected = value,
            ),
            decoration: widget.style?.innerDecoration,
            style: widget.style?.textStyle,
            items: widget.controller?.items
                ?.map(
                  (item) => DropdownMenuItem<T>(
                    value: item,
                    child: Text(item.label),
                  ),
                )
                ?.toList(),
          ),
        ),
      );
}
