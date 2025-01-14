import 'package:flutter/material.dart';

import '../maps/MapsView.dart';

class SelectAddressScreen extends StatelessWidget {
  final TextEditingController firstController = TextEditingController();
  final TextEditingController secondController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
late String googleMapKey = 'AIzaSyB74uwwESOOrHljNdslaA1cb8iseyiLYPM';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: const Text('Select Address')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            // For validation
            child: Column(
              children: [
                // First Text Field
                TextFormField(
                  controller: firstController,
                  decoration: InputDecoration(
                    labelText: 'From',
                    hintText: 'Enter your location',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.location_on_outlined),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Second Text Field
                TextFormField(
                  controller: secondController,
                  decoration: InputDecoration(
                    labelText: 'to ',
                    hintText: 'Where to ?',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.location_on),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },


                ),
                SizedBox(
                  height: 25,
                ),
                ListView.separated(
                  physics:NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder:(BuildContext context, index)=>buildChatItem(),
                  separatorBuilder: ( context, index)=> SizedBox(
                    height: 20.0,
                  ),

                  itemCount:20,

                ),
                const SizedBox(height: 30),

                // Submit Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MapsView(onMapCreated: (GoogleMapController ) {  },),
                      ),
                    );
                    if (formKey.currentState!.validate()) {
                      final firstValue = firstController.text;
                      final secondValue = secondController.text;

                      // Do something with the input values
                      print('First Value: $firstValue');
                      print('Second Value: $secondValue');

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Form submitted successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget buildChatItem () => Row(
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [


          Padding(
              padding: EdgeInsetsDirectional.only(
                bottom: 3,
                end: 3,
              )),
       Icon(Icons.history ),
        ],
      ),
      SizedBox(
        width: 20,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'abdo ahmed',
              maxLines: 1,
              overflow: TextOverflow.fade,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'team flutter mobile application at knowledge net free zone team flutter mobile application at knowledge net free zone ',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),


              ],
            ),

          ],
        ),
      ),
    ],

  );

}


