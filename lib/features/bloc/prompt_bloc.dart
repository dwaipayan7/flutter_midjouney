import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../repository/prompt_repo.dart';

part 'prompt_event.dart';
part 'prompt_state.dart';

class PromptBloc extends Bloc<PromptEvent, PromptState> {
  PromptBloc() : super(PromptInitial()) {
    on<PromptInitialEvent>(_promptInitialEvent);
    on<PromptEnteredEvent>(_promptEnteredEvent);
  }

  FutureOr<void> _promptEnteredEvent(
      PromptEnteredEvent event, Emitter<PromptState> emit) async {
    emit(PromptGeneratingImageLoadState());

    // Generate image based on the prompt and get the Uint8List bytes
    Uint8List? bytes = await PromptRepo.generateImage(event.prompt);
    if (bytes != null) {
      emit(PromptGeneratingImageSuccessState(unit8list: bytes));
    } else {
      emit(PromptGeneratingImageErrorState());
    }
  }

  FutureOr<void> _promptInitialEvent(
      PromptInitialEvent event, Emitter<PromptState> emit) async {
    try {
      // Load an image from local assets at initialization
      Uint8List bytes = await File(
          'C:/Users/Dwaipayan Biswas/StudioProjects/flutter_midjouney/assets/file.png')
          .readAsBytes();
      emit(PromptGeneratingImageSuccessState(unit8list: bytes));
    } catch (e) {
      emit(PromptGeneratingImageErrorState());
    }
  }
}
