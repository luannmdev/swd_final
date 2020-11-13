import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swdprojectbackup/models/companyChoose.dart';
import 'package:swdprojectbackup/ui/ojt/chooseCompViewModel.dart';

enum LoadingStatus {
  completed,
  searching,
  empty,
}

class ChooseCompScreen extends StatefulWidget {
  final List<CompanyChoose> companiesList;

  ChooseCompScreen({this.companiesList});
  


  @override
  _ChooseCompScreenState createState() => _ChooseCompScreenState(companiesList: companiesList);
}

class _ChooseCompScreenState extends State<ChooseCompScreen> {
  final List<CompanyChoose> companiesList;

  _ChooseCompScreenState({this.companiesList});



  List<DropdownMenuItem<CompanyChoose>> _dropdownMenuItem1;
  CompanyChoose _selectedCompany1;

  List<DropdownMenuItem<CompanyChoose>> _dropdownMenuItem2;
  CompanyChoose _selectedCompany2;

  List<DropdownMenuItem<CompanyChoose>> _dropdownMenuItem3;
  CompanyChoose _selectedCompany3;



  List<DropdownMenuItem<CompanyChoose>> buildDropdownMenuItem(List companies) {
    List<DropdownMenuItem<CompanyChoose>> items = List();
    items.add(DropdownMenuItem(
      value: CompanyChoose(position: '', compCode: ''),
      child: Text(''),
    ));
    for (CompanyChoose com in companiesList) {
      items.add(DropdownMenuItem(
        value: com,
        child: Text('Company: ' + com.compCode + ', Main: ' + com.position),
      ));
    }
    return items;
  }

  onChangeDropdownItem1(CompanyChoose selectedCom) {
    setState(() {
      print(selectedCom.position);
      _selectedCompany1 = selectedCom;
      if (_selectedCompany2 == selectedCom) {
        _selectedCompany2 = _dropdownMenuItem2[0].value;
      }
      if (_selectedCompany3 == selectedCom) {
        _selectedCompany3 = _dropdownMenuItem3[0].value;
      }
    });
  }

  onChangeDropdownItem2(CompanyChoose selectedCom) {
    setState(() {
      _selectedCompany2 = selectedCom;
      if (_selectedCompany1 == selectedCom) {
        _selectedCompany1 = _dropdownMenuItem1[0].value;
      }
      if (_selectedCompany3 == selectedCom) {
        _selectedCompany3 = _dropdownMenuItem3[0].value;
      }
    });
  }

  onChangeDropdownItem3(CompanyChoose selectedCom) {
    setState(() {
      _selectedCompany3 = selectedCom;
      if (_selectedCompany2 == selectedCom) {
        _selectedCompany2 = _dropdownMenuItem2[0].value;
      }
      if (_selectedCompany1 == selectedCom) {
        _selectedCompany1 = _dropdownMenuItem1[0].value;
      }
    });
  }

  @override
  void initState() {
    // Provider.of<ChooseCompViewModel>(context,listen: false).getCompChoose(uniCode, majorCode, subject);
    // compan_iesList = chooseCompViewModel.compList;
    _dropdownMenuItem1 = buildDropdownMenuItem(companiesList);
    _dropdownMenuItem2 = buildDropdownMenuItem(companiesList);
    _dropdownMenuItem3 = buildDropdownMenuItem(companiesList);
    _selectedCompany1 = _dropdownMenuItem1[0].value;
    _selectedCompany2 = _dropdownMenuItem2[0].value;
    _selectedCompany3 = _dropdownMenuItem3[0].value;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var chooseCompViewModel = Provider.of<ChooseCompViewModel>(context);



    // return chooseCompViewModel == null ?  CircularProgressIndicator() :Expanded(
    return Expanded(
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(30.0)),
              color: Color(0xFF00003f),
            ),
          ),
          Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 20),
                    child: Row(
                      children: [
                        Text(
                          'Company 1 ',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 15.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButton(
                            value: _selectedCompany1,
                            items: _dropdownMenuItem1,
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            onChanged: onChangeDropdownItem1,
                            underline: Container(
                              height: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  // Text(
                  //   'Selected: ${_selectedCompany1.compCode} - ${_selectedCompany1.position}',
                  //   style: TextStyle(color: Colors.white, fontSize: 18),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 20),
                    child: Row(
                      children: [
                        Text(
                          'Company 2 ',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 15.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButton(
                            value: _selectedCompany2,
                            items: _dropdownMenuItem2,
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            onChanged: onChangeDropdownItem2,
                            underline: Container(
                              height: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  // Text(
                  //   'Selected: ${_selectedCompany2.comName} - ${_selectedCompany2.comMain}',
                  //   style: TextStyle(color: Colors.white, fontSize: 18),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, top: 20),
                    child: Row(
                      children: [
                        Text(
                          'Company 3 ',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 15.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButton(
                            value: _selectedCompany3,
                            items: _dropdownMenuItem3,
                            style: TextStyle(color: Colors.black, fontSize: 14),
                            onChanged: onChangeDropdownItem3,
                            underline: Container(
                              height: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  // Text(
                  //   'Selected: ${_selectedCompany3.comName} - ${_selectedCompany3.comMain}',
                  //   style: TextStyle(color: Colors.white, fontSize: 18),
                  // ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(80.0, 5.0, 80.0, 5.0),
                    child: RaisedButton(
                        color: Theme.of(context).primaryColor,
                        child: Center(
                          child: Text(
                            'Send CV',
                            style: TextStyle(
                              fontSize: 23,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onPressed: () {
                          if ((_selectedCompany1 == _dropdownMenuItem1[0].value) &&
                              (_selectedCompany2 == _dropdownMenuItem2[0].value) &&
                              (_selectedCompany3 == _dropdownMenuItem3[0].value)) {
                            print('No selected');
                          } else {
                            print('Send CV');
                          }
                          ;
                        }),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    ) ;
  }
}
