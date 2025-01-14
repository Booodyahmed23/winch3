import 'package:flutter/material.dart';

class MessengerScreen extends StatelessWidget {
  const MessengerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0.0,
      //   titleSpacing: 20.0,
      //   title:const Row(
      //     children: [
      //       // CircleAvatar(
      //       //   radius: 25.0,
      //       //   backgroundImage: NetworkImage('https://avatars.githubusercontent.com/u/35667059?v=4'),
      //       // ),
      //       SizedBox(
      //         width: 20,
      //       ),
      //       Text(
      //         'chats',
      //         style: TextStyle(
      //           fontSize: 35,
      //
      //           color: Colors.black,
      //         ),
      //       ),
      //     ],
      //   ) ,
      //   actions: [
      //     IconButton(
      //       icon: const CircleAvatar(
      //         radius: 15.0,
      //         backgroundColor: Colors.blue,
      //         child: Icon(
      //           Icons.camera_alt,
      //           size: 16.0,
      //           color: Colors.white,
      //         ),
      //       ),
      //       onPressed: (){},),
      //     IconButton(
      //       icon: CircleAvatar(
      //         radius: 15.0,
      //         backgroundColor: Colors.blue,
      //         child: Icon(
      //           Icons.edit,
      //           size: 16.0,
      //           color: Colors.white,
      //         ),
      //       ),
      //       onPressed: (){},),
      //   ],
      //
      //
      // ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment:CrossAxisAlignment.start ,
            children: [
              // Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(20.0),
              //     color: Colors.grey[350],
              //   ),
              //   padding:EdgeInsets.all(5.0),
              //   child: const Row(
              //     // children: [
              //     //   SizedBox(
              //     //     width: 20,
              //     //   ),
              //     //   Icon(
              //     //     Icons.search,
              //     //   ),
              //     //   SizedBox(
              //     //     width: 20,
              //     //
              //     //   ),
              //     //   Text(
              //     //     style: TextStyle(
              //     //       fontSize: 30,
              //     //     ),
              //     //     'Search',
              //     //   ),
              //     // ],
              //   ),
              // ),
              // SizedBox(
              //   height: 25,
              // ),
              Container(
                height:100.0,

                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => buildStoryItem(),
                  separatorBuilder: (context, index) => SizedBox(
                    width: 20,
                  ) ,

                  itemCount: 10,

                ),
              ),
              SizedBox(
                height: 60,
              ),
              ListView.separated(
                physics:NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder:(BuildContext context, index)=>buildChatItem(),
                separatorBuilder: ( context, index)=> SizedBox(
                  height: 20.0,
                ),

                itemCount:30,

              ),



            ],
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
          CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage('https://avatars.githubusercontent.com/u/35667059?v=4'),

          ),
          CircleAvatar(
            radius: 9,
            backgroundColor: Colors.white,
          ),
          Padding(
              padding: EdgeInsetsDirectional.only(
                bottom: 3,
                end: 3,
              )),
          CircleAvatar(
            radius: 7,
            backgroundColor: Colors.green,
          ),
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
                    'team flutter mobile application at knowledge net free zone',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),

                  ),
                ),
                Text(
                  '02:00 pm',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),

          ],
        ),
      ),
    ],

  );

  Widget buildStoryItem() =>  Container(
    width: 60,
    child: const Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage('https://avatars.githubusercontent.com/u/35667059?v=4'),

            ),
            CircleAvatar(
              radius: 9,
              backgroundColor: Colors.white,
            ),
            Padding(
                padding: EdgeInsetsDirectional.only(
                  bottom: 3,
                  end: 3,
                )),
            CircleAvatar(
              radius: 7,
              backgroundColor: Colors.green,
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Text(

          'abdo ahmed sayed abdelghany',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Row(

        ),
      ],
    ),
  );


}

