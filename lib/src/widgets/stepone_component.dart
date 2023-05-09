import 'package:abac_challenge/constants.dart';
import 'package:abac_challenge/src/bloc/myspaceship/diagnosestepper/diagnosestepper_bloc.dart';
import 'package:abac_challenge/src/bloc/myspaceship/diagnosestepper/diagnosestepper_event.dart';
import 'package:abac_challenge/src/bloc/myspaceship/diagnosestepper/diagnosestepper_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Step stepOne() {
  var currentQuantity = 1;
  return Step(
    title: Text('Create estimate'),
    content: BlocBuilder<DiagnoseStepperBloc, DiagnoseStepperState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Task 1'),
            // list of installed components
            Container(
              constraints: BoxConstraints(maxWidth: 300),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: state.selectedComponents.length,
                itemBuilder: (context, index) {
                  var component = state.selectedComponents[index];
                  return ListTile(
                    title: Text(component.name),
                    subtitle: Text('Quantity: ${component.quantity}'),
                    trailing: IconButton(
                      onPressed: () {
                        context.read<DiagnoseStepperBloc>().add(
                              DiagnoseStepperAddComponent(
                                spaceshipComponent: component,
                                quantity: -1,
                              ),
                            );
                      },
                      icon: Icon(Icons.remove),
                    ),
                  );
                },
              ),
            ),
            _gap(),
            // search component
            Row(
              children: [
                // search bar field
                Container(
                  constraints: BoxConstraints(maxWidth: 300),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Search component',
                      icon: Icon(Icons.search),
                    ),
                    onChanged: (value) {
                      context
                          .read<DiagnoseStepperBloc>()
                          .add(DiagnoseStepperSearch(query: value));
                    },
                  ),
                ),
                _gap(),
                // quantity field
                Container(
                  constraints: BoxConstraints(maxWidth: 70),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    initialValue: currentQuantity.toString(),
                    decoration: InputDecoration(
                      labelText: 'Quantity',
                    ),
                    onChanged: (value) {
                      currentQuantity = int.parse(value);
                    },
                  ),
                )
              ],
            ),
            _gap(),
            // list of searched components
            if (state.searchedComponents.isNotEmpty)
              Container(
                constraints: BoxConstraints(maxWidth: 350),
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                  shrinkWrap: true,
                  // this paginate should be done in the backend side
                  // now, we are just limiting the search to 5 results
                  itemCount: state.searchedComponents.length > 5
                      ? 5
                      : state.searchedComponents.length,
                  itemBuilder: (context, index) {
                    var component = state.searchedComponents[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(component.name),
                        trailing: CircleAvatar(
                          radius: 30,
                          backgroundColor: kPrimaryColor,
                          child: IconButton(
                            onPressed: () {
                              context.read<DiagnoseStepperBloc>().add(
                                    DiagnoseStepperAddComponent(
                                      spaceshipComponent: component,
                                      quantity: currentQuantity,
                                    ),
                                  );
                            },
                            icon: Icon(Icons.add),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            if (state.searchedComponents.isEmpty) Text('No components found'),
          ],
        );
      },
    ),
    isActive: true,
  );
}

SizedBox _gap() {
  return const SizedBox(
    height: 20,
    width: 20,
  );
}
