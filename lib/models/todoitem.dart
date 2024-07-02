//oggetto che rappresenta una cosa da fare
class todoItem {
  final String id; //univoco
  final String title;
  final bool done;
  final String? description; //descrizione opzionale

  //costruttore immutabile
  const todoItem(this.id, this.title, this.done, [this.description]);

  todoItem withDone(bool newdone) {
    return todoItem(id, title, newdone, description);
  }

  todoItem withDescription(String? newDescription) {
    return todoItem(id, title, done, newDescription);
  }

  todoItem withTitle(String newTitle) {
    return todoItem(id, newTitle, done, description);
  }

  @override
  String toString() {
    return "($id: $title (${done ? "done" : "not done"})";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is todoItem) {
      return (id == other.id &&
          title == other.title &&
          done == other.done &&
          description == other.description);
    }
    return false;
  }
}
