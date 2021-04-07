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
    
    private var topRatedMoviesData: MovieData?
    private var resultPage = 1
    private var collectionCapacity = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        topRatedMovieCollection.delegate = self
        topRatedMovieCollection.dataSource = self
        
        topRatedMovieCollection.register(UINib(nibName: "TopRatedCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ReusableTopRatedCollectionCell")
        
        NetworkManager().fetchTopRatedMovie(for: resultPage) { [weak self] (movieData) in
            self?.topRatedMoviesData = movieData
            self?.collectionCapacity = movieData.results.capacity - 3
            DispatchQueue.main.async {
                self?.topRatedMovieCollection.reloadData()
            }
        }
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/topRatedMovieCollection.frame.width)
        topRatedPageControl.currentPage = Int(pageIndex)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionCapacity
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReusableTopRatedCollectionCell", for: indexPath) as! TopRatedCollectionCell
        updateCellUI(cell: cell, index: indexPath.row)
        return cell
    }
    
    func updateCellUI(cell: TopRatedCollectionCell, index: Int) {
        let result = topRatedMoviesData?.results[index]
        cell.titleLabel.text = result?.title
        cell.overviewLabel.text = result?.overview
        cell.releaseDateLabel.text = result?.release_date
        if let posterPath = result?.poster_path {
            cell.movieImageView.loadImage(from: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")!)
        }
    }
}
