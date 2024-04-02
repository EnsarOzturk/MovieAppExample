//
//  MovieListVC.swift
//  MovieAppExample
//
//  Created by Ensar on 30.11.2023.
//

import UIKit

final class MovieListVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var viewModel: MovieListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = MovieListViewModel(networkManager: NetworkManager())
        searchBar()
        setupCollectionView()
        fetchMovies()
        contentInset()
    }

    private func searchBar() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false // Search bar'ın scroll ederken saklanmaması için
        searchController.searchBar.placeholder = "Search Movies"
        searchController.definesPresentationContext = true // Bu özelliği true olarak ayarlayın
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "MovieListCell", bundle: nil), forCellWithReuseIdentifier: MovieListCell.identifier)
        collectionView.register(UINib(nibName: "BigCardCell", bundle: nil), forCellWithReuseIdentifier: BigCardCell.identifier)
    }
    
    private func fetchMovies() {
        viewModel.fetchMovies { [weak self] result in
            switch result {
            case .success:
                self?.collectionView.reloadData()
            case .failure(let error):
                print("Error fetching movies: \(error)")
            }
        }
    }
    
    @IBAction func viewStyleButtonTapped(_ sender: UIBarButtonItem) {
        viewModel.toggleViewStyle()
        collectionView.reloadData()
    }
}

    private func contentInset() {
        switch viewModel.viewStyle {
        case .small:
         collectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        case .big:
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension MovieListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfMovies
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel.viewStyle == .small ? MovieListCell.identifier : BigCardCell.identifier, for: indexPath)
        
        if let movieCell = cell as? MovieListCell {
            movieCell.configure(movie: viewModel.movie(at: indexPath.row))
        } else if let bigCardCell = cell as? BigCardCell {
            bigCardCell.configure(movie: viewModel.movie(at: indexPath.row))
        }
        
        return cell
    }
}

extension MovieListVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch viewModel.viewStyle {
        case .small:
            let width = (UIScreen.main.bounds.width - 48) / 2
            let height = width / 2 * 3
            return CGSize(width: width, height: height)
        case .big:
            let width = UIScreen.main.bounds.width - 16
            let height = width / 2
            return CGSize(width: width, height: height)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch viewModel.viewStyle {
        case .small:
            return 16
        case .big:
            return 8
        }
    }
}

extension MovieListVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovieId = viewModel.movie(at: indexPath.row).id
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "MovieDetail") as! MovieDetailVC
        detailVC.movieId = selectedMovieId!
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension MovieListVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.filterMovies(with: searchController.searchBar.text ?? "")
        collectionView.reloadData()
    }
}






