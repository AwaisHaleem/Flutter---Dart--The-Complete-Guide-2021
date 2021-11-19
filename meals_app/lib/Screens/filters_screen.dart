import 'package:flutter/material.dart';
import 'package:meals_app/Widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const rountName = '/filters';
  final Function savedFilter;
  final Map<String, bool> currentFilters;
  FiltersScreen({required this.savedFilter, required this.currentFilters});

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegan = false;
  var _vegetarian = false;
  var _lectoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten']!;
    _vegan = widget.currentFilters['vegan']!;
    _vegetarian = widget.currentFilters['vegetarian']!;
    _lectoseFree = widget.currentFilters['lectose']!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Filters"),
        actions: [
          IconButton(
              onPressed: () {
                final selectedFilters = {
                  'gluten': _glutenFree,
                  'lectose': _lectoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian
                };
                widget.savedFilter(selectedFilters);
              },
              icon: Icon(Icons.save))
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              "Adjust Your Meal Selection",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchListTile(
                  "Gluten-free",
                  "Only includes gluten free meals.",
                  _glutenFree,
                  (newValure) {
                    setState(
                      () {
                        _glutenFree = newValure;
                      },
                    );
                  },
                ),
                buildSwitchListTile(
                  "Lectose-free",
                  "Only includes lectose free meals.",
                  _lectoseFree,
                  (newValure) {
                    setState(
                      () {
                        _lectoseFree = newValure;
                      },
                    );
                  },
                ),
                buildSwitchListTile(
                  "Vegetarian",
                  "Only includes vegetarian meals.",
                  _vegetarian,
                  (newValure) {
                    setState(
                      () {
                        _vegetarian = newValure;
                      },
                    );
                  },
                ),
                buildSwitchListTile(
                  "Vegan",
                  "Only includes vegan meals.",
                  _vegan,
                  (newValure) {
                    setState(
                      () {
                        _vegan = newValure;
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  SwitchListTile buildSwitchListTile(String title, String description,
      bool currentValue, Function(bool) updateValue) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(description),
      value: currentValue,
      onChanged: updateValue,
    );
  }
}
