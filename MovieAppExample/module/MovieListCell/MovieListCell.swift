//
//  MovieListCell.swift
//  MovieAppExample
//
//  Created by Ensar on 30.11.2023.
//

import UIKit

class MovieListCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    static let identifier = "MovieListCell"
    private var imageBaseUrl = "https://image.tmdb.org/t/p/w342"
    
    func configure(movie: Movie) {
       imageView.load(url: imageBaseUrl + (movie.posterPath ?? "") )
       label.text = movie.originalTitle

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.systemGray4.cgColor
        label.contentMode = .center
        layer.cornerRadius = 4
        imageView.contentMode = .scaleAspectFill
        
        label.layer.shadowColor = UIColor.white.cgColor
        label.layer.shadowRadius = 3.0
        label.layer.shadowOpacity = 1.0
        label.layer.shadowOffset = CGSize(width: 4, height: 4)
        label.layer.masksToBounds = false
    }
}
