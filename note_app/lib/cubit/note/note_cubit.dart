import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import '../../models/note_model.dart';
import '../../repository/network_repository.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  final networkRepository = NetworkRepository();
  NoteCubit() : super(NoteInitial());

  Future<void> addNote(NoteModel note) async {
    try {
      await networkRepository.addNote(note);
    } catch (_) {
      emit(NoteFailure());
    }
  }

  Future<void> getMyNotes(NoteModel note) async {
    emit(NoteLoading());
    try {
      final noteData = await networkRepository.getMyNotes(note);
      emit(NoteLoaded(noteData));
    } catch (_) {
      emit(NoteFailure());
    }
  }
}
