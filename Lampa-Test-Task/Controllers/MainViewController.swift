//
//  ViewController.swift
//  Lampa-Test-Task
//
//  Created by Dmytro Yantsybaiev on 03.04.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var tabsScrollView: UIScrollView!
    @IBOutlet weak var tabsPageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabsScrollView.delegate = self
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
          return .lightContent
    }
}

//MARK: - UIScrollViewDelegate

extension MainViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        tabsPageControl.currentPage = Int(pageIndex)
    }
}
