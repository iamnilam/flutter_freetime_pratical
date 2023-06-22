class Note {
  late int _id;
  late String _title;
  late String _description;
  late String _date;
  late int _priority;

  Note(this._title, this._date, this._priority, {String? description})
      : _description = description ?? '';

  Note.withId(this._title, this._date, this._priority, {String? description})
      : _description = description ?? '';

  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get date => _date;
  int get priority => _priority;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      this._description = newDescription;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }

  set priority(int newPrioruty) {
    if (newPrioruty >= 1 && newPrioruty <= 2) {
      this._priority = newPrioruty;
    }
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['date'] = _date;
    return map;
  }

  Note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._priority = map['priority'];
    this._date = map['date'];
  }
}
