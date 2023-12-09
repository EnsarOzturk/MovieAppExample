//
//  ReviewsVC.swift
//  MovieAppExample
//
//  Created by Ensar on 7.12.2023.
//

import UIKit

class ReviewsVC: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let networkManager = NetworkManager()
    private var reviews: [Review] = []
    var reviewsID: Int = 0
    var movieTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchReviews()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ReviewsCell", bundle: nil), forCellWithReuseIdentifier: ReviewsCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        view.backgroundColor = UIColor.systemGray4
        navigationController?.navigationBar.barTintColor = UIColor.systemGray
        navigationController?.navigationBar.prefersLargeTitles = false
  
    }

    func fetchReviews() {
        let reviewsItem = ReviewsEndpointItem(movieId: reviewsID)
        networkManager.request(type: ReviewsResponse.self, item: reviewsItem) { response in
            switch response {
            case .success(let response):
                if let reviews = response.results {
                    print("\(reviews.count)")
                    self.reviews = reviews
                    self.updateUI()
                } else {
                    print("error")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    func updateUI() {
        DispatchQueue.main.async {
            if self.reviews.isEmpty {
                let messageLabel = UILabel()
                messageLabel.text = "No reviews"
                messageLabel.textAlignment = .center
                self.collectionView.backgroundView = messageLabel
                self.collectionView.indicatorStyle = .default
            } else {
                self.collectionView.backgroundView = nil
                self.collectionView.indicatorStyle = .black
                self.collectionView.reloadData()
            }
        }
    }
}

extension ReviewsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewsCell.identifier, for: indexPath) as? ReviewsCell
        let review = reviews[indexPath.row]
        cell?.configure(review: review)
        return cell ?? UICollectionViewCell()
    }
    
}

extension ReviewsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let review = reviews[indexPath.row]
        let width = UIScreen.main.bounds.width - 32
        let height = 40 + sizeOfString(string: review.content ?? "", constrainedToWidth: width).height
        return CGSize(width: width, height: height)
    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 6)
//    }
//
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func sizeOfString (string: String, constrainedToWidth width: Double) -> CGSize {
        let attributes = [NSAttributedString.Key.font:self]
        let attString = NSAttributedString(string: string,attributes: attributes)
        let framesetter = CTFramesetterCreateWithAttributedString(attString)
        return CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRange(location: 0,length: 0), nil, CGSize(width: width, height: DBL_MAX), nil)
        }
}



    

