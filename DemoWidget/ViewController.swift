//
//  ViewController.swift
//  DemoWidget
//
//  Created by Николай Малофеев on 14.11.2022.
//

import UIKit
import podeliWidget

class ViewController: UIViewController {
    
    private let widgetView = PodeliWidgetView()
    private let textField = UITextField()
    private let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Метод для подгрузки и разбиения цены
//        widgetView.configureWithPercents()
        widgetView.configureWith(price: 3000)
        
        widgetView.layer.masksToBounds = true
        widgetView.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Цена"
        textField.delegate = self
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 6
        button.addTarget(self, action: #selector(order), for: .touchUpInside)
        button.setTitle("поделить", for: .normal)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0.9333, green: 0.1922, blue: 0.1412, alpha: 1)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(widgetView)
        view.addSubview(textField)
        view.addSubview(button)
        
        
        NSLayoutConstraint.activate([
            widgetView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            widgetView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            widgetView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            button.heightAnchor.constraint(equalToConstant: 30),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 100),
            
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            
            textField.heightAnchor.constraint(equalToConstant: 30),
            textField.widthAnchor.constraint(equalToConstant: 100),
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 200)
        ])
    }
    
    @objc func order() {
        guard let price = Double(textField.text!) else { return  }
        widgetView.configureWith(price: price)
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet(charactersIn:"0123456789.")
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
        
    }
}

