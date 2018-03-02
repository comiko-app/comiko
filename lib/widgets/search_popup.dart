import 'package:comiko/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class SearchPopup extends StatelessWidget {
  static const double minPrice = 0.0;
  static const double maxPrice = 100.0;

  static const double minDistance = 0.0;
  static const double maxDistance = 600.0;

  const SearchPopup();

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of(context).store;
    return AlertDialog(
      actions: [
        FlatButton(
          onPressed: () => store.dispatch(ResetFiltersAction()),
          child: Text('Réinitialiser'),
        ),
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('OK'),
        ),
      ],
      title: Text('Filtres'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.location_city),
            title: StoreConnector<AppState, String>(
              converter: (store) => store.state.cityFilter,
              builder: (context, city) {
                final cityFilterTextController =
                    TextEditingController(text: store.state.cityFilter)
                      ..selection = TextSelection(
                        baseOffset: store.state.cityFilter.length,
                        extentOffset: store.state.cityFilter.length,
                      );
                return TextField(
                  controller: cityFilterTextController,
                  decoration: InputDecoration(
                    hintText: 'Entrer le nom de la ville',
                  ),
                  onSubmitted: (value) =>
                      store.dispatch(UpdateCityFilterAction(value)),
                );
              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.attach_money),
            title: StoreConnector<AppState, double>(
                builder: (context, price) => Slider(
                      value: price,
                      min: minPrice,
                      max: maxPrice,
                      label: '${price.toStringAsFixed(0)}\$',
                      onChanged: (value) => store.dispatch(
                            UpdatePriceFilterAction(value),
                          ),
                    ),
                converter: (store) => store.state.priceFilter),
          ),
          ListTile(
            leading: Icon(Icons.directions_car),
            title: StoreConnector<AppState, int>(
                builder: (context, value) => Slider(
                    value: value.roundToDouble(),
                    min: minDistance,
                    max: maxDistance,
                    label: '${value}km',
                    onChanged: (value) => store
                        .dispatch(UpdateDistanceFilterAction(value.round()))),
                converter: (store) => store.state.distanceFilter),
          ),
        ],
      ),
    );
  }
}
