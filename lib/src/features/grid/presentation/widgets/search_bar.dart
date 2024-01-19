import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/grid_cubit/grid_cubit.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({
    super.key,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  Timer? _debounce;

  late TextEditingController _controller;

  bool isSearching = false;

  @override
  void initState() {
    _controller = TextEditingController();
    _controller.addListener(() {
      if (_controller.text.isNotEmpty) {
        setState(() => isSearching = true);
      }
      if (_controller.text.isEmpty) {
        setState(() => isSearching = false);
      }
    });
    super.initState();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<GridCubit>().search(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GridCubit, GridState>(
      builder: (context, state) {
        return state.maybeWhen(
          orElse: () {
            return const SizedBox.shrink();
          },
          created: (_, __) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _controller,
                style: const TextStyle(color: Colors.black),
                onChanged: _onSearchChanged,
                onFieldSubmitted: (query) =>
                    context.read<GridCubit>().search(query),
                decoration: InputDecoration(
                  hintText: "Search...",
                  suffixIcon: isSearching
                      ? IconButton(
                          onPressed: () {
                            setState(() => _controller.clear());
                            context.read<GridCubit>().clearSearch();
                          },
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.clear_rounded),
                        )
                      : IconButton(
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.search_rounded),
                        ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}
