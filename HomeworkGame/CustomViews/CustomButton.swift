//
//  CustomButton.swift
//  HomeworkGame
//
//  Created by Olha Dzhyhirei on 1/22/23.
//

import Foundation
import UIKit
class CustomButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupButton() {
        backgroundColor = .systemBlue
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = 20
        configuration?.titleAlignment = .center
        titleLabel?.font = .systemFont(ofSize: 26, weight: .bold)
    }
}
