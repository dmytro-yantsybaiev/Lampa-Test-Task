//
//  TopRatedMovieCell.swift
//  Lampa-Test-Task
//
//  Created by Dmytro Yantsybaiev on 05.04.2021.
//

import UIKit

class TopRatedMovieCell: UITableViewCell {
    
    @IBOutlet weak var topRatedMovieCollection: UICollectionView!
    @IBOutlet weak var topRatedPageControl: UIPageControl!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        topRatedMovieCollection.delegate = self
        topRatedMovieCollection.dataSource = self
        
        topRatedMovieCollection.register(UINib(nibName: "TopRatedCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ReusableTopRatedCollectionCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension TopRatedMovieCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReusableTopRatedCollectionCell", for: indexPath) as! TopRatedCollectionCell
        return cell.getTopRated(page: 1, movieIndex: indexPath.row)
    }
    
    
}
