import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kt_dart/collection.dart';
import 'package:resonote/domain/core/failures.dart';
import 'package:resonote/domain/core/value_object.dart';
import 'package:resonote/domain/notes/value_objects.dart';

import 'todo_item.dart';

part 'note.freezed.dart';

@freezed
abstract class Note implements _$Note {
  const Note._();

  const factory Note({
    required UniqueID id,
    required NoteBody body,
    required NoteColor color,
    required ListOf3<TodoItem> todos,
  }) = _Note;

  factory Note.empty() => Note(
        id: UniqueID(),
        body: NoteBody(""),
        color: NoteColor(NoteColor.defaultColors[0]),
        todos: ListOf3(const KtList.empty()),
      );

  Option<ValueFailure<dynamic>> get failureOption {
    return body.failureOrUnit
        .andThen(todos.failureOrUnit)
        .andThen(
          todos
              .getOrCrash()!
							// Getting the failureOption from the TodoItem ENTITY - NOT a failureOrUnit from a VALUE OBJECT
              .map((todoItem) => todoItem.failureOption)
              .filter((o) => o.isSome())
							// If we can't get the 0th element, the list is empty. In such a case, it's valid.
              .getOrElse(0, (_) => none())
              .fold(() => right(unit), (f) => left(f)),
        )
        .fold(
          (f) => some(f),
          (_) => none(),
        );
  }
}
