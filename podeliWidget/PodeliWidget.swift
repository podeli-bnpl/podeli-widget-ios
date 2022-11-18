//
//  PoedliWidget.swift
//  podeliWidget
//
//  Created by Николай Малофеев on 14.11.2022.
//

import Foundation
import UIKit

public final class PodeliWidgetView: UIView {
    
    // MARK: - Properties
    
    private enum Constants {
        static let leftInset: CGFloat = 16
        static let rightInset: CGFloat = 16
        static let separatorHeight: CGFloat = 3
        static let stackViewHeight: CGFloat = 38
        static let stackViewWidth: CGFloat = 74

    }

    private var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.borderColor = UIColor(hexString: "E6E6E6").cgColor
        view.layer.borderWidth = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var totalPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexString: "323232")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var firstDateLabel = UILabel()
    private var secondDateLabel = UILabel()
    private var thirdDateLabel = UILabel()
    private var fourthDateLabel = UILabel()

    private var firstPriceLabel = UILabel()
    private var secondPriceLabel = UILabel()
    private var thirdPriceLabel = UILabel()
    private var fourthPriceLabel = UILabel()
    
    private var logoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    public func configureWith(price: Double) {
        configureLabelsWith(price: price)
        configureLabelsWithDate()
    }
    
    func configureLabelsWith(price: Double) {
        
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        
        let part = price / 4
        let partPrice = formatter.string(from: part as NSNumber) ?? ""
        let fullPrice = formatter.string(from: price as NSNumber) ?? ""

        totalPriceLabel.text = "\(fullPrice) ₽"
        firstPriceLabel.text = "\(partPrice) ₽"
        secondPriceLabel.text = "\(partPrice) ₽"
        thirdPriceLabel.text = "\(partPrice) ₽"
        fourthPriceLabel.text = "\(partPrice) ₽"
    }
    
    func configureLabelsWithDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"
        dateFormatter.locale = Locale(identifier: "ru_RU")

        let secondDate = dateFormatter.string(from: addWeeksToDate(numberOfWeek: 2))
        let thirdDate = dateFormatter.string(from: addWeeksToDate(numberOfWeek: 4))
        let fourthDate = dateFormatter.string(from: addWeeksToDate(numberOfWeek: 6))
        
        firstDateLabel.text = "Cегодня"

        secondDateLabel.text = "\(secondDate)"
        thirdDateLabel.text = "\(thirdDate)"
        fourthDateLabel.text = "\(fourthDate)"
    }
    
    func addWeeksToDate(numberOfWeek: Int) -> Date {
        let calendar = Calendar.current
        guard let addWeekToDate = calendar.date(byAdding: .weekOfYear, value: numberOfWeek, to: Date()) else { return Date()}
        return addWeekToDate
    }
    
    func setupView() {
        containerView.addSubview(totalPriceLabel)
        containerView.addSubview(logoImageView)
        addFrameEqualitySubview(containerView)

        let firstSeparator = prepareSeparator()
        let secondSeparator = prepareSeparator()
        let thirdSeparator = prepareSeparator()
        let fourthSeparator = prepareSeparator()
        
        logoImageView.image = UIImage(named: "podeliLogo.png")
        
        firstSeparator.backgroundColor = UIColor(hexString: "EE3124")

        let firstStack = UIStackView(arrangedSubviews: [firstSeparator, firstDateLabel, firstPriceLabel])
        let secondStack = UIStackView(arrangedSubviews: [secondSeparator, secondDateLabel, secondPriceLabel])
        let thirdStack = UIStackView(arrangedSubviews: [thirdSeparator, thirdDateLabel, thirdPriceLabel])
        let fourthStack = UIStackView(arrangedSubviews: [fourthSeparator, fourthDateLabel, fourthPriceLabel])
        
        [firstDateLabel, secondDateLabel, thirdDateLabel, fourthDateLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.font = UIFont(name: "Styrene B LC", size: 10)
            $0.textColor = UIColor(hexString: "AEAEAE")
        }
        [firstPriceLabel, secondPriceLabel, thirdPriceLabel, fourthPriceLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.font = UIFont(name: "Styrene B LC", size: 11)
            $0.textColor = UIColor(hexString: "323232")
        }
        
        let stackMain = UIStackView(arrangedSubviews: [firstStack, secondStack, thirdStack, fourthStack])
        stackMain.translatesAutoresizingMaskIntoConstraints = false
        stackMain.distribution = .equalSpacing
        stackMain.axis = .horizontal
        
        containerView.addSubview(stackMain)

        [firstStack, secondStack, thirdStack, fourthStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.distribution = .equalSpacing
            $0.axis = .vertical
            $0.spacing = 6
        }
        totalPriceLabel.font = UIFont(name: "Styrene B LC", size: 16)

        let constraints = [
            containerView.heightAnchor.constraint(equalToConstant: 80),
            
            totalPriceLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: Constants.leftInset),
            totalPriceLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 13),
            totalPriceLabel.heightAnchor.constraint(equalToConstant: 16),
            
            logoImageView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -Constants.rightInset),
            logoImageView.topAnchor.constraint(equalTo: totalPriceLabel.topAnchor, constant: 0),
            logoImageView.heightAnchor.constraint(equalToConstant: 13),
            logoImageView.widthAnchor.constraint(equalToConstant: 80),
            
            firstSeparator.widthAnchor.constraint(equalToConstant: 74),
            firstSeparator.heightAnchor.constraint(equalToConstant: 3),
            secondSeparator.widthAnchor.constraint(equalToConstant: 74),
            secondSeparator.heightAnchor.constraint(equalToConstant: 3),
            thirdSeparator.widthAnchor.constraint(equalToConstant: 74),
            thirdSeparator.heightAnchor.constraint(equalToConstant: 3),
            fourthSeparator.widthAnchor.constraint(equalToConstant: 74),
            fourthSeparator.heightAnchor.constraint(equalToConstant: 3),
            
            stackMain.topAnchor.constraint(equalTo: totalPriceLabel.bottomAnchor, constant: 7),
            stackMain.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 16),
            stackMain.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -16),
            stackMain.heightAnchor.constraint(equalToConstant: Constants.stackViewHeight),

            firstStack.heightAnchor.constraint(equalToConstant: Constants.stackViewHeight),
            firstStack.widthAnchor.constraint(equalToConstant: Constants.stackViewWidth),
            secondStack.heightAnchor.constraint(equalToConstant: Constants.stackViewHeight),
            secondStack.widthAnchor.constraint(equalToConstant: Constants.stackViewWidth),
            thirdStack.heightAnchor.constraint(equalToConstant: Constants.stackViewHeight),
            thirdStack.widthAnchor.constraint(equalToConstant: Constants.stackViewWidth),
            fourthStack.heightAnchor.constraint(equalToConstant: Constants.stackViewHeight),
            fourthStack.widthAnchor.constraint(equalToConstant: Constants.stackViewWidth)
        ]

        NSLayoutConstraint.activate(constraints)
        
    }
    
    func prepareSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "D9D9D9")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 2
        return view
    }
}

extension UIView {
    func addFrameEqualityConstraints(to view: UIView, withMargins margins: UIEdgeInsets = .zero) {
        let constraints = [
            leftAnchor.constraint(equalTo: view.leftAnchor, constant: margins.left),
            rightAnchor.constraint(equalTo: view.rightAnchor, constant: margins.right),
            topAnchor.constraint(equalTo: view.topAnchor, constant: margins.top),
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: margins.top)
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func addFrameEqualitySubview(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        addFrameEqualityConstraints(to: subview)
    }
}
