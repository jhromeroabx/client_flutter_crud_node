import 'package:client_flutter_crud_node/src/dto/employee.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../service/employee_provider.dart';

class EditOrCreatePage extends StatefulWidget {
  const EditOrCreatePage({Key? key}) : super(key: key);

  @override
  State<EditOrCreatePage> createState() => _EditOrCreatePageState();
}

class _EditOrCreatePageState extends State<EditOrCreatePage> {
  late TextEditingController controlName;
  late TextEditingController controlSalary;
  late TextEditingController controlIdTypeEmployee;
  late Employee _employee;

  @override
  void initState() {
    controlName = TextEditingController();
    controlSalary = TextEditingController();
    controlIdTypeEmployee = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final employeeProviderMain = Provider.of<EmployeeProvider>(context);

    controlName.text = employeeProviderMain.employeeService?.name ?? '';
    controlSalary.text =
        employeeProviderMain.employeeService?.salary.toString() ?? '';
    controlIdTypeEmployee.text =
        employeeProviderMain.employeeService?.id_employee_type.toString() ??
            '0';

    String _titlePage = employeeProviderMain.employeeService != null
        ? "Edicion del Empleado: ${controlName.text}"
        : "Creacion de un nuevo Empleado";

    ;

    return Scaffold(
      appBar: AppBar(title: Text(_titlePage)),
      body: ListView(children: [
        TextInputData(
          "Nombre",
          control: controlName,
        ),
        TextInputData(
          "Salario",
          control: controlSalary,
          keyBoardType: const TextInputType.numberWithOptions(
              signed: true, decimal: true),
        ),
        TextInputData(
          "Tipo Empleado",
          control: controlIdTypeEmployee,
          keyBoardType: TextInputType.number,
        ),
        ElevatedButton(
            onPressed: () {
              if (employeeProviderMain.employeeService != null) {
                _employee = Employee(
                  id: employeeProviderMain.employeeService!.id,
                  name: controlName.text,
                  salary: controlSalary.text,
                  id_employee_type: controlIdTypeEmployee.text,
                );
              } else {
                _employee = Employee(
                  id: 0,
                  name: controlName.text,
                  salary: controlSalary.text,
                  id_employee_type: controlIdTypeEmployee.text,
                );
              }

              employeeProviderMain.addEmployeeOrEdit(_employee);
              Navigator.pop(context);
            },
            child: const Text("Guardar cambios"))
      ]),
    );
  }
}

class TextInputData extends StatelessWidget {
  final TextEditingController control;
  final String title;
  final TextInputType? keyBoardType;

  const TextInputData(this.title,
      {Key? key, required this.control, this.keyBoardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextField(
        keyboardType: keyBoardType ?? TextInputType.name,
        controller: control,
        decoration: InputDecoration(
          filled: true,
          labelText: title,
          suffix: GestureDetector(
            child: const Icon(Icons.close),
            onTap: () {
              control.clear();
            },
          ),
        ),
      ),
    );
  }
}
