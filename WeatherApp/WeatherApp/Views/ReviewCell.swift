//
//  ReviewCell.swift
//  GYGtest
//
//  Created by Hnatiuk, Volodymyr on 25.08.18.
//  Copyright © 2018 GYG. All rights reserved.
//

import UIKit

class ReviewCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    
    var data: ReviewModel? {
        didSet {
            guard let _ = data else { return }
            self.configureLabels()
        }
    }
    
    func configureLabels() {
        guard let data = self.data else { return }
        if let title = data.title {
            titleLabel.text = title
        }
        if let message = data.message {
            messageLabel.text = message
        }
        if let author = data.author {
            authorLabel.text = author
        }
        if let rating = data.rating?.toDouble() {
            ratingView.rating = rating
        }
    }
}
