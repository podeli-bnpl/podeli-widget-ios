//
//  PoedliWidget.swift
//  podeliWidget
//
//  Created by Николай Малофеев on 14.11.2022.
//

import Foundation
import UIKit

public protocol PodeliWidgetDelegate: AnyObject {
    func showInfoService()
}

public final class PodeliWidgetView: UIView {
    
    // MARK: - Properties
    
    private enum Constants {
        static let leftInset: CGFloat = 16
        static let rightInset: CGFloat = 16
        static let separatorHeight: CGFloat = 3
        static let stackViewHeight: CGFloat = 38
        static let stackViewWidth: CGFloat = 74
    }
    
    public weak var delegate: PodeliWidgetDelegate?
    
    
    private var firstSeparator = UIView()
    private var secondSeparator = UIView()
    private var thirdSeparator = UIView()
    private var fourthSeparator = UIView()
    
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
    
    private var serviceInfoLabel = UILabel()
    
    
    private var logoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.image = UIImage(named: "podeliLogoLight.png")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private var serviceInfoImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.image = UIImage(named: "infoLight.png")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private var serviceInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureWithPercents()
        setupView()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureWithPercents()
        setupView()
    }
    
    func configureWithPercents() {
        totalPriceLabel.text = "100%"
        firstPriceLabel.text = "25%"
        secondPriceLabel.text = "25%"
        thirdPriceLabel.text = "25%"
        fourthPriceLabel.text = "25%"
        configureLabelsWithDate()
        
    }
    
    public func configure(with price: Double?) {
        configureLabelsWithDate()
        guard let price = price else {
            configureWithPercents()
            return
        }
        configureLabelsWith(price: price)
    }
    
    func configureLabelsWith(price: Double) {
        
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.roundingMode = .up
        formatter.decimalSeparator = "."
        let part = (price / 4)
        
        let partPrice = formatter.string(from: part as NSNumber) ?? ""
        let fullPrice = formatter.string(from: price as NSNumber) ?? ""
        
        guard let roundedPart = Double(partPrice) else { return }
        
        let fouthPart = price - roundedPart * 3
        
        let lastPriceFormatter = NumberFormatter()
        lastPriceFormatter.minimumFractionDigits = 0
        lastPriceFormatter.maximumFractionDigits = 2
        
        let lastPrice = lastPriceFormatter.string(from: fouthPart as NSNumber) ?? ""
        
        totalPriceLabel.text = "\(fullPrice) ₽"
        firstPriceLabel.text = "\(partPrice) ₽"
        secondPriceLabel.text = "\(partPrice) ₽"
        thirdPriceLabel.text = "\(partPrice) ₽"
        fourthPriceLabel.text = "\(lastPrice) ₽"
        
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
        UIFont.loadFonts()
        containerView.addSubview(totalPriceLabel)
        containerView.addSubview(logoImageView)
        containerView.addSubview(serviceInfoLabel)
        containerView.addSubview(serviceInfoImageView)
        addFrameEqualitySubview(containerView)
        serviceInfoLabel.text = "Краткие условия сервиса"
        serviceInfoStackView.addArrangedSubview(serviceInfoLabel)
        serviceInfoStackView.addArrangedSubview(serviceInfoImageView)
        containerView.addSubview(serviceInfoStackView)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(showServiceInfo))
        serviceInfoStackView.isUserInteractionEnabled = true
        serviceInfoStackView.addGestureRecognizer(tapGestureRecognizer)
        
        
        let bundle = Bundle(for: PodeliWidgetView.self)
        
        
        let firstStack = UIStackView(arrangedSubviews: [firstSeparator, firstDateLabel, firstPriceLabel])
        let secondStack = UIStackView(arrangedSubviews: [secondSeparator, secondDateLabel, secondPriceLabel])
        let thirdStack = UIStackView(arrangedSubviews: [thirdSeparator, thirdDateLabel, thirdPriceLabel])
        let fourthStack = UIStackView(arrangedSubviews: [fourthSeparator, fourthDateLabel, fourthPriceLabel])
        
        [firstDateLabel, secondDateLabel, thirdDateLabel, fourthDateLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.font = UIFont(name: "StyreneBLC-Medium", size: 10)
            $0.textColor = UIColor(hexString: "AEAEAE")
        }
        [firstPriceLabel, secondPriceLabel, thirdPriceLabel, fourthPriceLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.font = UIFont(name: "StyreneBLC-Medium", size: 11)
            $0.textColor = UIColor(hexString: "323232")
            if #available(iOS 13.0, *) {
                $0.textColor = UITraitCollection.current.userInterfaceStyle == .dark ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.1960784314, green: 0.1960784314, blue: 0.1960784314, alpha: 1)
            }
        }
        
        serviceInfoLabel.font = UIFont(name: "StyreneBLC-Medium", size: 11)
        serviceInfoLabel.textColor = UIColor(hexString: "323232")
        serviceInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let infoGesture = UITapGestureRecognizer(target: self, action: #selector(showServiceInfo))
        serviceInfoLabel.isUserInteractionEnabled = true
        serviceInfoLabel.addGestureRecognizer(infoGesture)
        
        [firstSeparator, secondSeparator, thirdSeparator, fourthSeparator].forEach {
            $0.backgroundColor = UIColor(hexString: "D9D9D9")
            if #available(iOS 13.0, *) {
                $0.backgroundColor = UITraitCollection.current.userInterfaceStyle == .dark ? #colorLiteral(red: 0.3843137255, green: 0.3843137255, blue: 0.3843137255, alpha: 1) : #colorLiteral(red: 0.8509803922, green: 0.8509803922, blue: 0.8509803922, alpha: 1)
            }
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 2
        }
        
        firstSeparator.backgroundColor = UIColor(hexString: "EE3124")
        
        let stackMain = UIStackView(arrangedSubviews: [firstStack, secondStack, thirdStack, fourthStack])
        stackMain.translatesAutoresizingMaskIntoConstraints = false
        stackMain.distribution = .equalSpacing
        stackMain.axis = .horizontal
        stackMain.spacing = 5
        
        containerView.addSubview(stackMain)
        
        [firstStack, secondStack, thirdStack, fourthStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.distribution = .equalSpacing
            $0.axis = .vertical
        }
        
        totalPriceLabel.font = UIFont(name: "StyreneBLC-Medium", size: 16)
        
        var separatorWidth: CGFloat = Constants.stackViewWidth
        let screenWidth: CGFloat = UIScreen.main.bounds.size.width
        
        if screenWidth <= 320  {
            separatorWidth = 60
        }
        if #available(iOS 13.0, *) {
            totalPriceLabel.textColor = UITraitCollection.current.userInterfaceStyle == .dark ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.1960784314, green: 0.1960784314, blue: 0.1960784314, alpha: 1)
            containerView.layer.borderColor = UITraitCollection.current.userInterfaceStyle == .dark ? #colorLiteral(red: 0.3843137255, green: 0.3843137255, blue: 0.3843137255, alpha: 1) : #colorLiteral(red: 0.8509803922, green: 0.8509803922, blue: 0.8509803922, alpha: 1)
            containerView.backgroundColor = UITraitCollection.current.userInterfaceStyle == .dark ? #colorLiteral(red: 0.2651473284, green: 0.2651473284, blue: 0.2651473284, alpha: 1) : #colorLiteral(red: 1.00000000000, green: 1.00000000000, blue: 1.00000000000, alpha: 1)
            serviceInfoLabel.textColor = UITraitCollection.current.userInterfaceStyle == .dark ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0.1960784314, green: 0.1960784314, blue: 0.1960784314, alpha: 1)
            let podeliLogo = UITraitCollection.current.userInterfaceStyle == .dark ? "podeliLogoDark.png": "podeliLogoLight.png"
            let infoLogo = UITraitCollection.current.userInterfaceStyle == .dark ? "infoDark.png": "infoLight.png"
            logoImageView.image = UIImage(named: podeliLogo, in: bundle, with: nil)
            serviceInfoImageView.image = UIImage(named: infoLogo, in: bundle, with: nil)
        }
        
        let constraints = [
            self.heightAnchor.constraint(equalToConstant: 102),
            
            
            
            totalPriceLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: Constants.leftInset),
            totalPriceLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 13),
            totalPriceLabel.heightAnchor.constraint(equalToConstant: 16),
            
            logoImageView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -Constants.rightInset),
            logoImageView.topAnchor.constraint(equalTo: totalPriceLabel.topAnchor, constant: 0),
            logoImageView.heightAnchor.constraint(equalToConstant: 13),
            logoImageView.widthAnchor.constraint(equalToConstant: 80),
            
            serviceInfoImageView.heightAnchor.constraint(equalToConstant: 12),
            serviceInfoImageView.widthAnchor.constraint(equalToConstant: 12),
            serviceInfoImageView.centerYAnchor.constraint(equalTo: serviceInfoStackView.centerYAnchor),
            serviceInfoLabel.centerYAnchor.constraint(equalTo: serviceInfoStackView.centerYAnchor),

            serviceInfoLabel.heightAnchor.constraint(equalToConstant: 12),
            serviceInfoStackView.topAnchor.constraint(equalTo: firstPriceLabel.bottomAnchor, constant: 5),
            serviceInfoStackView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: Constants.leftInset),

            
            firstSeparator.widthAnchor.constraint(equalToConstant: separatorWidth),
            firstSeparator.heightAnchor.constraint(equalToConstant: 3),
            secondSeparator.widthAnchor.constraint(equalToConstant: separatorWidth),
            secondSeparator.heightAnchor.constraint(equalToConstant: 3),
            thirdSeparator.widthAnchor.constraint(equalToConstant: separatorWidth),
            thirdSeparator.heightAnchor.constraint(equalToConstant: 3),
            fourthSeparator.widthAnchor.constraint(equalToConstant: separatorWidth),
            fourthSeparator.heightAnchor.constraint(equalToConstant: 3),
            
            stackMain.topAnchor.constraint(equalTo: totalPriceLabel.bottomAnchor, constant: 7),
            stackMain.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: Constants.leftInset),
            stackMain.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -Constants.rightInset),
            stackMain.heightAnchor.constraint(equalToConstant: Constants.stackViewHeight),
            
            firstStack.heightAnchor.constraint(equalToConstant: Constants.stackViewHeight),
            firstStack.widthAnchor.constraint(equalToConstant: separatorWidth),
            secondStack.heightAnchor.constraint(equalToConstant: Constants.stackViewHeight),
            secondStack.widthAnchor.constraint(equalToConstant:separatorWidth),
            thirdStack.heightAnchor.constraint(equalToConstant: Constants.stackViewHeight),
            thirdStack.widthAnchor.constraint(equalToConstant: separatorWidth),
            fourthStack.heightAnchor.constraint(equalToConstant: Constants.stackViewHeight),
            fourthStack.widthAnchor.constraint(equalToConstant: separatorWidth)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setupView()
        self.layoutIfNeeded()
    }
    
    @objc private func showServiceInfo() {
        delegate?.showInfoService()
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
