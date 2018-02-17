import 'package:comiko/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class SearchPopup extends StatelessWidget {
  final Store<AppState> store;

  static const double minPrice = 0.0;
  static const double maxPrice = 100.0;

  static const double minDistance = 0.0;
  static const double maxDistance = 600.0;

  const SearchPopup({@required this.store});

  @override
  Widget build(BuildContext context) => new AlertDialog(
        actions: [
          new FlatButton(
            onPressed: () => store.dispatch(new ResetFiltersAction()),
            child: const Text('Réinitialiser'),
          ),
          new FlatButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
        title: const Text('Filtres'),
        content: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
              leading: new Icon(Icons.location_city),
              title: new StoreConnector<AppState, String>(
                converter: (store) => store.state.cityFilter,
                builder: (context, city) {
                  final cityFilterTextController =
                      new TextEditingController(text: store.state.cityFilter)
                        ..selection = new TextSelection(
                          baseOffset: store.state.cityFilter.length,
                          extentOffset: store.state.cityFilter.length,
                        );
                  return new TextField(
                    controller: cityFilterTextController,
                    decoration: const InputDecoration(
                      hintText: 'Entrer le nom de la ville',
                    ),
                    onSubmitted: (value) =>
                        store.dispatch(new UpdateCityFilterAction(value)),
                  );
                },
              ),
            ),
            new ListTile(
              leading: new Icon(Icons.attach_money),
              title: new StoreConnector<AppState, double>(
                  builder: (context, price) => new Slider(
                        value: price,
                        min: minPrice,
                        max: maxPrice,
                        label: '${price.toStringAsFixed(0)}\$',
                        onChanged: (value) => store.dispatch(
                              new UpdatePriceFilterAction(value),
                            ),
                      ),
                  converter: (store) => store.state.priceFilter),
            ),
            new ListTile(
              leading: new Icon(Icons.directions_car),
              title: new StoreConnector<AppState, int>(
                  builder: (context, value) => new Slider(
                      value: value.roundToDouble(),
                      min: minDistance,
                      max: maxDistance,
                      label: '${value}km',
                      onChanged: (value) => store.dispatch(
                          new UpdateDistanceFilterAction(value.round()))),
                  converter: (store) => store.state.distanceFilter),
            ),
          ],
        ),
      );
}
