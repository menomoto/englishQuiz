import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    var results: [Bool] = []
    var time: TimeInterval = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Good job"
        navigationItem.hidesBackButton = true
        updateView()
    }
    
    private func updateView() {
        let collectResults = results.filter { (result) -> Bool in
            result == true
        }
        let rate = floor((Double(collectResults.count) / Double(results.count))*1000) / 10
        switch rate {
        case 80 ... 100:
            messageLabel.text = "Excellent!😆"
        case 60 ..< 80:
            messageLabel.text = "Very good!😋"
        case 1 ..< 60:
            messageLabel.text = "Nice!😉"
        default:
            messageLabel.text = "Oops!😥"
        }
        rateLabel.text = "Collect rate: \(rate)% \n" + String(format: "[%.2fsec]", time)
    }
    
    @IBAction func didTapRetryButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
