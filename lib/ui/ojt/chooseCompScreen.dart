import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:swdprojectbackup/models/application.dart';
import 'package:swdprojectbackup/models/companyChoose.dart';
import 'package:swdprojectbackup/services/web_service.dart';
import 'package:swdprojectbackup/ui/ojt/chooseCompViewModel.dart';

enum LoadingStatus {
  completed,
  searching,
  empty,
}

class ChooseCompScreen extends StatefulWidget {
  final List<int> appliedList;
  final String stuId;
  final List<CompanyChoose> companiesList;
  final Function(List<int>) onDataChange;
  final Function(bool) onStatusChange;
  final bool updateProfileStatus;
  final bool disableApplyJob;

  ChooseCompScreen({this.updateProfileStatus,this.appliedList, this.stuId, this.companiesList,this.onDataChange, this.onStatusChange, this.disableApplyJob});

  @override
  _ChooseCompScreenState createState() => _ChooseCompScreenState(
     disableApplyJob: disableApplyJob,onStatusChange:onStatusChange, updateProfileStatus: updateProfileStatus,onDataChange: onDataChange, appliedList: this.appliedList,stuId: this.stuId, companiesList: this.companiesList);
}

class _ChooseCompScreenState extends State<ChooseCompScreen> {
  List<int> appliedList;
  List<int> testlist;
  final String stuId;
  final List<CompanyChoose> companiesList;
  final Function(List<int>) onDataChange;
  final Function(bool) onStatusChange;
  final bool updateProfileStatus;
  bool disableApplyJob;

  bool disable = false;

