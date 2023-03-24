enum Type { multiple }

enum Difficulty { easy, medium, hard }

enum BloomsTaxonomy { remember, understand, apply, analyze, evaluate, create }

enum Jobs { SST, JST }

class Question {
  final Jobs? job;
  final BloomsTaxonomy? Taxonomy;
  final String? categoryName;
  final Type? type;
  final Difficulty? difficulty;
  final String question;
  final String option1;
  final String option2;
  final String option3;
  final String option4;

  final String correctAnswer;

  Question(
      {required this.categoryName,
      required this.type,
      required this.difficulty,
      required this.Taxonomy,
      required this.question,
      required this.correctAnswer,
      required this.job,
      required this.option1,
      required this.option2,
      required this.option3,
      required this.option4});

  Question.fromMap(Map<String, dynamic> data)
      : categoryName = data["category"],
        type = Type.multiple,
        difficulty = data["difficulty"] == "easy"
            ? Difficulty.easy
            : data["difficulty"] == "medium"
                ? Difficulty.medium
                : Difficulty.hard,
        Taxonomy = data["bloomsTaxonomyLevel"] == "remember"
            ? BloomsTaxonomy.remember
            : data["bloomsTaxonomyLevel"] == "understand"
                ? BloomsTaxonomy.understand
                : data["bloomsTaxonomyLevel"] == "apply"
                    ? BloomsTaxonomy.apply
                    : data["bloomsTaxonomyLevel"] == "analyze"
                        ? BloomsTaxonomy.analyze
                        : data["bloomsTaxonomyLevel"] == "evaluate"
                            ? BloomsTaxonomy.evaluate
                            : BloomsTaxonomy.create,
        job = data["job"] == "JST" ? Jobs.JST : Jobs.SST,
        option1 = data["option1"],
        option2 = data["option2"],
        option3 = data["option3"],
        option4 = data["option4"],
        question = data["questionText"],
        correctAnswer = data["correctOption"];

  static List<Question> fromData(List<Map<String, dynamic>> data) {
    return data.map((question) => Question.fromMap(question)).toList();
  }
}
