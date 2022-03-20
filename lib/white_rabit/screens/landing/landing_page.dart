
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:white_rabit_employer_detials/white_rabit/api/api_providers.dart';
import 'package:white_rabit_employer_detials/white_rabit/exit_bsheet.dart';
import 'package:white_rabit_employer_detials/white_rabit/screens/employee_details/employer_detail_page.dart';
import 'package:white_rabit_employer_detials/white_rabit/screens/loading_error.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? searchText = '';
  List<dynamic> employeeDetails = List.empty(growable: true);

  @override
  void initState() {
    SchedulerBinding.instance!.addPostFrameCallback((_) async {
      context
          .read(employerProvider.notifier)
          .getAddresses(init: true);
    });

    super.initState();
  }
  Future<bool> _onAppExit() async {
    // FlutterRingtonePlayer.stop();
    return await getCommonBottomSheet(context: context, content: ExitAppBottomSheet());
  }

  getCommonBottomSheet(
      {required BuildContext context,
        required Widget content,
        String title = '',bool? isDismissible,bool? enableDrag}) {
    return showModalBottomSheet(
        isDismissible: isDismissible == false ? false : true,
        enableDrag: enableDrag == false ? false : true,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        isScrollControlled: true,
        context: context,
        // backgroundColor: Colors.transparent,
        builder: (ctx) {
          return ConstrainedBox(
              constraints: BoxConstraints(
                  maxHeight: 500),
              child: SingleChildScrollView(
                  child: Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        Center(
                            child: Container(
                              width: 100,
                              height: 5,
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(10)),
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Center(
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        content
                      ]))));
        });
  }


  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return WillPopScope(
      onWillPop: _onAppExit,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: buildSearchBar(),
            backgroundColor: Colors.white,
automaticallyImplyLeading: false,
          ),
          body: SafeArea(
              child: Container(


                child: Column(children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Consumer(builder: (context, watch, child) {
                        final state = watch(employerProvider);

                        if (state.isLoading) {
                          return const CircularProgressIndicator.adaptive();
                        } else if (state.isError) {
                          return LoadingError(
                            onPressed: (res) {
                              reloadData(init: true, context: res);
                            },
                            message: state.errorMessage.toString(),
                          );
                        } else {

                          employeeDetails = state.response;

                          return Wrap(
                            alignment: WrapAlignment.center,
                            runAlignment: WrapAlignment.center,
                            spacing: 10,
                            runSpacing: 0,
                            children: employeeTiles(
                                context, state.response),
                          );
                        }
                      }),
                    ),
                  )
                ]),
              ))),
    );
  }

  Widget buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      height: MediaQuery.of(context).size.width / 6,
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        onChanged: (String? s) {
          setState(() {
            searchText = s;
          });
        },
        style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 14),

        decoration: InputDecoration(
          //contentPadding:EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          prefixIcon: Icon(
            Icons.search,
            color:Colors.black38,
            size: MediaQuery.of(context).size.width / 20,
          ),
          hintText: "Search by Employee name/e-mail",
          hintStyle: TextStyle(
              fontSize: MediaQuery.of(context).size.width / 26,
              fontWeight: FontWeight.w400,
              color: Colors.black38),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
          fillColor:  Colors.grey[200],
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        ),
      ),
    );
  }

  reloadData({required BuildContext context, bool? init}) {
    return context.read(employerProvider.notifier).getAddresses();
  }

  List<Widget> employeeTiles(context, List<dynamic> employee) {
    List<Widget> _widgetFood = [];

    for (int i = 0; i < employee.length; i++) {
      if (employee[i].name.toLowerCase().contains(searchText!.toLowerCase()) ||
          employee[i].email.toLowerCase().contains(searchText!.toLowerCase())) {
        _widgetFood.add(
        //     Padding(
        //   padding: const EdgeInsets.only(left: 1, top: 0),
        //   child: Container(
        //     width: MediaQuery.of(context).size.width / 2.2,
        //     padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(25),
        //     ),
        //     child: Stack(children: [
        //       Container(
        //         padding: EdgeInsets.all(4),
        //         decoration: BoxDecoration(
        //             borderRadius: BorderRadius.circular(25),
        //             color: Colors.white,
        //             boxShadow: const [
        //               BoxShadow(
        //                 offset: Offset(0, 3.0),
        //                 color: Color(0xfff0f0f0),
        //                 blurRadius: 10.0,
        //                 spreadRadius: 3.0,
        //               )
        //             ]),
        //         child: Material(
        //           color: Colors.transparent,
        //           child: InkWell(
        //             borderRadius: BorderRadius.circular(25),
        //             onTap: () {
        //               // print("asdasfas" + widget.cuisineName);
        //               Navigator.push(
        //                   context,
        //                   MaterialPageRoute(
        //                       builder: (context) => EmployerDetailPage(employeeDetails: employee[i],)));
        //             },
        //             child: Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Padding(
        //                   padding: const EdgeInsets.all(8.0),
        //                   child: ClipRRect(
        //                     borderRadius: BorderRadius.circular(25.0),
        //                     child: CachedNetworkImage(
        //                       colorBlendMode: BlendMode.color,
        //                       imageUrl: employee[i].profileImage,
        //                       width: MediaQuery.of(context).size.width / 2.5,
        //                       height: MediaQuery.of(context).size.height / 7,
        //                       fit: BoxFit.fill,
        //                       // color: restaurantListModel[i].shopstatus == "CLOSED" ? Colors.grey.withOpacity(0.3) : null,
        //                       placeholder: (context, url) => const Icon(Icons.image),
        //                       errorWidget: (context, url, error) => const Icon(Icons.error),
        //                     ),
        //                   ),
        //                 ),
        //                 Padding(
        //                   padding: const EdgeInsets.only(left: 8, right: 8),
        //                   child: Text(
        //                     employee[i].name,
        //                     style: const TextStyle(
        //                         color: Colors.black,
        //                         fontWeight: FontWeight.bold,
        //                         fontSize: 16),
        //                     // textAlign: TextAlign.center,
        //                     // maxLines: 2,
        //                   ),
        //                 ),
        //                 Padding(
        //                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
        //                   child: Text(
        //                     employee[i].email ?? "",
        //                     style: TextStyle(
        //                       color:
        //                      const Color(0xffFF1616).withOpacity(0.62),
        //                       fontSize: 10,
        //                       fontWeight: FontWeight.bold,
        //                     ),
        //                   ),
        //                 ),
        //                 const SizedBox(
        //                   width: 10,
        //                 ),
        //                 Padding(
        //                   padding: const EdgeInsets.only(
        //                       left: 3, right: 8, bottom: 13),
        //                   child: Row(
        //                     children: [
        //                       const SizedBox(
        //                         width: 5,
        //                       ),
        //                       Text(
        //                         employee[i].email,
        //                         style: TextStyle(
        //                             color: Color(0xff9B9B9B),
        //                             fontSize: 8,
        //                             fontWeight: FontWeight.w600),
        //                       )
        //                     ],
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        //       // if(restaurantListModel[i].shopstatus == "CLOSED")
        //       //   Positioned(
        //       //     top: 60,
        //       //    width:  MediaQuery.of(context).size.width / 2.3,
        //       //    // top: 100,
        //       //     child: Container(
        //       //         height: 20,
        //       //       color: Colors.grey.withOpacity(0.6),
        //       //         child: Center(child: Text("Closed",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.white),))),
        //       //   )
        //       // Positioned(
        //       //
        //       //   child: Container(
        //       //     decoration: BoxDecoration(
        //       //       borderRadius: BorderRadius.circular(24),
        //       //       color: Colors.grey.withOpacity(0.4),
        //       //     ),
        //       //     height: 200,
        //       //
        //       //   ),
        //       // )
        //
        //         Positioned(
        //           top: 100,
        //           left: 10,
        //           child: Container(
        //             padding: EdgeInsets.all(5),
        //             decoration: BoxDecoration(
        //                 color: Colors.green,
        //                 borderRadius: BorderRadius.circular(5),
        //                 border: Border.all(
        //                     color: Colors.green,
        //                     style: BorderStyle.solid,
        //                     width: 1)),
        //             child: Center(
        //                 child: Text(
        //                   "${employee[i].email}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500),)),
        //           ),
        //         )
        //     ]),
        //   ),
        // )



            InkWell(
          onTap: () {

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EmployerDetailPage(
                      employeeDetails: employee[i],
                    )));
          },
          child: Padding(
              padding: const EdgeInsets.only(left: 1, top: 0),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Container(
                    // padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          color: Colors.white,
                          // boxShadow: const [
                          //   BoxShadow(
                          //     offset: Offset(0, 3.0),
                          //     color: Color(0xfff0f0f0),
                          //     blurRadius: 10.0,
                          //     spreadRadius: 3.0,
                          //   )
                          // ]
                          ),
                      child: Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: CachedNetworkImage(
                                  imageUrl: employee[i].profileImage ?? '',
                                  width: MediaQuery.of(context).size.width / 4,
                                  height:
                                  MediaQuery.of(context).size.height / 9,
                                  fit: BoxFit.fill,
                                  placeholder: (context, url) => Icon(Icons.image),
                                  errorWidget: (context, url, error) =>
Icon(Icons.error),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20,),
                            Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Row(
                                          // mainAxisAlignment: MainAxisAlignment.center,
                                          // crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                employee[i].name,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16),
                                                // textAlign: TextAlign.center,
                                                // maxLines: 2,
                                                overflow: TextOverflow.clip,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "e-mail : " + employee[i].email.toString(),
                                        overflow: TextOverflow.clip,
                                        style: const TextStyle(
                                            color: Color(0xff9B9B9B),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        "Company : " +
                                            employee[i].company.name.toString(),
                                        overflow: TextOverflow.clip,
                                        style: const TextStyle(
                                            color: Color(0xff9B9B9B),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ]))
                          ])))),
        ));
        }
    }

    return _widgetFood;
  }
}


