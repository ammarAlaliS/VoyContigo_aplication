import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickcar_aplication/core/configs/bloc/scroll_cubit.dart';

class ScrollableContent extends StatefulWidget {
  final Widget child;

  const ScrollableContent({Key? key, required this.child}) : super(key: key);

  @override
  _ScrollableContentState createState() => _ScrollableContentState();
}

class _ScrollableContentState extends State<ScrollableContent> {
  final ScrollController _scrollController = ScrollController();
  double _previousScrollPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    final position = _scrollController.position.pixels;
    final isScrollToBottom = position > _previousScrollPosition;

    // Actualiza solo la posición del scroll
    context.read<ScrollControllerCubit>().updateScrollPosition(position);

    // Actualiza el estado de movimiento hacia el fondo
    context.read<ScrollControllerCubit>().updateIsScrollMovingToBottom(isScrollToBottom);

    _previousScrollPosition = position;
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: widget.child,
    );
  }
}
