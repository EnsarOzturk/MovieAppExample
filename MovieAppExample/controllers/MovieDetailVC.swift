//
//  MovieDetailVC.swift
//  MovieAppExample
//
//  Created by Ensar on 30.11.2023.
//

import UIKit

class MovieDetailVC: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var reviewsButton: UIButton!
    @IBOutlet weak var durationLabel: UILabel!
    
    private var viewModel: MovieDetailViewModel!
    var movieId: Int = 0
    
        override func viewDidLoad() {
            super.viewDidLoad()
            
            viewModel = MovieDetailViewModel(networkManager: NetworkManager())
            viewModel.movieId = movieId
            bindViewModel()
        }
        
    private func bindViewModel() {
        viewModel.fetchMovieDetails { [weak self] result in
            switch result {
            case .success:
                self?.updateUI()
            case .failure(let error):
                print("Error fetching movie details: \(error)")
            }
        }
    }
        
    private func updateUI() {
        if let imageUrl = viewModel.backdropImageUrl {
            imageView.load(url: imageUrl.absoluteString)
        }
        nameLabel.text = viewModel.originalTitle
        releaseLabel.text = viewModel.releaseDate
        voteLabel.text = viewModel.voteAverage
        overviewLabel.text = viewModel.overview
        durationLabel.text = viewModel.voteCount
    }
    
    @IBAction func goToReviews(_ sender: Any) {
        performSegue(withIdentifier: "reviewsVC", sender: self)

    }
    
    @objc private func shareSheet(_ sender: UIButton) {
        guard let targetUrl = URL(string: "https://www.themoviedb.org/movie/\(movieId)")?.absoluteString else { return }
        let shareSheet = UIActivityViewController(activityItems: [targetUrl], applicationActivities: nil)
        shareSheet.popoverPresentationController?.sourceView = sender
        shareSheet.popoverPresentationController?.sourceRect = sender.frame
        present(shareSheet, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "reviewsVC" {
            if let reviewsVC = segue.destination as? ReviewsVC {
                reviewsVC.reviewsID = movieId
            }
        }
    }
}
