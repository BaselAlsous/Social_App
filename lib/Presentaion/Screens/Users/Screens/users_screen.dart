import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Business/AppCubit/app_cubit.dart';
import 'package:social_app/Data/Constant/Method/navigation.dart';
import 'package:social_app/Data/Model/model_user_data.dart';
import 'package:social_app/Presentaion/Components/custom_loadin.dart';
import 'package:social_app/Presentaion/Screens/Users/Screens/users_prifile_screen.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit appCubit = AppCubit.get(context);
        List<ModelUserData> allUser = appCubit.allUser;
        int follower = appCubit.followDoneModel.length;
        // print(follower.toString());
        return Scaffold(
          body: ConditionalBuilder(
            condition: allUser.isNotEmpty,
            fallback: (context) => Center(
              child: CustomLoading.spinkit,
            ),
            builder: (context) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      Navigation.navigationAndBack(
                          context: context,
                          page: UsersProfileScreen(
                            modelUserData: allUser[index]
                          ));
                    },
                    child: Row(
                      children: [
                      Expanded(
                        flex: 2,
                        child: Row(
                        children: [
                          CircleAvatar(
                            radius: 35.0,
                            backgroundImage:
                            NetworkImage('${allUser[index].image}'),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Text("${allUser[index].name}",
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontSize: 17.0,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),),
                      if(follower == 1)
                      Expanded(
                          flex: 1,
                            child: MaterialButton(
                              onPressed: (){
                                appCubit.unFollow(
                                  userUid: allUser[index].uid,
                                );
                              },
                              color: Colors.blueAccent,
                              child:  Text('Follow',
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.white,
                                  ),
                              ),
                            ),
                        ),
                        if(follower == 0)
                          Expanded(
                            flex: 1,
                            child: MaterialButton(
                              onPressed: (){
                                appCubit.followUser(
                                  image: allUser[index].image,
                                  name: allUser[index].name,
                                  uid: allUser[index].uid,
                                  userUid: allUser[index].uid,
                                  myImage:appCubit.userData?.image,
                                  myName: appCubit.userData?.name ,
                                  myUid:appCubit.userData?.uid ,
                                );
                              },
                              color: Colors.green,
                              child:  Text('Follow',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 10.0,
                  );
                },
                itemCount: allUser.length,
              ),
            ),
          ),
        );
      },
    );
  }
}
