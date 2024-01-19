import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/custom_grid_entity.dart';
import '../bloc/grid_cubit/grid_cubit.dart';
import 'show_edit_field_bottom_sheet.dart';

class CustomTableTab extends StatefulWidget {
  const CustomTableTab({
    super.key,
    required this.data,
  });
  final CustomGridEntity data;
  @override
  State<CustomTableTab> createState() => _CustomTableTabState();
}

class _CustomTableTabState extends State<CustomTableTab> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController(text: widget.data.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GridCubit>();
    return GestureDetector(
      onTap: () async {
        final val = await showEditFieldBottomSheet(context, widget.data);
        cubit.updatedValue(widget.data.copyWith(value: val));
        setState(() {
          _controller.text = val;
        });
      },
      child: TextFormField(
        controller: _controller,
        enabled: false,
        decoration: InputDecoration(
          filled: widget.data.searchMatched,
          fillColor: Colors.green,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
        ),
      ),
    );
  }
}
