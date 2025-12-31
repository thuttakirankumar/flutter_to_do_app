import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class UniqueId extends Equatable {
  final String value;

  const UniqueId._(this.value);

  factory UniqueId() {
    return UniqueId._(const Uuid().v4());
  }

  factory UniqueId.fromString(String id) {
    return UniqueId._(id);
  }
  
  @override
  List<Object?> get props => [value];

}

class CollectionId extends UniqueId {
   const CollectionId._(String value) : super._(value);

    factory CollectionId() {
      return CollectionId._(const Uuid().v4());
    }

    factory CollectionId.fromString(String id) {
      return CollectionId._(id);
    }
}

class EntryId extends UniqueId {
   const EntryId._(String value) : super._(value);

    factory EntryId() {
      return EntryId._(const Uuid().v4());
    }

    factory EntryId.fromString(String id) {
      return EntryId._(id);
    }
}