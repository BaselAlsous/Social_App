import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:social_app/Business/AppCubit/app_cubit.dart';

class CommentScreen extends StatelessWidget {
  final AppCubit? appCubit;
  final int index;
  const CommentScreen({Key? key, this.appCubit, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController commentTextEditingController =
        TextEditingController();
    return Scaffold(
      appBar: AppBar(),
      body: Builder(builder: (context) {
        AppCubit.get(context).getAllComment(idPost: appCubit?.postsId[index]);
        return BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            var allComment = AppCubit.get(context).allComment;

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 26.0.r,
                              backgroundImage: NetworkImage(allComment[index]
                                      .image ??
                                  "https://scontent.famm2-3.fna.fbcdn.net/v/t39.30808-6/271726145_484291389706577_7862530801905369924_n.jpg?_nc_cat=100&ccb=1-5&_nc_sid=09cbfe&_nc_eui2=AeGLJuISumO6qNT33cgX-93MMAnL4CKuJWowCcvgIq4lauQfW8KNbDi6C8res7OVGDkwzuVvcqXw4xnmd206Cu3P&_nc_ohc=wkh6Gpxh1G0AX9uL_qp&tn=ppmnZe700cmmCKj1&_nc_zt=23&_nc_ht=scontent.famm2-3.fna&oh=00_AT9Gj7d_Lx8_bp6BQYgg23M_ptYgRBs1t1LV6GUVizYhuA&oe=625BC68B"),
                            ),
                            SizedBox(
                              width: 10.0.w,
                            ),
                            SizedBox(
                              width: 250,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(allComment[index].name ?? 'data',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          ?.copyWith(fontSize: 18.0)),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    allComment[index].text ??
                                        "datadatadatadatadatadatadatadatadatadatadatadata",
                                    maxLines: 100,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: allComment.length,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey.shade400,
                                  width: 1.0,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.circular(20.0)),
                            child: TextFormField(
                              controller: commentTextEditingController,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Write Comment .....',
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          appCubit?.commentPost(
                            appCubit?.userData?.name,
                            appCubit?.userData?.image,
                            commentTextEditingController.text,
                            appCubit?.postsId[index],
                            DateTime.now().toString(),
                          );
                        },
                        icon: const Icon(Icons.send),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        );
      }),
    );
  }
}
