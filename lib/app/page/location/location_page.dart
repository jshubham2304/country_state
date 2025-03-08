import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countries_states/app/page/location/bloc/location_cubit.dart';
import 'package:flutter_countries_states/app/page/location/bloc/location_state.dart';
import 'package:flutter_countries_states/app/page/location/widget/dropdown_widget.dart';

class LocationView extends StatelessWidget {
  const LocationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countries & States'),
      ),
      body: BlocConsumer<LocationCubit, LocationState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: Colors.red,
                action: SnackBarAction(
                  label: 'Dismiss',
                  textColor: Colors.white,
                  onPressed: () {
                    context.read<LocationCubit>().resetError();
                  },
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LocationDropdown(
                  labelText: 'Country',
                  items: state.countries,
                  value: state.selectedCountry,
                  isLoading: state.isLoadingCountries,
                  onChanged: (country) {
                    if (country != null) {
                      context.read<LocationCubit>().selectCountry(country);
                    }
                  },
                ),
                const SizedBox(height: 24),
                LocationDropdown(
                  labelText: 'State',
                  items: state.states,
                  value: state.selectedState,
                  isLoading: state.isLoadingStates,
                  hintText: state.selectedCountry == null ? 'Select a country first' : 'Select a state',
                  onChanged: (value) {
                    if (state.selectedCountry == null) return;
                    context.read<LocationCubit>().selectState(value);
                  },
                ),
                const SizedBox(height: 32),
                if (state.selectedCountry != null && state.selectedState != null)
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Selected Location:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Country: ${state.selectedCountry}',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'State: ${state.selectedState}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
