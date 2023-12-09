//
//  MovieListVC.swift
//  MovieAppExample
//
//  Created by Ensar on 30.11.2023.
//

import UIKit

class MovieListVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private let networkManager = NetworkManager()
    private var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()


        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "MovieListCell", bundle: nil), forCellWithReuseIdentifier: MovieListCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "MovieList"
        
        networkManager.request(type: MovieResponse.self, item: DiscoverMovieEndpointItem()) { result in
            switch result {
            case .success(let response):
                if let movies =  response.results {
                    self.movies = movies
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            case .failure(let error): print(error)
            }
        }
    }
}

extension MovieListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCell.identifier, for: indexPath) as! MovieListCell
        let movie = movies[indexPath.row]
        cell.configure(movie: movie)
        return cell
    }
}

extension MovieListVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 48) / 2
        let height = width / 2 * 3
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

extension MovieListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = movies[indexPath.row].id
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "MovieDetail") as! MovieDetailVC
        detailVC.movieId = selectedMovie!
        navigationController?.pushViewController(detailVC, animated: true)
    }
}





