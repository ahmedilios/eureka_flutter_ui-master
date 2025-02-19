import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:vega/src/resources/controllers/notifier.dart';

/// Classe abstrata de item de DropDown
abstract class VegaDropDownItem<T> {
  String get label;
  T get value;
}

/// Item de dropdown onde o [value] é de um tipo [T] qualquer.
///
/// Exemplo:
/// ```
/// class AnyObject {}
///
/// List<AnyObject> myData = [];
/// final controller = DropDownController<DropDownItem<AnyObject>>();
/// controller.items = List<DropDownItem<AnyObject>>.from(
///   myData.map(
///     (value) => DropDownItem<AnyObject>(
///       label: value.toString(),
///       value: value,
///     ),
///   ),
/// );
/// ```
///
/// Alternativamente é possível usar seu próprio modelo como `DropDownItem`
/// implementando a classe [VegaDropDownItem], por exemplo:
/// ```
/// class AnyObject implements VegaDropDownItem{
///   @override
///   String get label => 'banana';
///   @override
///   AnyObject get value => this;
/// }
/// ```
/// Dessa forma uma lista de `AnyObject` seria aceita pelo [DropDownController]
/// como uma lista válida de itens.
/// ```
/// List<AnyObject> myData = [];
/// final controller = DropDownController<AnyObject>();
/// controller.items = myData;
class DropDownItem<T> with EquatableMixin implements VegaDropDownItem<T> {
  @override
  final String label;
  @override
  final T value;

  DropDownItem({
    @required this.label,
    @required this.value,
  });

  @override
  List get props => [value];
}

/// Item de dropdown onde o [value] é do tipo `String`.
///
/// Exemplo:
/// ```
/// final controller = DropDownController<DropDownItemString>();
/// controller.items = List<DropDownItemString>.from(
///   ['apple', 'avocado', 'banana'].map(
///     (value) => DropDownItemString.homonymous(value),
///   ),
/// );
/// ```
class DropDownItemString
    with EquatableMixin
    implements VegaDropDownItem<String> {
  @override
  final String label;
  @override
  final String value;

  @override
  List get props => [value];

  DropDownItemString({
    @required this.label,
    @required this.value,
  });

  /// Cria um item de mesmo [label] e [value].
  factory DropDownItemString.homonymous(String value) => DropDownItemString(
        label: value,
        value: value,
      );
}

/// Item de dropdown onde o [value] é do tipo `int`.
///
/// Exemplo:
/// ```
/// final controller = DropDownController<DropDownItemInt>();
/// controller.items = List<DropDownItemInt>.from(
///   [1, 2, 3].map(
///     (value) => DropDownItemInt.homonymous(value),
///   ),
/// );
/// ```
class DropDownItemInt with EquatableMixin implements VegaDropDownItem<int> {
  @override
  final String label;
  @override
  final int value;

  @override
  List get props => [value];

  DropDownItemInt({
    @required this.label,
    @required this.value,
  });

  /// Cria um item com um [value] e sua representação em `String` como [label].
  factory DropDownItemInt.homonymous(int value) => DropDownItemInt(
        label: value?.toString(),
        value: value,
      );
}

/// Controlador do widget de DropDown.
///
/// Notifica o widget filho quando há alteração na lista de itens ou no valor
/// selecionado.
///
/// Se utilizar este controlador em outro widget senão o [DropDownWidget],
/// lembre-se de registrar a função de notificação com o `setState` do widget
/// que deve ser atualizado na sua inicialização. Ex:
/// ```
/// @override
/// void initState() {
///   super.initState();
///   widget.controller?.register(() => setState(() => null));
/// }
/// ```
class DropDownController<T extends VegaDropDownItem>
    extends NotifierController {
  Iterable<T> _items;
  T _selected;

  /// Não permite que o item selecionado seja `null`, caso haja validação de um
  /// formulário.
  final bool requireSelect;

  DropDownController({
    this.requireSelect = false,
  });

  /// Atualiza a lista de itens disponíveis e notifica o widget filho.
  set items(Iterable<T> items) {
    _items = items;
    notify();
  }

  /// Seleciona um [item] e notifica o widget filho.
  set selected(T item) {
    _selected = item;
    notify();
  }

  /// Seleciona um item pelo seu valor e notifica o widget filho.
  ///
  /// Caso o valor não seja a propriedade [value] de nenhum item da lista de
  /// itens disponíveis, nada ocorre.
  void selectByValue(dynamic value) {
    selected = items.firstWhere(
      (item) =>
          item.value.runtimeType == value.runtimeType && item.value == value,
      orElse: () => null,
    );
  }

  /// Lista de itens disponíveis para seleção.
  Iterable<T> get items => _items;

  /// Retorna o item selecionado, se houver.
  T get selected => _selected;
}
