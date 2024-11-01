part of 'prompt_bloc.dart';

@immutable
sealed class PromptState {}

final class PromptInitial extends PromptState {}

final class PromptGeneratingImageLoadState extends PromptState {}

final class PromptGeneratingImageSuccessState extends PromptState {
  final File file;

  PromptGeneratingImageSuccessState({required this.file});
}

final class PromptGeneratingImageErrorState extends PromptState {}
