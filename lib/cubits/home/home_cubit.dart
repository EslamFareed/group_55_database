import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

  final firestore = FirebaseFirestore.instance;

  final auth = FirebaseAuth.instance;

  List<Map<String, dynamic>> friends = [];

  void getFriends() async {
    friends = [];
    emit(LoadingGetFriendsState());
    try {
      var data = await firestore
          .collection("friends")
          .where("status", isEqualTo: "accepted")
          .get();

      for (var element in data.docs) {
        if (element.data()["sender"] == auth.currentUser!.uid ||
            element.data()["receiver"] == auth.currentUser!.uid) {
          friends.add(element.data());
        }
      }

      emit(SuccessGetFriendsState());
    } catch (e) {
      emit(ErrorGetFriendsState());
    }
  }
}
