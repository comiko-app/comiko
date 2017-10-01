import 'package:comiko/app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

class SearchPopup extends StatelessWidget {
  final Store<AppState> store;
  final TextEditingController _textController = new TextEditingController();

  SearchPopup({@required this.store});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Filtres"),
      ),
      body: new ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: <Widget>[
          new ListTile(
              leading: new Icon(Icons.location_city),
              title: new StoreConnector<AppState, String>(
                converter: (store) => store.state.cityFilter,
                builder: (context, filter) {
                  _textController.text = filter;

                  return new TextField(
                      controller: _textController,
                      decoration: const InputDecoration(
                        hintText: 'Entrer le nom de la ville',
                      ),
                      onSubmitted: (String value) =>
                          store.dispatch(new UpdateCityFilterAction(value)),
                      //onChanged: (String value) =>
                      //    store.dispatch(new UpdateCityFilterAction(value)),
                    );
                },
              )),
          new ListTile(
            leading: new Icon(Icons.attach_money),
            title: new StoreConnector<AppState, double>(
                builder: (context, price) => new Slider(
                      value: price,
                      min: 0.0,
                      max: 100.0,
                      label: '${price.toStringAsFixed(0)}\$',
                      onChanged: (double value) => store.dispatch(
                            new UpdatePriceFilterAction(value),
                          ),
                    ),
                converter: (store) => store.state.priceFilter),
          ),
          new ListTile(
            leading: new Icon(Icons.directions_car),
            title: new Slider(value: 5.0, max: 10.0, onChanged: (_) {}),
          ),
        ],
      ),
    );
  }
}
