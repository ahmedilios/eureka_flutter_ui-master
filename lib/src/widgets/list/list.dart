import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:altair/altair.dart';

typedef ItemBuilder<S> = Widget Function(
  BuildContext context,
  S item,
  SelectionController selection,
  SlidableController slidable,
);

class SelectionController {
  final bool mode;
  final bool isSelected;
  final VoidCallback toggle;
  final VoidCallback modeToggle;

  const SelectionController({
    this.mode = false,
    this.isSelected = false,
    @required this.toggle,
    @required this.modeToggle,
  });
}

class ListWidget extends StatefulWidget {
  final Iterable items;
  final ItemBuilder itemBuilder;
  final WidgetBuilder separatorBuilder;

  final EdgeInsets contentPadding;

  final String title;
  final Widget appBar;

  final VoidCallback onCreate;
  final void Function(Set<dynamic> selection) onDelete;

  final bool Function(dynamic item) filter;

  final Widget Function(BuildContext, SimpleState) builderHandler;
  final Widget Function(BuildContext, SimpleEvent) listenerHandler;

  final String emptyMessage;

  final VoidCallback onLimitReached;
  final VoidCallback onRefresh;

  ListWidget({
    @required this.items,
    @required this.itemBuilder,
    this.separatorBuilder,
    this.title,
    this.appBar,
    this.contentPadding = const EdgeInsets.symmetric(
      vertical: 16.0,
    ),
    this.onCreate,
    this.onDelete,
    this.onRefresh,
    this.filter,
    this.builderHandler,
    this.listenerHandler,
    this.onLimitReached,
    this.emptyMessage = "Nenhum item encontrado",
  }) : assert(!(title != null && appBar != null));

