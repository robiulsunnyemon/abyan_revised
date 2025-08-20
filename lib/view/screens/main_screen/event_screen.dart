import 'package:abyansf_asfmanagment_app/utils/style/app_text_styles.dart';
import 'package:abyansf_asfmanagment_app/view/screens/profile_screen/event_history_individual_screen.dart';
import 'package:abyansf_asfmanagment_app/view/widget/custom_event_widget.dart';
import 'package:abyansf_asfmanagment_app/view/widget/home_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/event_controller/event_controller.dart';
import '../../../models/event_upcoming_model/event_upcoming_model.dart';
import '../../../utils/style/appColor.dart';


class EventScreen extends StatelessWidget {
   EventScreen({super.key});


  final _eventController=Get.put(EventController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeAppBar(showTitle: true,),
                const SizedBox(height: 15,),
                Text(
                  'Upcoming Event',
                  style: AppTextStyle.bold24,
                ),
                const SizedBox(height: 10),
               Obx((){
                 if(_eventController.upcomingEvents.isEmpty){
                   return Center(child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Text("There are no upcoming event"),
                   ));
                 }else{
                   return ListView.builder(
                     shrinkWrap: true,
                     physics: NeverScrollableScrollPhysics(),
                     itemCount: _eventController.upcomingEvents.length,
                     itemBuilder: (context, index) {
                       final Event upcomingEvent=_eventController.upcomingEvents[index];
                       return InkWell(
                           onTap: (){



                             Get.to(()=>EventHistoryIndividualPage(event: upcomingEvent,eventList: _eventController.upcomingEvents,));
                           },
                           child: CustomEventWidget(event: upcomingEvent,));
                     },
                   );
                 }
               }),
                const SizedBox(height: 10),
                Text(
                  'Past Event',
                  style: AppTextStyle.bold24,
                ),
                const SizedBox(height: 10),
                Obx((){
                  if(_eventController.pastEvents.isEmpty){
                    return Center(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("You have no past event"),
                    ));
                  }else{
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _eventController.pastEvents.length,
                      itemBuilder: (context, index) {
                        final Event pastEvent=_eventController.pastEvents[index];
                        return InkWell(
                          onTap: (){
                            Get.to(EventHistoryIndividualPage(
                              event: pastEvent,
                              eventList: _eventController.pastEvents,
                            ));
                          },
                          child: CustomEventWidget(
                            status: true,
                            event: pastEvent,
                          ),
                        );
                      },
                    );
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
