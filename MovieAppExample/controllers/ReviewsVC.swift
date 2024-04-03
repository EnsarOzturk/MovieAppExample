//
//  ReviewsVC.swift
//  MovieAppExample
//
//  Created by Ensar on 7.12.2023.
//

import UIKit

class ReviewsVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var viewModel: ReviewsViewModel!
        private let networkManager = NetworkManager()
        
        var reviewsID: Int = 0
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            setupViewModel()
            fetchReviews()
            configureCollectionView()
        }
        
        private func setupViewModel() {
            viewModel = ReviewsViewModel(networkManager: networkManager)
            viewModel.reviewsID = reviewsID
        }
        
        private func fetchReviews() {
            viewModel.fetchReviews { [weak self] result in
                switch result {
                case .success:
                    self?.collectionView.reloadData()
                case .failure(let error):
                    print("Error fetching reviews: \(error)")
                }
            }
        }
        
        private func configureCollectionView() {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "ReviewsCell", bundle: nil), forCellWithReuseIdentifier: ReviewsCell.identifier)
            collectionView.contentInset = UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 8)
            view.backgroundColor = UIColor.systemGray4
            navigationController?.navigationBar.barTintColor = UIColor.systemGray
            navigationController?.navigationBar.prefersLargeTitles = false
        }
    }

    extension ReviewsVC: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return viewModel.reviews.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewsCell.identifier, for: indexPath) as? ReviewsCell
            let review = viewModel.reviews[indexPath.row]
            cell?.configure(review: review)
            return cell ?? UICollectionViewCell()
        }
    }

    extension ReviewsVC: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let review = viewModel.reviews[indexPath.row]
            let width = UIScreen.main.bounds.width - 16
            let height = 40 + sizeOfString(string: review.content ?? "", constrainedToWidth: width, font: UIFont.systemFont(ofSize: 17)).height
            return CGSize(width: width, height: height)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 8
        }
        
        func sizeOfString(string: String, constrainedToWidth width: CGFloat, font: UIFont) -> CGSize {
            let attributes = [NSAttributedString.Key.font: font]
            let attString = NSAttributedString(string: string, attributes: attributes)
            let rect = attString.boundingRect(with: CGSize(width: width, height: .greatestFiniteMagnitude), options: .usesLineFragmentOrigin, context: nil)
            return rect.size
        }
    }   
//    private let networkManager = NetworkManager()
//    private var reviews: [Review] = []
//    private var movieTitle: String = ""
//    var reviewsID: Int = 0
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        fetchReviews()
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        collectionView.register(UINib(nibName: "ReviewsCell", bundle: nil), forCellWithReuseIdentifier: ReviewsCell.identifier)
//        collectionView.contentInset = UIEdgeInsets(top: 16, left: 8, bottom: 16, right: 8)
//        view.backgroundColor = UIColor.systemGray4
//        navigationController?.navigationBar.barTintColor = UIColor.systemGray
//        navigationController?.navigationBar.prefersLargeTitles = false
//  
//    }
//
//    private func fetchReviews() {
//        let reviewsItem = ReviewsEndpointItem(movieId: reviewsID)
//        networkManager.request(type: ReviewsResponse.self, item: reviewsItem) { response in
//            switch response {
//            case .success(let response):
//                if let reviews = response.results {
//                    print("\(reviews.count)")
//                    self.reviews = reviews
//                    self.updateUI()
//                } else {
//                    print("error")
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
//    func updateUI() {
//        DispatchQueue.main.async {
//            if self.reviews.isEmpty {
//                let messageLabel = UILabel()
//                messageLabel.text = "No reviews"
//                messageLabel.textAlignment = .center
//                self.collectionView.backgroundView = messageLabel
//                self.collectionView.indicatorStyle = .default
//            } else {
//                self.collectionView.backgroundView = nil
//                self.collectionView.indicatorStyle = .black
//                self.collectionView.reloadData()
//            }
//        }
//    }
//}
//
//extension ReviewsVC: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return reviews.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewsCell.identifier, for: indexPath) as? ReviewsCell
//        let review = reviews[indexPath.row]
//        cell?.configure(review: review)
//        return cell ?? UICollectionViewCell()
//    }
//    
//}
//
//extension ReviewsVC: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let review = reviews[indexPath.row]
//        let width = UIScreen.main.bounds.width - 16
//        let height = 40 + sizeOfString(string: review.content ?? "", constrainedToWidth: width).height
//        return CGSize(width: width, height: height)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 8
//    }
//    
//    func sizeOfString (string: String, constrainedToWidth width: Double) -> CGSize {
//        let attributes = [NSAttributedString.Key.font:self]
//        let attString = NSAttributedString(string: string,attributes: attributes)
//        let framesetter = CTFramesetterCreateWithAttributedString(attString)
//        return CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRange(location: 0,length: 0), nil, CGSize(width: width, height: DBL_MAX), nil)
//        }
//}
//


    

