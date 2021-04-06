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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        (topRatedMovieCollection.collectionViewLayout as? UICollectionViewFlowLayout)?
            .itemSize = CGSize(width: contentView.bounds.width, height: contentView.bounds.height)
    }
    
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension TopRatedMovieCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReusableTopRatedCollectionCell", for: indexPath) as! TopRatedCollectionCell
        return cell.getTopRated(page: 1, movieIndex: indexPath.row)
    }
    
    //    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    //        topRatedPageControl.currentPage = indexPath.row
    //    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/topRatedMovieCollection.frame.width)
        topRatedPageControl.currentPage = Int(pageIndex)
    }
}
