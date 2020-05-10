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
        let quizs: [Quiz] = load(csv: "quiz").map {
            let quiz = $0.components(separatedBy: ",")
            let choice = quiz.suffix(from: 2)
                .enumerated().map { "\n\($0.offset) \($0.element)" }.joined(separator: "")
            let question = "\(quiz[0])\n\n\(choice)"
            return Quiz(question: question, answerCount: 4, answer: Int(quiz[1])!)
        }
        return quizs
    }
    
    func load(csv fileName: String) -> [String] {
        if let csvPath = Bundle.main.path(forResource: fileName, ofType: "csv") {
            do {
                let csvData = try String(contentsOfFile: csvPath, encoding: String.Encoding.utf8)
                return csvData.components(separatedBy: "\n").filter { !$0.isEmpty }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        return []
    }
}