  _ChooseCompScreenState({this.disableApplyJob,this.onStatusChange,this.updateProfileStatus,this.onDataChange, this.appliedList, this.stuId, this.companiesList});

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
      appliedList.remove(_selectedCompany1.id);
      _selectedCompany1 = selectedCom;
      if (_selectedCompany1 != _dropdownMenuItem1[0].value)
        appliedList.add(_selectedCompany1.id);
      if (selectedCom == _selectedCompany2) {
        appliedList.remove(_selectedCompany2.id);
        _selectedCompany2 = _dropdownMenuItem2[0].value;
      }
      if (selectedCom == _selectedCompany3) {
        appliedList.remove(_selectedCompany3.id);
        _selectedCompany3 = _dropdownMenuItem3[0].value;
      }
    });
    onDataChange(appliedList);
  }

  onChangeDropdownItem2(CompanyChoose selectedCom) {
    setState(() {
      appliedList.remove(_selectedCompany2.id);
      _selectedCompany2 = selectedCom;
      if (_selectedCompany2 != _dropdownMenuItem2[0].value)
      appliedList.add(_selectedCompany2.id);
      if (selectedCom == _selectedCompany1) {
        appliedList.remove(_selectedCompany1.id);
        _selectedCompany1 = _dropdownMenuItem1[0].value;
      }
      if (selectedCom == _selectedCompany3) {
        appliedList.remove(_selectedCompany3.id);
        _selectedCompany3 = _dropdownMenuItem3[0].value;
      }
    });
    onDataChange(appliedList);
  }

  onChangeDropdownItem3(CompanyChoose selectedCom) {
    setState(() {
      appliedList.remove(_selectedCompany3.id);
      _selectedCompany3 = selectedCom;
      if (_selectedCompany3 != _dropdownMenuItem3[0].value)
        appliedList.add(_selectedCompany3.id);
      if (selectedCom == _selectedCompany2) {
        appliedList.remove(_selectedCompany2.id);
        _selectedCompany2 = _dropdownMenuItem2[0].value;
      }
      if (selectedCom == _selectedCompany1) {
        appliedList.remove(_selectedCompany1.id);
        _selectedCompany1 = _dropdownMenuItem1[0].value;
      }
    });
    onDataChange(appliedList);
  }

  updateSuccess(){
    setState(() {
      print('disable = true;');
      disable = true;
      disableApplyJob = true;
    });
    onStatusChange(disable);
  }

  @override
  void initState() {
    Provider.of<ChooseCompViewModel>(context,listen: false);
    // Provider.of<ChooseCompViewModel>(context,listen: false).getCompChoose(uniCode, majorCode, subject);
    // compan_iesList = chooseCompViewModel.compList;
    _dropdownMenuItem1 = buildDropdownMenuItem(companiesList);
    _dropdownMenuItem2 = buildDropdownMenuItem(companiesList);
    _dropdownMenuItem3 = buildDropdownMenuItem(companiesList);
    _selectedCompany1 = _dropdownMenuItem1[0].value;
    _selectedCompany2 = _dropdownMenuItem2[0].value;
    _selectedCompany3 = _dropdownMenuItem3[0].value;
    if (appliedList == null) {
      appliedList = new List();
    }
    if (appliedList != null){
      if (appliedList.length == 1) {
        _dropdownMenuItem1.forEach((element) {
          if (element.value.id == appliedList[0]) {
            _selectedCompany1 = element.value;
          }
        });
      }
      if (appliedList.length == 2) {
        _dropdownMenuItem1.forEach((element) {
          if (element.value.id == appliedList[0]) {
            _selectedCompany1 = element.value;
          }
          if (element.value.id == appliedList[1]) {
            _selectedCompany2 = element.value;
          }
        });
      }
      if (appliedList.length == 3) {
        _dropdownMenuItem1.forEach((element) {
          if (element.value.id == appliedList[0]) {
            _selectedCompany1 = element.value;
          }
          if (element.value.id == appliedList[1]) {
            _selectedCompany2 = element.value;
          }
          if (element.value.id == appliedList[2]) {
            _selectedCompany3 = element.value;
          }
        });
      }
    }
    print('CHOSSE COMP - DISABLE: $disableApplyJob');
    if (disableApplyJob == true){
      disable = disableApplyJob;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var chooseCompViewModel = Provider.of<ChooseCompViewModel>(context);

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
            padding: const EdgeInsets.only(top: 30),
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 20),
                    child: Row(
                      children: [
                        Text(
                          'Option 1 ',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButton(
                            value: _selectedCompany1,
                            items: _dropdownMenuItem1,
                            disabledHint: Text('Company: ' + _selectedCompany1.compCode + ', Main: ' + _selectedCompany1.position),
                            style: TextStyle(color: Colors.black, fontSize: 12),
                            onChanged: disable ? null : onChangeDropdownItem1,
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
                    padding: const EdgeInsets.only(left: 10.0, top: 20),
                    child: Row(
                      children: [
                        Text(
                          'Option 2 ',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButton(
                            value: _selectedCompany2,
                            items: _dropdownMenuItem2,
                            disabledHint: Text('Company: ' + _selectedCompany2.compCode + ', Main: ' + _selectedCompany2.position),
                            style: TextStyle(color: Colors.black, fontSize: 12),
                            onChanged: disable ? null : onChangeDropdownItem2,
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
                    padding: const EdgeInsets.only(left: 10.0, top: 20),
                    child: Row(
                      children: [
                        Text(
                          'Option 3 ',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: DropdownButton(
                            value: _selectedCompany3,
                            items: _dropdownMenuItem3,
                            disabledHint: Text('Company: ' + _selectedCompany3.compCode + ', Main: ' + _selectedCompany3.position),
                            style: TextStyle(color: Colors.black, fontSize: 12),
                            onChanged: disable ? null : onChangeDropdownItem3,
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
                  Container(height: 50,
                    margin: const EdgeInsets.fromLTRB(100, 20, 100, 0),
                    child: RaisedButton(

                        disabledColor: Colors.grey,
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
                        onPressed: disable ? null : () {
                          print('Check update profile');
                          if (!updateProfileStatus) {
                            Fluttertoast.showToast(
                                msg: "Please update your profile.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.orange,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          } else
                          if ((_selectedCompany1 ==
                                  _dropdownMenuItem1[0].value) &&
                              (_selectedCompany2 ==
                                  _dropdownMenuItem2[0].value) &&
                              (_selectedCompany3 ==
                                  _dropdownMenuItem3[0].value)) {
                            Fluttertoast.showToast(
                                msg: "No Selected",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.orange,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }  else {
                            print('$stuId - ${_selectedCompany1.id}');
                            List<Application> appList = new List();
                            if (_selectedCompany1 !=
                                _dropdownMenuItem1[0].value) {
                              appList.add(new Application(
                                  stuCode: stuId, jobId: _selectedCompany1.id,status: 'Processing'));
                            }
                            if (_selectedCompany2 !=
                                _dropdownMenuItem2[0].value) {
                              appList.add(new Application(
                                  stuCode: stuId, jobId: _selectedCompany2.id,status: 'Processing'));
                            }
                            if (_selectedCompany3 !=
                                _dropdownMenuItem3[0].value) {
                              appList.add(new Application(
                                  stuCode: stuId, jobId: _selectedCompany3.id,status: 'Processing'));
                            }
                            //Pass all
                            //call api
                            Provider.of<ChooseCompViewModel>(context,listen: false).applyJob(appList).then((res) =>
                            {
                              if (res) {
                                Provider.of<ChooseCompViewModel>(context,listen: false).updateLastSent(appList[0].stuCode, appList.length).then((value) =>
                                {
                                  updateSuccess()
                                }),
                                Fluttertoast.showToast(
                                msg: "Your CV has been sent.",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.blue,
                                textColor: Colors.white,
                                fontSize: 16.0)
                          }});
                            // var chooseCompViewModel = Provider.of<ChooseCompViewModel>(context,listen: false);
                            //check status


                          };
                        }),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
