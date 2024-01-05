import UIKit

extension GameResultViewController {
    
    // MARK: - UI Setup
    
    func setupUI() {
        view.backgroundColor = UIColor(red: 35/255, green: 35/255, blue: 35/255, alpha: 1.0)
        
        view.addSubview(resultLabel)
        view.addSubview(resultMessLabel)
        view.addSubview(continueButton)
        view.addSubview(newGameButton)
        
        resultLabel.font = UIFont.systemFont(ofSize: 30)
        resultLabel.textColor = .white
        
        
        resultMessLabel.font = UIFont.systemFont(ofSize: 20)
        resultMessLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.bottomAnchor.constraint(equalTo: resultMessLabel.topAnchor, constant: -20),
            
            resultMessLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultMessLabel.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -20),
            
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            continueButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            newGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newGameButton.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: 20)
        ])
    }
    
    // MARK: - UI Update
    
    func updateUI() {
        if isNumberGuessed {
            resultLabel.text = "Попыток: \(attempts)"
            resultMessLabel.text = "Поздравляю! Вы угадали число."
        } else {
            resultLabel.text = "Попыток: \(attempts)"
            resultMessLabel.text = "К сожалению, вы не угадали число."
        }
    }
}
