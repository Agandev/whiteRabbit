


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:white_rabit_employer_detials/white_rabit/screens/landing/employee_model.dart';
import 'package:white_rabit_employer_detials/white_rabit/screens/landing/landing_page.dart';

class EmployerDetailPage extends StatefulWidget {
  final EmployerDetails? employeeDetails;
  const EmployerDetailPage({Key? key, this.employeeDetails}) : super(key: key);

  @override
  State<EmployerDetailPage> createState() => _EmployerDetailPageState();
}

class _EmployerDetailPageState extends State<EmployerDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget getDetailsRow(label, value, context) {
    return Row(
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: MediaQuery.of(context).size.width / 25),
        ),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.lightBlue,
                fontSize: MediaQuery.of(context).size.width / 25),
          ),
        )
      ],
    );
  }



  Widget getEmployeeDetails() {
    return SafeArea(
      child: SingleChildScrollView(
        child:
        Column(
          children: [
            CircleAvatar(
              radius: 80.0,
              backgroundColor: CupertinoColors.systemGrey5,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: widget.employeeDetails!.profileImage ?? '',
                  width: MediaQuery.of(context).size.width /2.6,
                  height: MediaQuery.of(context).size.height / 5.75,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => Icon(Icons.image),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),




            Column(children: [
              Text(
                widget.employeeDetails!.name.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 19,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold),
              ),
              getDetailsRow("User name: ",widget.employeeDetails!.username.toString(),context),

              const SizedBox(
                height: 5,
              ),
              getDetailsRow("E-mail: ",widget.employeeDetails!.email.toString(),context),
              const SizedBox(
                height: 5,
              ),
              getDetailsRow("Website: ",widget.employeeDetails!.website.toString(),context),
              const SizedBox(
                height: 5,
              ),
              getDetailsRow("Phone: ",widget.employeeDetails!.phone.toString(),context),
              const SizedBox(
                height: 5,
              ),
              getDetailsRow("City: ",widget.employeeDetails!.address!.city.toString(),context),
              const SizedBox(
                height: 5,
              ),
              getDetailsRow("Suite: ",widget.employeeDetails!.address!.suite.toString(),context),
              const SizedBox(
                height: 5,
              ),
              getDetailsRow("Street: ",widget.employeeDetails!.address!.street.toString(),context),
              const SizedBox(
                height: 5,
              ),
              getDetailsRow("Zipcode: ",widget.employeeDetails!.address!.zipcode.toString(),context),
              const SizedBox(
                height: 5,
              ),
              getDetailsRow("Company: ",widget.employeeDetails!.company.toString(),context),
              const SizedBox(
                height: 5,
              ),
              getDetailsRow("Company phrase: ",widget.employeeDetails!.company!.catchPhrase.toString(),context),
              const SizedBox(
                height: 5,
              ),
              getDetailsRow("Company bs: ", widget.employeeDetails!.company!.bs == null
                  ? "Not Available"
                  : widget.employeeDetails!.company!.bs.toString(),context),
             const SizedBox(
                height: 5,
              ),
              const Divider(color: Colors.black),
            ])
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Employee Details",
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black38),
          ),
          backgroundColor: Colors.white,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black38,
              )),
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 200),
              child: getEmployeeDetails()),
        ));
  }
}
