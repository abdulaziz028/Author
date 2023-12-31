
import 'package:author/models/Work.dart';
import 'package:author/Repositories/work_repository.dart';
import 'package:author/Cubit/work_state.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

class WorkCubit extends Cubit<WorkState>{
  final WorkRepository workRepository;
   WorkCubit(this.workRepository) : super(WorkInitial());

   initializePage(String key)async{
    emit(WorkLoading());
    List<Work> work =await  workRepository.listWork(key);
    emit(WorkLoaded(work));
   }
}