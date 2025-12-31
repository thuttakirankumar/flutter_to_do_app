import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do_app/1_domain/entities/unique_id.dart';

part 'navigation_todo_state.dart';

class NavigationTodoCubit extends Cubit<NavigationTodoState> {
  NavigationTodoCubit() : super(const NavigationTodoState());

  void selectedTodoCollectionChanged(CollectionId collectionId) {
    debugPrint(collectionId.value);
    emit(NavigationTodoState(
      selectedCollectionId: collectionId,
    ));
  }

  void secondaryBodyDisplayChanged({required bool isDisplayed}) {
    emit(NavigationTodoState(
      isSecondaryBodyDisplayed: isDisplayed,
      selectedCollectionId: state.selectedCollectionId,
    ));
  }
}
