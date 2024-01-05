import UIKit

extension GameViewController {
    // MARK: - Buttons Setup
    
    func setupButtons() {
        let row1 = createButtonRow(buttonTitles: ["1", "2", "3"])
        let row2 = createButtonRow(buttonTitles: ["4", "5", "6"])
        let row3 = createButtonRow(buttonTitles: ["7", "8", "9"])
        let row4 = createButtonRow(buttonTitles: ["Стереть", "0", "Подтвердить"])
        
        buttonsStackView.addArrangedSubview(row1)
        buttonsStackView.addArrangedSubview(row2)
        buttonsStackView.addArrangedSubview(row3)
        buttonsStackView.addArrangedSubview(row4)
        
        view.addSubview(buttonsStackView)
        
        NSLayoutConstraint.activate([
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            buttonsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
        ])
    }
    
    private func createButtonRow(buttonTitles: [String]) -> UIStackView {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        for title in buttonTitles {
            let button: UIButton
            if title == "Стереть" {
                button = UIButton(type: .system)
                button.setImage(UIImage(systemName: "xmark"), for: .normal)
                button.tintColor = UIColor.white
                let configuration = UIImage.SymbolConfiguration(pointSize: 30)
                button.setPreferredSymbolConfiguration(configuration, forImageIn: .normal)
                button.addTarget(self, action: #selector(clearButtonPressed), for: .touchUpInside)
            } else if title == "Подтвердить" {
                button = UIButton(type: .system)
                button.setImage(UIImage(systemName: "checkmark"), for: .normal)
                button.tintColor = UIColor.white
                let configuration = UIImage.SymbolConfiguration(pointSize: 30)
                button.setPreferredSymbolConfiguration(configuration, forImageIn: .normal)
                button.addTarget(self, action: #selector(confirmButtonPressed), for: .touchUpInside)
            } else {
                button = UIButton(type: .system)
                button.setTitle(title, for: .normal)
                button.addTarget(self, action: #selector(numberButtonPressed(_:)), for: .touchUpInside)
            }
            
            if  title == "Подтвердить" {
                button.backgroundColor = .nextButton
            } else if title == "Стереть" {
                button.backgroundColor = .eraseButton
            } else {
                button.backgroundColor = .buttonAll
            }
            
            button.layer.cornerRadius = 10
            button.clipsToBounds = true
            button.heightAnchor.constraint(equalToConstant: 60).isActive = true
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
            button.setTitleColor(.white, for: .normal)
            button.addTarget(self, action: #selector(numberButtonPressed(_:)), for: .touchUpInside)
            button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(button)
        }
        return stackView
    }
}
