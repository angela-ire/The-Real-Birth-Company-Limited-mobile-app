// ignore: file_names
import 'package:birth_picker/birth_picker.dart';
import 'package:flutter/material.dart';
import 'package:real_birth_app/controllers/signUpController.dart';
import 'package:real_birth_app/models/langModel.dart';

// ignore: must_be_immutable
class Signupview extends StatefulWidget{

  Signupview({super.key});

  @override
  _signUpViewState createState() => _signUpViewState();}

  class _signUpViewState extends State<Signupview>{
    final _email = TextEditingController();
    final _password = TextEditingController();
    final _name = TextEditingController();
    final _postcode = TextEditingController();
    final _hospital = TextEditingController();
    DateTime? _dateOfBirth;
    String? _lang;
    String? _bioSex;
    DateTime? _dueDate;
    String? _discover;
    String? _classes;
    final control = signUpController();
    List<Langmodel> languages=[];
    DateTime curr = DateTime.now();

    bool _validateName = false;
    bool _validateEmail = false;
    bool _validatePassword = false;
    bool _validateHospital = false;
    bool _validatePostcode = false;
    
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body:Center( 
          child:Padding(padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            const Text("Sign Up", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700),),
            /* Email */
            const SizedBox(height: 50,),
            TextFormField(controller: _email, validator: validateEmail,
            decoration: InputDecoration(labelText: "Email",errorText: _validateEmail? "Value Can't Be Empty" : null),style: TextStyle(fontSize: 20),),
            
            /* Password */
            const SizedBox(height: 50,),
            TextField(controller: _password,
            decoration: InputDecoration(labelText: "Password", errorText: _validatePassword? "Value Can't Be Empty" : null,),style: TextStyle(fontSize: 20),),
            
            /* Name */
            const SizedBox(height: 50,),
            TextField(controller: _name,
            decoration: InputDecoration(labelText: "Full Name", errorText: _validateName? "Value Can't Be Empty" : null,),style: TextStyle(fontSize: 20),),
            
            /* Age */
            const SizedBox(height: 50,),
            Text("Date Of Birth"),
            /* Handles picking a specific date */
            BirthPicker(locale: 'en_GB', maximumDate: curr,
              decorationBuilder: (bool isFocused) {
                return BoxDecoration(
                  border: Border.all(
                    color: isFocused ? Colors.blue : Colors.grey,
                    width: isFocused ? 2.0 : 1.0,
                  ),
                  borderRadius: BorderRadius.circular(12),
                );
              },
              onChanged: (DateTime? dateTime) {
                _dateOfBirth = dateTime;
                control.fetchStats();
              },
            ),
            
            /* Postcode */
            const SizedBox(height: 50,),
            TextField(controller: _postcode,
            decoration: InputDecoration(labelText: "Postcode", errorText: _validatePostcode? "Value Can't Be Empty" : null,),style: TextStyle(fontSize: 20),),
            
            /* Hospital */
            const SizedBox(height: 50,),
            TextField(controller: _hospital,
            decoration: InputDecoration(labelText: "Hospital", errorText: _validateHospital? "Value Can't Be Empty" : null,),style: TextStyle(fontSize: 20),),
            
            /* lang */
            const SizedBox(height: 50,),
            StreamBuilder(stream: signUpController().fetchLanguages(), builder: (context, snapshot){/* Stream builder */
              if (snapshot.hasData){
                languages = snapshot.data!;
                return DropdownMenu(textStyle: TextStyle(fontSize: 20), 
                label: Text("Language Selection"),
                dropdownMenuEntries: languages.map((currLang)=>DropdownMenuEntry(value: currLang.key, label: currLang.text)).toList(),/* Uses the members of database as the items in the drop down menu list */
                onSelected: (value) {
                  _lang=value;
                },
              );
            }
            else{
              return Text("Somthing Went Wrong");
            }
            }),

            /* Bio Sex */
            const SizedBox(height: 50,),
            DropdownMenu(textStyle: TextStyle(fontSize: 20) ,label: Text("What is your biological sex") ,enableFilter: true ,dropdownMenuEntries: <DropdownMenuEntry<String>>[
              DropdownMenuEntry(value: "M", label: "Male"),
              DropdownMenuEntry(value: "F", label: "Female")
             ],
             onSelected: (value) {
                  _bioSex=value;
                },
            ),
            
            /*Due Date */
            const SizedBox(height: 50,),
            Text("Due Date"),
            BirthPicker(locale: 'en_GB',minimumDate: curr,maximumDate: DateTime(curr.year, curr.month + 10, curr.day),
              decorationBuilder: (bool isFocused) {
                return BoxDecoration(
                  border: Border.all(
                    color: isFocused ? Colors.blue : Colors.grey,
                    width: isFocused ? 2.0 : 1.0,
                  ),
                  borderRadius: BorderRadius.circular(12),
                );
              },
              onChanged: (DateTime? dateTime) {
                _dueDate = dateTime;
              },
            ),
            
            /* FoundOut */
            const SizedBox(height: 50,),
            DropdownMenu(textStyle: TextStyle(fontSize: 20) ,label: Text("How did you find us?") ,enableFilter: true ,dropdownMenuEntries: <DropdownMenuEntry<String>>[
              DropdownMenuEntry(value: "Option 1", label: "Option 1"),
              DropdownMenuEntry(value: "Option 1", label: "Option 2")
             ],
             onSelected: (value) {
                  _discover=value;
                },
            ),
            
            /* Classes */
            const SizedBox(height: 50,),
            DropdownMenu(textStyle: TextStyle(fontSize: 20) ,label: Text("Do you attend classes?") ,enableFilter: true ,dropdownMenuEntries: <DropdownMenuEntry<String>>[
              DropdownMenuEntry(value: "Yes", label: "Yes"),
              DropdownMenuEntry(value: "No", label: "No")
             ],
             onSelected: (value) {
                  _classes=value;
                },
            ),

            /* SignUp Button */
            const SizedBox(height: 30,),
            ElevatedButton(onPressed: () {
                setState(() {
                  _validateName = _name.text.isEmpty;
                  _validateEmail = _email.text.isEmpty;
                  _validatePassword = _password.text.isEmpty;
                  _validateHospital = _hospital.text.isEmpty;
                  _validatePostcode = _postcode.text.isEmpty;
                });
              signup();}, child: Text("SignUp"))
          ],
        )
      )
    )
  )
  );
}
  /* Sends data to controller */
  void signup(){
    try{
      if(_name.text.isEmpty || _email.text.isEmpty || _password.text.isEmpty || _hospital.text.isEmpty || _postcode.text.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please make sure all fields are full"),
));
      }
      else{
        control.createUser(_name.text, _email.text, _password.text, _postcode.text, _hospital.text, _dateOfBirth!, _lang!, _bioSex!, _dueDate!, DateTime.now(), _discover!, _classes!);
      }
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Please make sure all fields are full"),
      ));
    }
  }

String? validateEmail(String? value) {
  const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
  final regex = RegExp(pattern);

  return value!.isNotEmpty && !regex.hasMatch(value)
      ? 'Enter a valid email address'
      : null;
}

}