import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/layers/data/model/location.dart';
import 'package:weather/layers/logic/location/location_cubit.dart';

import '../../../injection_container.dart';

class CustomSearch extends SearchDelegate {

  final locationCubit = sl<LocationCubit>();

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(onPressed: () {
      Navigator.pop(context);
      locationCubit.resetLocations();
    }, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return ListView(
      children: [
        Text("Hello")
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    locationCubit.getLocations(query);
    return BlocBuilder<LocationCubit, LocationState>(
      bloc: locationCubit,
      builder: (context, state) {
        print(state);
        if (state is LocationLoaded) {
          return ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
            itemCount: state.locations.length,
            itemBuilder: (context, index) {
              Location location = state.locations[index];
              return InkWell(
                onTap: () {
                  Navigator.of(context).pop(location.name + " " + location.country);
                  locationCubit.resetLocations();
                },
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      location.name + ", " + location.country,
                      style: TextStyle(
                          color: Colors.black
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
