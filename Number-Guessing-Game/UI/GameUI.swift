import UIKit


extension GameViewController {
    // MARK: - UI Setup
    
    func setupUI() {
        view.backgroundColor = .backgroundVC
        
        // Label для отображения вводимого числа
        textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textAlignment = .center
        textLabel.font = UIFont.systemFont(ofSize: 30)
        textLabel.textColor = .white
        textLabel.backgroundColor = .labelSet
        textLabel.layer.cornerRadius = 15
        textLabel.clipsToBounds = true
        view.addSubview(textLabel)
        
        let imageView = UIImageView(image: UIImage(named: "game"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        setupButtons()
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textLabel.bottomAnchor.constraint(equalTo: buttonsStackView.topAnchor, constant: -20),
            textLabel.heightAnchor.constraint(equalToConstant: 80),
            
            imageView.bottomAnchor.constraint(equalTo: textLabel.topAnchor, constant: -20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            imageView.heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, multiplier: 0.29),
        ])
        updateUI()
    }
    // MARK: - UI Update and Alert Methods
    
    func updateUI() {
        if inputNumber.isEmpty {
            textLabel.text = "Угадай число"
        } else {
            textLabel.text = inputNumber
        }
    }
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Помощь", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}

