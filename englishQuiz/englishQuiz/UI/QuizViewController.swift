import UIKit
import AudioToolbox

class QuizViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerStackView: UIStackView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    
    var englishQuizzes: [Quiz] = []
    private var index: Int = 0
    private var englishQuiz: Quiz { return englishQuizzes[index] }
    private var results: [Bool] = []
    private var timer: Timer?
    private var startTime = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.setRightBarButton(UIBarButtonItem(title: "Quit", style: .done, target: self, action: #selector(didTapQuitButton)), animated: false)
        updateView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer?.invalidate()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
        startTime = Date()
    }
    
    @objc private func timerCounter() {
        let currentTime = Date().timeIntervalSince(startTime)
        timerLabel.text = "elapsed time: \(Int(currentTime)) sec"
    }
    
    private func updateView() {
        title = "Question \(index + 1)"
        questionLabel.text = englishQuiz.question
        configureBottomView()
    }
    
    private func configureBottomView() {
        answerStackView.subviews.forEach{ $0.removeFromSuperview() }
        (1...englishQuiz.answerCount).forEach {
            answerStackView.addArrangedSubview(setupAnswerButton(with: $0))
        }
    }
    
    private func setupAnswerButton(with number: Int) -> UIButton {
        let button = UIButton()
        button.setTitleColor(UIColor.black.withAlphaComponent(0.72), for: .normal)
        button.backgroundColor = UIColor.white.withAlphaComponent(0.54)
        button.layer.cornerRadius = answerStackView.frame.height / 8
        button.setTitle("\(number)", for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }
    
    @objc func didTapButton(_ sender: UIButton) {
        guard let answerString = sender.titleLabel?.text,
            let answer = Int(answerString) else { return }
        check(with: answer)
    }
    
    private func check(with answer: Int) {
        resultView.isUserInteractionEnabled = true

        if englishQuiz.answer == answer {
            resultLabel.text = "○"
            resultLabel.textColor = UIColor.blue
            results.append(true)
            AudioServicesPlaySystemSound(1025)
        } else {
            resultLabel.text = "×"
            resultLabel.textColor = UIColor.red
            results.append(false)
            AudioServicesPlaySystemSound(1006)
        }
        resultLabel.alpha = 0
        resultLabel.isHidden = false
        let finishTime = Date().timeIntervalSince(startTime)
        UIView.animate(withDuration: 0.7, delay: 0, options: [], animations: { [weak self] in
            self?.resultLabel.alpha = 1
        }) { [weak self] (_) in
            self?.transition(time: finishTime)
            self?.resultView.isUserInteractionEnabled = false
        }
    }
    
    private func transition(time: TimeInterval) {
        self.resultLabel.isHidden = true
        index += 1
        if englishQuizzes.count > index {
            updateView()
        } else {
            let vc = ResultViewController()
            vc.results = self.results
            vc.time = time
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc private func didTapQuitButton() {
        dismiss(animated: true, completion: nil)
    }
}
