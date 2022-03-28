import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../dto/employee.dart';
import '../service/employee_provider.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

var items = [
  'Item 1',
  'Item 2',
  'Item 3',
  'Item 4',
  'Item 5',
];

final typesEmployee = [
  "jhosep",
  "Diego",
  "Ximena",
  "Virginia",
  "Abel",
];

final typesEmployee_map = {
  1: "jhosep",
  2: "Diego",
  3: "Ximena",
  4: "Virginia",
  5: "Abel"
};

class _HomePageState extends State<HomePage> {
  String dropdownvalue = items[0].toString();

  @override
  void dispose() {
    super.dispose();
  }

  // List<DropdownMenuItem> _dropDownMenuItems = [];
  String currentData = typesEmployee_map[4].toString();

  // List<DropdownMenuItem> getDropDownMenuItems() {
  //   List<DropdownMenuItem> items = [];
  //   for (var value in typesEmployee) {
  //     items.add(DropdownMenuItem(
  //       value: value,
  //       child: Text(value),
  //       onTap: () {
  //         Fluttertoast.showToast(msg: value);
  //       },
  //     ));
  //   }
  //   return items;
  // }

  void changedDropDownItem(dynamic value) {
    setState(() {
      currentData = value;
    });
  }

  @override
  void initState() {
    // _dropDownMenuItems = getDropDownMenuItems();
    // _currentData = typesEmployee[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final employeeProviderMain = Provider.of<EmployeeProvider>(context);

    Widget _buildBody() {
      if (employeeProviderMain.isLoading) {
        return ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: const [
            Center(
              heightFactor: 20,
              child: CircularProgressIndicator(),
            )
          ],
        );
      } else if (employeeProviderMain.employeeListService == null) {
        return ListView(
          children: const [Text("NO DATA, THERES NO CONECTION WITH SERVER")],
        );
      } else if (employeeProviderMain.employeeListService!.listaEmployee ==
          null) {
        EmployeeTypeList listaTiposEmpleados =
            employeeProviderMain.employeeTypeListService!;

        return ListView(
          children: const [Center(child: Text("NO DATA"))],
        );
      } else {
        EmployeeList? employeeList = employeeProviderMain.employeeListService;

        EmployeeTypeList listaTiposEmpleados =
            employeeProviderMain.employeeTypeListService!;

        return ListView.builder(
          itemCount: employeeList!.listaEmployee!.length,
          itemBuilder: (context, index) {
            int id = employeeList.listaEmployee![index].id!;
            String id_employee_type =
                employeeList.listaEmployee![index].id_employee_type!.toString();

            return ListTile(
              onTap: () async {
                await employeeProviderMain.getEmployeeById(id).then((value) {
                  if (employeeProviderMain.employeeService != null) {
                    Navigator.pushNamed(context, "edit/create");
                  }
                });
              },
              onLongPress: () {
                showDialog(
                    context: context,
                    builder: (_) => CupertinoAlertDialog(
                          insetAnimationCurve: Curves.bounceIn,
                          title: const Text("Eliminar Empleado"),
                          content: Text(
                              "¿Estas seguro de eliminar al usuario ${employeeList.listaEmployee![index].name!}? "),
                          actions: [
                            TextButton(
                              onPressed: () {
                                employeeProviderMain.deleteEmployeeById(id);
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Eliminar",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Cancelar",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ));
              },
              title: Text(
                employeeList.listaEmployee![index].name! +
                    " " +
                    employeeList.listaEmployee![index].salary!.toString(),
              ),
              subtitle: Text(
                employeeList.listaEmployee![index].id!.toString(),
              ),
              leading: CircleAvatar(
                child: Text(
                  id_employee_type.length >= 3
                      ? id_employee_type.substring(0, 3)
                      : id_employee_type,
                ),
              ),
              trailing: const Icon(
                Icons.touch_app_outlined,
                color: Colors.red,
              ),
            );
          },
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Visibility(
            visible: true,
            child: SizedBox(
              width: double.infinity,
              child: Material(
                color: Colors.white,
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, right: 10, bottom: 15, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButton(
                          value: currentData,
                          items: typesEmployee
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                      e,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ))
                              .toList(),
                          onChanged: changedDropDownItem),
                      DropdownButton(
                        // Initial Value
                        value: dropdownvalue,

                        // Down Arrow Icon
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.black,
                        ),

                        // Array list of items
                        items: items.map((String e) {
                          return DropdownMenuItem(
                            value: e,
                            child: Row(
                              children: [
                                Text(
                                  e,
                                  style: const TextStyle(color: Colors.black),
                                ),
                                const Icon(
                                  Icons.numbers,
                                  color: Colors.black,
                                )
                              ],
                            ),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: RefreshIndicator(
              //INIDCAMOS QUE LA RECARGA SERA EN CUALQUIER PARTE DEL CUERPO DE LA LISTA
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              edgeOffset: 20,
              displacement: 150,
              color: Colors.blueGrey[900],
              backgroundColor: Colors.lightBlueAccent[70],
              onRefresh: employeeProviderMain.getAllEmployee,
              child: _buildBody(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          employeeProviderMain.employeeService = null;
          Navigator.pushNamed(context, "edit/create");
        },
        tooltip: "Agregar Empleado",
        child: const Icon(Icons.add),
      ),
    );
  }
}
