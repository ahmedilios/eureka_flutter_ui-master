import 'package:altair/altair.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vega/src/widgets/list/list.dart';

export 'package:vega/src/widgets/list/list.dart';

class BlocListWidget<
    S extends ShortModel,
    D extends DetailModel,
    R extends SimpleRepository<S, D>,
    B extends SimpleBloc<S, D, R>> extends StatefulWidget {
  final B bloc;

  final ItemBuilder<S> itemBuilder;
  final WidgetBuilder separatorBuilder;

  final EdgeInsets contentPadding;
  final PageOptions pageOptions;

  final String title;
  final Widget appBar;

  final VoidCallback onCreate;
  final void Function(Set<dynamic> selection) onDelete;

  final bool Function(S item) filter;

  final bool autoLoad;
  final bool infiniteScroll;

  final Widget Function(BuildContext, SimpleState) builderHandler;
  final Widget Function(BuildContext, SimpleEvent) listenerHandler;

  final String emptyMessage;
  final Widget loadingWidget;
  final VoidCallback onRefresh;

  BlocListWidget({
    this.bloc,
    @required this.itemBuilder,
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
    this.loadingWidget,
    this.pageOptions,
    this.infiniteScroll = true,
    this.autoLoad = false,
    this.emptyMessage = "Nenhum item encontrado",
  })  : assert(!(title != null && appBar != null)),
        separatorBuilder = null;

  BlocListWidget.separated({
    this.bloc,
    @required this.itemBuilder,
    @required this.separatorBuilder,
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
    this.loadingWidget,
    this.pageOptions,
    this.infiniteScroll = true,
    this.autoLoad = false,
    this.emptyMessage = "Nenhum item encontrado",
  }) : assert(!(title != null && appBar != null));

  @override
  _BlocListWidgetState createState() => _BlocListWidgetState();
}

class _BlocListWidgetState<
    S extends ShortModel,
    D extends DetailModel,
    R extends SimpleRepository<S, D>,
    B extends SimpleBloc<S, D, R>> extends State<BlocListWidget<S, D, R, B>> {
  @override
  void initState() {
    super.initState();
    if (widget.autoLoad) loadData();
  }

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

  Widget buildSuccessState(
    BuildContext context,
    List<S> briefs,
    bool loading,
    bool hasReachedMax,
  ) =>
      Column(
        children: <Widget>[
          Expanded(
            child: ListWidget(
              items: briefs,
              separatorBuilder: widget.separatorBuilder,
              itemBuilder: widget.itemBuilder,
              contentPadding: widget.contentPadding,
              title: widget.title,
              appBar: widget.appBar,
              onCreate: widget.onCreate,
              onDelete: widget.onDelete,
              filter: widget.filter,
              builderHandler: widget.builderHandler,
              listenerHandler: widget.listenerHandler,
              emptyMessage: widget.emptyMessage,
              onRefresh: widget.onRefresh ?? loadData,
              onLimitReached: loading || hasReachedMax || !widget.infiniteScroll
                  ? null
                  : () => widget.bloc.add(NextEvent()),
            ),
          ),
          if (loading && widget.loadingWidget != null) widget.loadingWidget
        ],
      );

  void loadData() => widget.bloc.add(
        LoadEvent(pageOptions: widget.pageOptions),
      );

  @override
  Widget build(BuildContext context) => BlocConsumer(
        bloc: widget.bloc ?? BlocProvider.of<B>(context),
        listener: (BuildContext context, state) {
          if (widget.listenerHandler != null) {
            final shouldContinue = widget.listenerHandler(context, state);

            if (shouldContinue ?? false) {
              return;
            }
          }

          if (state is FailState<S>) {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.red,
                content: Text(state.error.message),
              ),
            );
          }
        },
        builder: (BuildContext context, state) {
          if (widget.builderHandler != null) {
            final child = widget.builderHandler(context, state);

            if (child != null) {
              return child;
            }
          }

          if (state is UninitializedState ||
              (state is LoadingState && (state.briefs?.isEmpty ?? true))) {
            return buildLoadingState;
          }

          if (state is ContentState) {
            return buildSuccessState(
              context,
              state.briefs ?? [],
              state is LoadingState,
              state.hasReachedMax,
            );
          }

          return Container();
        },
      );
}
