//
//  ReviewsCell.swift
//  MovieAppExample
//
//  Created by Ensar on 8.12.2023.
//

import UIKit

class ReviewsCell: UICollectionViewCell {
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    static let identifier = "ReviewsCell"
    
    func configure(review: Review) {
        authorLabel.text = review.author
        contentLabel.text = review.content
        releaseDateLabel.text = review.createdAt
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor.systemGray6
        layer.cornerRadius = 2
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray2.cgColor
    }
}
