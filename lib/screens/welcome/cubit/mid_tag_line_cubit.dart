import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'anim_end_text_state.dart';

class MidTagLineCubit extends Cubit<MidTagLineState> {
  MidTagLineCubit() : super(MidTagLineInitial());

  void animationEnded() {
    emit(MidTagLineDisplay());
  }
}
