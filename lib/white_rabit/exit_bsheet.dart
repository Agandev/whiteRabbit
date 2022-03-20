
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExitAppBottomSheet extends StatefulWidget {
  const ExitAppBottomSheet({Key? key}) : super(key: key);

  @override
  _ExitAppBottomSheetState createState() => _ExitAppBottomSheetState();
}

class _ExitAppBottomSheetState extends State<ExitAppBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Text("Are you sure you want to exit?",style: TextStyle(fontWeight: FontWeight.w600),),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: MaterialButton(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.red,
                    onPressed: () {
                      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                      // SystemNavigator.pop();
                    },
                    child: Text(
                      "Exit",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 15),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    color: Colors.green,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel",                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: 15)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
