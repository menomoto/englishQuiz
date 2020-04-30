import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didTapButton(_ sender: Any) {
        let vc = QuizViewController()
        vc.englishQuizzes = fetchQuizzes()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    private func fetchQuizzes() -> [Quiz] {
        return [
            QuizFixture.test(
                question: "Which is red fruit?\n\n1) Banana\n2) Apple\n3) Lemon\n4) Kiwi",
                answerCount: 4, answer: 2),
            QuizFixture.test(
                question: "Which animal is fast to run?\n\n1) Panda \n2) Elephant \n3) Giraffe \n4) Cheetah",
                answerCount: 4, answer: 4),
            QuizFixture.test(
                question: "How many minutes a day?\n\n1) 1680 min\n2) 2880 min\n3) 1440 min",
                answerCount: 3, answer: 3),
        ]
    }
}

