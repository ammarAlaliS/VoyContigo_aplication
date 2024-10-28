import 'package:hydrated_bloc/hydrated_bloc.dart';

// Estado para ScrollControllerCubit
class ScrollState {
  final double position;
  final bool isMovingToBottom;

  ScrollState({this.position = 0.0, this.isMovingToBottom = false});

  ScrollState copyWith({double? position, bool? isMovingToBottom}) {
    return ScrollState(
      position: position ?? this.position,
      isMovingToBottom: isMovingToBottom ?? this.isMovingToBottom,
    );
  }
}

// ScrollControllerCubit
class ScrollControllerCubit extends HydratedCubit<ScrollState> {
  ScrollControllerCubit() : super(ScrollState());

  void updateScrollPosition(double position) {
    if (position >= 0) {
      emit(state.copyWith(position: position));
    }
  }

  void updateIsScrollMovingToBottom(bool isMovingToBottom) {
    emit(state.copyWith(isMovingToBottom: isMovingToBottom));
  }

  @override
  ScrollState? fromJson(Map<String, dynamic> json) {
    return ScrollState(
      position: json['position'] as double? ?? 0.0,
      isMovingToBottom: json['isMovingToBottom'] as bool? ?? false,
    );
  }

  @override
  Map<String, dynamic>? toJson(ScrollState state) {
    return {
      'position': state.position,
      'isMovingToBottom': state.isMovingToBottom,
    };
  }
}
