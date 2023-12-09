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
    
    var movieDetails: MovieDetailResponse?
    private let networkManager = NetworkManager()
    var movieId: Int = 0
    var voteAvarage: Int = 0
    var imageBaseUrl = "https://image.tmdb.org/t/p/w500"

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        navigationController?.navigationBar.tintColor = .white
        let movieDetailItem = MovieDetailEndpointItem(movieId: movieId)
        networkManager.request(type: MovieDetailResponse.self, item: movieDetailItem) { response in
            switch response {
            case .success(let movieDetail):
                self.movieDetails = movieDetail
                if let backdropPath = movieDetail.backdropPath {
                    let imageUrl = self.imageBaseUrl + backdropPath
                    self.imageView.load(url: imageUrl)
                }
                
                self.imageView.load(url: self.movieDetails?.backdropPath ?? "")
                self.nameLabel.text = self.movieDetails?.originalTitle
                self.releaseLabel.text = self.movieDetails?.releaseDate
                self.voteLabel.text = String((self.movieDetails?.voteAverage ?? 0))
                self.overviewLabel.text = self.movieDetails?.overview
                self.durationLabel.text = String((self.movieDetails?.voteCount ?? 0))
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.backgroundColor = .black
        imageView.layer.cornerRadius = 4
        shareButton.tintColor = .white
        shareButton.addTarget(self, action: #selector(shareSheet(_:)), for: .touchUpInside)
//        reviewsButton.addTarget(self, action: #selector(reviews(_ :)), for: .touchUpInside)
        
        
    }
    
    
    @objc private func shareSheet(_ sender: UIButton){
        guard let targetUrl = URL(string: "https://www.themoviedb.org/movie/\(movieId)") else { return }
        let shareSheet = UIActivityViewController(activityItems: [targetUrl], applicationActivities: nil)
        shareSheet.popoverPresentationController?.sourceView = sender
        shareSheet.popoverPresentationController?.sourceRect = sender.frame
        present(shareSheet, animated: true)
    }
    
    @IBAction func goToReviews(_ sender: Any) {
        performSegue(withIdentifier: "reviewsVC", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "reviewsVC" {
            if let reviewsVC = segue.destination as? ReviewsVC {
                reviewsVC.reviewsID = movieDetails?.id ?? 0
            }
        }
    }
}

