class AiProject {
  String? name;
  String? description;
  List<String>? tasks;

  AiProject({
    this.name,
    this.description,
    this.tasks,
  });

  factory AiProject.fromJson(Map<String, dynamic> json) => AiProject(
    name: json["name"],
    description: json["description"],
    tasks: json["tasks"] == null ? [] : List<String>.from(json["tasks"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "tasks": tasks == null ? [] : List<dynamic>.from(tasks!.map((x) => x)),
  };
}