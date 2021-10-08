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
    id =  obj['id']!,
    name= obj['name']!,
    votes = obj['votes']!;
}