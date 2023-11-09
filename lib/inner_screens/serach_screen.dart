import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:news_app/services/utils.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchEditingController;
  late final FocusNode focusNode;

  @override
  void initState() {
    _searchEditingController = TextEditingController();
    focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _searchEditingController.dispose();
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context: context).getScreenSize;
    final Color color = Utils(context: context).getColor;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            body: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    IconlyLight.arrowLeft2,
                  ),
                ),
                Flexible(
                    child: TextField(
                  focusNode: focusNode,
                  controller: _searchEditingController,
                  style: TextStyle(color: color),
                  autofocus: true,
                  textInputAction: TextInputAction.search,
                  keyboardType: TextInputType.text,
                  onEditingComplete: () {},
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                      bottom: 8 / 5,
                    ),
                    hintText: 'Search',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    suffix: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          _searchEditingController.clear();
                          focusNode.unfocus();
                          setState(() {});
                        },
                        child: const Icon(
                          Icons.close,
                          size: 18,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ))
              ],
            )
          ],
        )),
      ),
    );
  }
}
