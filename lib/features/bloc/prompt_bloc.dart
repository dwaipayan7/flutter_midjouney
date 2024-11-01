import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter_midjouney/features/repository/prompt_repo.dart';
import 'package:meta/meta.dart';

part 'prompt_event.dart';
part 'prompt_state.dart';

class PromptBloc extends Bloc<PromptEvent, PromptState> {
  PromptBloc() : super(PromptInitial()) {

    on<PromptEnteredEvent>(promptEnteredEvent);

  }

  Future<void> promptEnteredEvent(
      PromptEnteredEvent event,
      Emitter<PromptState> emit) async {

    emit(PromptGeneratingImageLoadState());
    File? file = await PromptRepository.generateImage(event.prompt);
    if(file != null){
      emit(PromptGeneratingImageSuccessState(file: file));
    }else{
      emit(PromptGeneratingImageErrorState());
    }

  }
}