  static ItemBuilder noSelectItemBuilder({
    @required String Function(dynamic) getTitle,
    @required Widget Function(dynamic) getLeading,
    VoidCallback Function(dynamic) onDetails,
    VoidCallback Function(dynamic) onEditItem,
    VoidCallback Function(dynamic) onDeleteItem,
  }) =>
      (
        BuildContext context,
        dynamic item,
        SelectionController selection,
        SlidableController slidable,
      ) {
        final leading = getLeading(item);
        final title = getTitle(item);

        final details = onDetails != null ? onDetails(item) : null;
        final editItem = onEditItem != null ? onEditItem(item) : null;
        final deleteItem = onDeleteItem != null ? onDeleteItem(item) : null;

        final child = ListTile(
          leading: leading,
          contentPadding: const EdgeInsets.only(left: 16.0),
          title: Text(
            title,
            overflow: TextOverflow.fade,
            maxLines: 1,
            softWrap: false,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: null,
          ),
          onTap: details,
        );

        return Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.20,
          controller: slidable,
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'Editar',
              color: Colors.green,
              icon: Icons.edit,
              onTap: editItem,
            ),
            IconSlideAction(
              caption: 'Remover',
              color: Colors.red,
              icon: Icons.delete,
              onTap: deleteItem,
            ),
          ],
          child: child,
        );
      };

  static ItemBuilder defaultItemBuilder({
    @required String Function(dynamic) getTitle,
    VoidCallback Function(dynamic) onDetails,
    VoidCallback Function(dynamic) onEditItem,
    VoidCallback Function(dynamic) onDeleteItem,
  }) =>
      (
        BuildContext context,
        dynamic item,
        SelectionController selection,
        SlidableController slidable,
      ) {
        final selected = selection.isSelected
            ? Icon(Icons.check_box)
            : Icon(Icons.check_box_outline_blank);

        final leading = selection.mode ? selected : Icon(Icons.message);

        final title = getTitle(item);

        final details = onDetails != null ? onDetails(item) : null;
        final editItem = onEditItem != null ? onEditItem(item) : null;
        final deleteItem = onDeleteItem != null ? onDeleteItem(item) : null;

        final child = ListTile(
          leading: leading,
          contentPadding: const EdgeInsets.only(left: 16.0),
          title: Text(
            title,
            overflow: TextOverflow.fade,
            maxLines: 1,
            softWrap: false,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: IconButton(
            icon: Icon(Icons.arrow_forward_ios),
            onPressed: null,
          ),
          onTap: selection.mode ? selection.toggle : details,
          onLongPress: selection.modeToggle,
        );

        if (selection.mode) {
          return child;
        } else {
          return Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.20,
            controller: slidable,
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Editar',
                color: Colors.green,
                icon: Icons.edit,
                onTap: editItem,
              ),
              IconSlideAction(
                caption: 'Remover',
                color: Colors.red,
                icon: Icons.delete,
                onTap: deleteItem,
              ),
            ],
            child: child,
          );
        }
      };

  @override
  _ListWidgetState createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  bool selectMode;
  Set<dynamic> selected;
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();

    selectMode = false;
    selected = {};
    scrollController = ScrollController();
  }

  VoidCallback selectAll(Set<dynamic> ids) => () {
        setState(() {
          selected = ids;
        });
      };

  void cancelSelectMode() {
    setState(() {
      selected = {};
      selectMode = false;
    });
  }

  bool handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        this.scrollController.position.extentAfter == 0) {
      widget.onLimitReached?.call();
    }

    return false;
  }

  VoidCallback selectModeToggle(dynamic id, SlidableController controller) =>
      () {
        setState(() {
          if (selectMode) {
            selected = {};
          } else {
            selected = {id};
          }

          selectMode = !selectMode;

          controller.activeState?.close();
        });
      };

  VoidCallback selectToggle(dynamic id) => () {
        setState(() {
          if (selected.contains(id)) {
            selected.remove(id);
            if (selected.isEmpty) {
              selectMode = false;
            }
          } else {
            selected.add(id);
          }
        });
      };

  Material get buildLoadingState => Material(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (widget.title != null)
              AppBar(
                title: Text(
                  widget.title,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              )
            else if (widget.appBar != null)
              widget.appBar,
            Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      );

  Widget buildSuccessState(BuildContext context, Iterable briefs) {
    final ids = briefs.map<dynamic>((s) => s.id).toSet();

    final slidableController = SlidableController();

    var children = briefs.where(widget.filter ?? (_) => true).map<Widget>((s) {
      final selectionController = SelectionController(
        mode: this.selectMode,
        isSelected: this.selected.contains(s.id),
        toggle: this.selectToggle(s.id),
        modeToggle: this.selectModeToggle(s.id, slidableController),
      );

      return widget.itemBuilder(
        context,
        s,
        selectionController,
        slidableController,
      );
    }).toList();

    if (widget.separatorBuilder != null) {
      children = children.fold<List<Widget>>(
        <Widget>[],
        (acc, elem) => acc..add(elem)..add(widget.separatorBuilder(context)),
      );

      if (children.isNotEmpty) {
        children.removeLast();
      }
    }

    if (children.isEmpty) {
      children = <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 24.0,
          ),
          child: Text(
            widget.emptyMessage,
            textAlign: TextAlign.center,
            maxLines: 2,
          ),
        ),
      ];
    }

    return Material(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (widget.title != null)
            AppBar(
              title: selectMode
                  ? null
                  : Text(
                      widget.title,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
              actions: selectMode
                  ? <Widget>[
                      selected.length != ids.length
                          ? IconButton(
                              icon: Icon(Icons.select_all),
                              tooltip: 'Selecionar todos',
                              onPressed: selectAll(ids),
                            )
                          : IconButton(
                              icon: Icon(Icons.check_box_outline_blank),
                              tooltip: 'Deselecionar todos',
                              onPressed: cancelSelectMode,
                            ),
                      if (widget.onDelete != null)
                        IconButton(
                          icon: Icon(Icons.delete),
                          tooltip: 'Remover selecionados',
                          onPressed: () => widget.onDelete(selected),
                        ),
                    ]
                  : null,
            )
          else if (widget.appBar != null)
            widget.appBar,
          Expanded(
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      cancelSelectMode();
                      widget.onRefresh?.call();
                    },
                    child: LayoutBuilder(
                      builder: (context, constraints) =>
                          NotificationListener<ScrollNotification>(
                        onNotification: handleScrollNotification,
                        child: SingleChildScrollView(
                          controller: scrollController,
                          child: Container(
                            constraints: BoxConstraints(
                              minHeight: constraints.biggest.height + 0.5,
                            ),
                            padding: widget.contentPadding,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: children,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (widget.onCreate != null)
                  if (selectMode)
                    Container(
                      alignment: Alignment.bottomRight,
                      margin: const EdgeInsets.all(16.0),
                      child: FloatingActionButton(
                        onPressed: cancelSelectMode,
                        child: Icon(Icons.close),
                      ),
                    )
                  else
                    Container(
                      alignment: Alignment.bottomRight,
                      margin: const EdgeInsets.all(16.0),
                      child: FloatingActionButton(
                        onPressed: widget.onCreate,
                        child: Icon(Icons.add),
                      ),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => buildSuccessState(
        context,
        widget.items,
      );
}
