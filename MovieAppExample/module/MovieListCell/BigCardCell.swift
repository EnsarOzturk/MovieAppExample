//
//  BigCardCell.swift
//  MovieAppExample
//
//  Created by Ensar on 10.12.2023.
//

import UIKit

class BigCardCell: UICollectionViewCell {
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var view: UIView!
    static let identifier = "BigCardCell"
    private var imageBaseUrl = "https://image.tmdb.org/t/p/w342"
    private var backdropImagebaseUrl = "https://image.tmdb.org/t/p/w500"
    
    func configure(movie: Movie) {
        backdropImageView.load(url: backdropImagebaseUrl + (movie.backdropPath ?? ""))
        posterImageView.load(url: imageBaseUrl + (movie.posterPath ?? ""))
        nameLabel.text = movie.originalTitle
        releaseLabel.text = movie.releaseDate
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.systemGray4.cgColor
        layer.cornerRadius = 4
        view.layer.cornerRadius = 8
        
        releaseLabel.textColor = .white
        backdropImageView.contentMode = .scaleAspectFill
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.borderWidth = 0.5
        posterImageView.layer.borderColor = UIColor.white.cgColor
        posterImageView.layer.cornerRadius = 4
        
        nameLabel.textColor = .white
        nameLabel.layer.shadowColor = UIColor.white.cgColor
        nameLabel.layer.shadowRadius = 3.0
        nameLabel.layer.shadowOpacity = 1.0
        nameLabel.layer.shadowOffset = CGSize(width: 4, height: 4)
        nameLabel.layer.masksToBounds = false
    }
}
