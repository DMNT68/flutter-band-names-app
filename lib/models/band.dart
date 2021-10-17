class Band {
  String id;
  String name;
  int votes;

  Band({
    required this.id,
    required this.name,
    required this.votes
  });

  Band.forMap(Map<String, dynamic>obj):
    id = obj.containsKey('id') ?  obj['id'] : 'no-id',
    name= obj.containsKey('name') ? obj['name'] : 'no-name',
    votes = obj.containsKey('votes') ? obj['votes'] : 'no-votes';
}