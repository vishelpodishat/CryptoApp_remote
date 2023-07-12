//
//  CoinCell.swift
//  CryptoApp
//
//  Created by Алишер Сайдешев on 06.07.2023.
//

import UIKit
import SnapKit

class CoinCell: UITableViewCell {
    
    static let identifier = "CoinCell"
    
    // MARK: - Variables
    private(set) var coin: Coin!
    
    // MARK: - UI Components
    
    private let coinLogo: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "questionmark")
        iv.tintColor = .black
        return iv
    }()
    
    private let coinName: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "Error"
        return label
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with coin: Coin) {
        self.coin = coin
        
        self.coinName.text = coin.name

        DispatchQueue.global().async { [weak self] in
            if let logoURL = coin.logoURL,
               let imageData = try? Data(contentsOf: logoURL),
               let logoImage = UIImage(data: imageData) {

                DispatchQueue.main.async {
                    self?.coinLogo.image = logoImage
                }
            }
        }
    }
    
    // TODO: - PrepareForReuse
    override func prepareForReuse() {
        super.prepareForReuse()
        self.coinName.text = nil
        self.coinLogo.image = nil
    }

    //MARK: - UI Setup
    private func setupUI() {
        addSubview(coinLogo)
        addSubview(coinName)
                
        coinLogo.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.leading.equalTo(self.layoutMarginsGuide.snp.leading)
            make.width.equalTo(self.snp.height).multipliedBy(0.75)
            make.height.equalTo(self.snp.height).multipliedBy(0.75)
        }
        
        coinName.snp.makeConstraints { make in
            make.leading.equalTo(coinLogo.snp.trailing).offset(16)
            make.centerY.equalTo(snp.centerY)
        }
    }
}
