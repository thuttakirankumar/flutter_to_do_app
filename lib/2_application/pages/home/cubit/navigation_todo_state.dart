part of 'navigation_todo_cubit.dart';

class NavigationTodoState extends Equatable {
  final CollectionId? selectedCollectionId;
  final bool? isSecondaryBodyDisplayed;

  const NavigationTodoState({
    this.selectedCollectionId,
    this.isSecondaryBodyDisplayed,
  });

  @override
  List<Object?> get props => [selectedCollectionId, isSecondaryBodyDisplayed];
}
