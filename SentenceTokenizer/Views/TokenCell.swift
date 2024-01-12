//
//  TokenCell.swift
//  SentenceTokenizer
//
//  Created by Eliza Alekseeva on 1/13/24.
//

import UIKit

public class TokenCell: UICollectionViewCell {
    let tokenView = TokenView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(tokenView)
        tokenView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tokenView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tokenView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tokenView.topAnchor.constraint(equalTo: contentView.topAnchor),
            tokenView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func configure(with text: String) {
        tokenView.setText(text)
    }
    
    class func sizeForText(_ text: String) -> CGSize {
        let label = UILabel()
        label.text = text
        label.sizeToFit()
        return CGSize(width: label.bounds.width, height: label.bounds.height)
    }
}

