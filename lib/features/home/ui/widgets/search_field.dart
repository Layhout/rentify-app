import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key, required this.onSearch});

  final ValueSetter<String> onSearch;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController _searchController = TextEditingController();

  bool _showClearButton = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _showClearButton = _searchController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      textInputAction: TextInputAction.search,
      onSubmitted: widget.onSearch,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        hintText: "Search",
        suffixIcon: _showClearButton
            ? InkWell(
                onTap: () {
                  _searchController.clear();
                  widget.onSearch("");
                },
                child: Icon(Icons.close),
              )
            : null,
      ),
    );
  }
}
