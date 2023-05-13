import 'package:docker/Model/docker_model.dart';
import 'package:docker/cubit/states.dart';
import 'package:docker/shared/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MainCubit extends Cubit<MainStates>{
  MainCubit():super(MainInitialStates());

  static MainCubit get(context)=>BlocProvider.of(context);

  DockerModel ? dockerModel;
  List va=[];
  getData(){
    DioHelper.getData(
        url: 'persons',
    ).then((value){
      va=[];
      value.data.forEach((element) {
        dockerModel=DockerModel.fromJson(element);
        va.add(element);
      });
      emit(MainGetDataSuccessState());
    });
  }
  
  addData({
    required String id,
    required String name,
    required String email,
    required String gender,
    required String age,
}){
    DioHelper.postData(
        url: 'persons/',
        data: {
          'id':id,
          'name':name,
          'email':email,
          'gender':gender,
          'age':age,
        }
    ).then((value){
      Fluttertoast.showToast(
          msg: 'Added Successfully',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      emit(MainAddDataSuccessState());
      getData();
    }).catchError((error){

      Fluttertoast.showToast(
          msg: 'This id is already exist',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      emit(MainAddDataErrorState());
    });
  }

  deleteData({
    required String id
}){
    DioHelper.deleteData(
        url: 'persons/$id'
    ).then((value){
      emit(MainDeleteDataSuccessState());
      getData();
      Fluttertoast.showToast(
          msg: 'Deleted Successfully',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
    });
  }

  updateData({
    required String id1,
    required String id2,
    required String name,
    required String email,
    required String gender,
    required String age,
  }){
    DioHelper.putData(
        url: 'persons/$id1',
        data: {
          'id':id2,
          'name':name,
          'email':email,
          'gender':gender,
          'age':age,
        }
    ).then((value){
      Fluttertoast.showToast(
          msg: 'Updated Successfully',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      emit(MainAddDataSuccessState());
      getData();
    }).catchError((error){

    });
  }

}