import UIKit

protocol GameResultDelegate: AnyObject {
    func didTapContinue()
    func didTapNewGame()
}

class GameResultViewController: UIViewController {
    // MARK: - Properties
    
    var attempts: Int = 0
    var isNumberGuessed: Bool = false
    
    weak var delegate: GameResultDelegate?
    
    // MARK: - UI Elements
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let resultMessLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Продолжить", for: .normal)
        button.tintColor = UIColor.white
        button.backgroundColor = .continueButton
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.widthAnchor.constraint(equalToConstant: 190).isActive = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var newGameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Начать новую игру", for: .normal)
        button.tintColor = UIColor.white
        button.backgroundColor = .nextButton
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        button.widthAnchor.constraint(equalToConstant: 190).isActive = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(newGameButtonPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        updateUI()
    }
    
    // MARK: - Button Actions
    
    @objc func continueButtonPressed() {
        delegate?.didTapContinue()
        dismiss(animated: true, completion: nil)
    }
    
    @objc func newGameButtonPressed() {
        delegate?.didTapNewGame()
        dismiss(animated: true, completion: nil)
    }
}

