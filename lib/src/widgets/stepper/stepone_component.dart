import 'package:abac_challenge/constants.dart';
import 'package:abac_challenge/src/bloc/myspaceship/diagnosestepper/diagnosestepper_bloc.dart';
import 'package:abac_challenge/src/bloc/myspaceship/diagnosestepper/diagnosestepper_event.dart';
import 'package:abac_challenge/src/bloc/myspaceship/diagnosestepper/diagnosestepper_state.dart';
import 'package:abac_challenge/src/models/spaceship_component_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Step buildStepOne(BuildContext context) {
  var currentQuantity = 1;
  return Step(
    label: Center(child: Text('Creaza deviz')),
    title: Text(''),
    content: BlocBuilder<DiagnoseStepperBloc, DiagnoseStepperState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Task 1',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            _gap(),
            // list of installed components
            Table(
              border: TableBorder(
                horizontalInside: BorderSide(
                  color: Colors.grey,
                  width: 2,
                ),
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
              children: [
                _buildTableHeader(),
                ...state.selectedComponents.map(
                  (component) {
                    return _getRowForComponent(component, context);
                  },
                ),
              ],
            ),
            _gap(),
            // search component
            Row(
              children: [
                // search bar field
                Container(
                  constraints: BoxConstraints(maxWidth: 200),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Cauta componenta',
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
                  constraints: BoxConstraints(maxWidth: 60),
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    initialValue: currentQuantity.toString(),
                    decoration: InputDecoration(
                      labelText: 'Cantitate',
                    ),
                    onChanged: (value) {
                      try {
                        currentQuantity = int.parse(value);
                      } catch (e) {
                        currentQuantity = 1;
                      }
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
            if (state.searchedComponents.isEmpty) Text('Niciun rezultat'),
          ],
        );
      },
    ),
    isActive:
        context.read<DiagnoseStepperBloc>().state.currentStepperIndex >= 0,
    state: context.read<DiagnoseStepperBloc>().state.currentStepperIndex == 0
        ? StepState.editing
        : StepState.complete,
  );
}

TableRow _buildTableHeader() {
  return TableRow(
    children: const [
      TableCell(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Produs',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      TableCell(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child:
              Text('Cantitate', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
      TableCell(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Pret unitar',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
      TableCell(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Total',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      SizedBox(),
    ],
  );
}

TableRow _getRowForComponent(
    SpaceshipComponent component, BuildContext context) {
  return TableRow(
    children: [
      TableCell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            component.name,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '${component.quantity}',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '${component.price}',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '${component.quantityPrice}',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),
        ),
      ),
      TableCell(
        child: IconButton(
          onPressed: () {
            context.read<DiagnoseStepperBloc>().add(
                  DiagnoseStepperRemoveComponent(
                    spaceshipComponent: component,
                  ),
                );
          },
          icon: Icon(Icons.delete),
          splashRadius: 15,
        ),
      ),
    ],
  );
}

SizedBox _gap() {
  return const SizedBox(
    height: 20,
    width: 20,
  );
}
