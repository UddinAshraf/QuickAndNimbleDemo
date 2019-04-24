//
//  CarCell.swift
//  QuickAndNimbleDemo
//
//  Created by Ashraf on 4/21/19.
//  Copyright © 2019 BS23. All rights reserved.
//

import Foundation
import UIKit

protocol  CarCellDelegate: class {
    func clickedOnSeeDetails(viewModel: CarViewModel)
    func clickedOnBuy(viewModel: CarViewModel)
}

class CarCell: UITableViewCell, Nibable {
    static let id = "CarCell"
    
    var viewModel: CarViewModel? {
        didSet {
           bind()
        }
    }
    weak var delegate: CarCellDelegate?
    
    //MARK: Oulets
    lazy var carImageView: UIImageView = {
        
        $0.contentMode = .scaleAspectFit
        $0.layer.masksToBounds = true
        return $0
    }(UIImageView())
    
    lazy var soldRibbonLabel: UILabel = {
        
        $0.transform = CGAffineTransform(rotationAngle: .pi / 4)
        
        $0.text = NSLocalizedString("Sold", comment: "").uppercased()
        $0.textAlignment = .center
        $0.clipsToBounds = true
        $0.font = .systemFont(ofSize: 14.0)
        $0.textColor = .white
        $0.backgroundColor = .custom
        return $0
    }(UILabel())
    
    lazy var carTitleLabel: UILabel = {
        
        $0.textColor = .almostBlack
        return $0
    }(UILabel())
    
    lazy var carModelLabel: UILabel = {
        
        $0.textColor = .lightGray
        return $0
    }(UILabel())
    
    lazy var carPriceLabel: UILabel = {
        
        $0.textColor = .custom
        return $0
    }(UILabel())
    
    lazy var seeDetailsButton: UIButton = {
        
        $0.tintColor = .clear
        $0.setTitleColor(.almostBlack, for: .normal)
        $0.setTitle(NSLocalizedString("See Details", comment: ""), for: .normal)
        $0.layer.borderWidth =  0.5
        $0.layer.borderColor = #colorLiteral(red: 0.7803921569, green: 0.7803921569, blue: 0.7803921569, alpha: 1).cgColor
        $0.layer.cornerRadius = 8.0
        $0.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    lazy var buyButton: UIButton = {
        
        $0.tintColor = .clear
        $0.setTitleColor(.white, for: .normal)
        $0.setTitle(NSLocalizedString("Buy", comment: ""), for: .normal)
        $0.backgroundColor =  .custom
        $0.layer.cornerRadius = 8.0
        $0.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        return $0
    }(UIButton(type: .system))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [carImageView, soldRibbonLabel, carTitleLabel, carModelLabel, carPriceLabel, seeDetailsButton, buyButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            
            contentView.addSubview($0)
        }

        NSLayoutConstraint.activate([
            
            carImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0),
            carImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            carImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -48.0),
            carImageView.widthAnchor.constraint(equalToConstant: 120.0),
        
            
            soldRibbonLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20.0),
            soldRibbonLabel.widthAnchor.constraint(equalToConstant: 200.0),
            soldRibbonLabel.heightAnchor.constraint(equalToConstant: 20.0),
            soldRibbonLabel.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -120.0),

            carTitleLabel.leadingAnchor.constraint(equalTo: carImageView.trailingAnchor, constant: 16.0),
            carTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24.0),
            carTitleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: -8.0),

            carModelLabel.leadingAnchor.constraint(equalTo: carTitleLabel.leadingAnchor),
            carModelLabel.topAnchor.constraint(equalTo: carTitleLabel.bottomAnchor, constant: 8.0),
            carModelLabel.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: -8.0),

            carPriceLabel.leadingAnchor.constraint(equalTo: carModelLabel.leadingAnchor),
            carPriceLabel.topAnchor.constraint(equalTo: carModelLabel.bottomAnchor, constant: 8.0),
            carPriceLabel.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: -8.0),

            seeDetailsButton.leadingAnchor.constraint(equalTo: carImageView.trailingAnchor, constant: 16.0),
            seeDetailsButton.topAnchor.constraint(equalTo: carPriceLabel.bottomAnchor, constant: 10.0),
            seeDetailsButton.widthAnchor.constraint(equalToConstant: 100.0),

            buyButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8.0),
            buyButton.centerYAnchor.constraint(equalTo: seeDetailsButton.centerYAnchor),
            buyButton.widthAnchor.constraint(equalToConstant: 60.0),
            
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

//MARK: Internal Logic
extension CarCell {
    fileprivate func bind(){
        guard let viewModel = viewModel else {
            return
        }
        
        carImageView.image = UIImage(named: viewModel.imgString)
        carTitleLabel.text = viewModel.title
        carModelLabel.text = viewModel.model
        carPriceLabel.text = viewModel.price
        soldRibbonLabel.isHidden = !viewModel.isSold
        buyButton.isHidden = viewModel.isSold
    }
    
    @objc fileprivate func didTap(button: UIButton) {
        guard let viewModel = viewModel else {
            return
        }
        
        switch button {
        case seeDetailsButton:
            delegate?.clickedOnSeeDetails(viewModel: viewModel)
        default:
            delegate?.clickedOnBuy(viewModel: viewModel)
        }
    }
}


