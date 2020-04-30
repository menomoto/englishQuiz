struct Quiz {
    let question: String
    let answerCount: Int
    let answer: Int
}

class QuizFixture {
    static func test(
        question: String = "test",
        answerCount: Int = 4,
        answer: Int = 2
        ) -> Quiz {
        return Quiz(question: question, answerCount: answerCount, answer: answer)
    }    
}
