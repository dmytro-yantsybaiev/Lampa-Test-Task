//
//  ViewController.swift
//  Lampa-Test-Task
//
//  Created by Dmytro Yantsybaiev on 03.04.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var storiesTabButton: UIButton!
    @IBOutlet weak var videoTabButton: UIButton!
    @IBOutlet weak var favouritesTabButton: UIButton!
    @IBOutlet weak var tabsScrollView: UIScrollView!
    @IBOutlet weak var mainTableView: UITableView!
    
    lazy var tabButtons = [storiesTabButton, videoTabButton, favouritesTabButton]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabsScrollView.delegate = self
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
        mainTableView.register(UINib(nibName: "TopRatedMovieCell", bundle: nil), forCellReuseIdentifier: "ReusableTopRatedMovieCell")
        mainTableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "ReusableMovieCell")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
    
    @IBAction func tabButtonPressed(_ sender: UIButton) {
        setAllTabButtonsCollorGray()
        setSelectedTabButtonCollorWhite(sender)
        
        UIView.animate(withDuration: 0.2) {
            self.changeScrollViewPositionToSelectedTab(sender)
        }
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToSearch", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "goToSearch" {
//            let searchVC = segue.destination as! SearchViewController
//        }
    }
    
    func setAllTabButtonsCollorGray() {
        for tabButton in tabButtons {
            tabButton?.setTitleColor(.gray, for: .normal)
        }
    }
    
    func setSelectedTabButtonCollorWhite(_ button: UIButton) {
        button.setTitleColor(.white, for: .normal)
    }
    
    func changeScrollViewPositionToSelectedTab(_ tabButton: UIButton) {
        let currentTabPage = CGFloat(tabButtons.firstIndex(of: tabButton)!)
        tabsScrollView.contentOffset.x = view.frame.width * currentTabPage
    }
}

//MARK: - UIScrollViewDelegate

extension MainViewController: UIScrollViewDelegate {
        
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = Int(round(scrollView.contentOffset.x/view.frame.width))
        setAllTabButtonsCollorGray()
        setSelectedTabButtonCollorWhite(tabButtons[pageIndex]!)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 21
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableTopRatedMovieCell", for: indexPath) as! TopRatedMovieCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableMovieCell", for: indexPath) as! MovieCell
            return cell.getPopular(page: 1, movieIndex: indexPath.row - 1)
        }
        
    }
    
}

//MARK: - Load UIImageView from URL

extension UIImageView {
    func loadImage(from url: URL) {
        let imageCache = NSCache<AnyObject, UIImage>()
        
        if let cachedImage = imageCache.object(forKey: url as AnyObject) {
            self.image = cachedImage
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        imageCache.setObject(image, forKey: url as AnyObject)
                        self?.image = image
                    }
                }
            }
        }
    }
}
