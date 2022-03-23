import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dto/employee.dart';
import '../service/employee_provider.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

// var items = [
//   'Item 1',
//   'Item 2',
//   'Item 3',
//   'Item 4',
//   'Item 5',
// ];

class _HomePageState extends State<HomePage> {
  // String dropdownvalue = items[0].toString();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
          children: const [Text("NO DATA")],
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
                // color: Colors.black,
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 10, right: 10, bottom: 15, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // DropdownButton(
                      //   // Initial Value
                      //   value: dropdownvalue,

                      //   // Down Arrow Icon
                      //   icon: const Icon(Icons.keyboard_arrow_down),

                      //   // Array list of items
                      //   items: items.map((String items) {
                      //     return DropdownMenuItem(
                      //       value: items,
                      //       child: Text(
                      //         items,
                      //         style: TextStyle(color: Colors.black),
                      //       ),
                      //     );
                      //   }).toList(),
                      //   // After selecting the desired option,it will
                      //   // change button value to selected value
                      //   onChanged: (String? newValue) {
                      //     setState(() {
                      //       dropdownvalue = newValue!;
                      //     });
                      //   },
                      // ),
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
