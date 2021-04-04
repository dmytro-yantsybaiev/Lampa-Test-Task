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
    @IBOutlet weak var tabsPageControl: UIPageControl!
    
    lazy var tabButtons = [storiesTabButton, videoTabButton, favouritesTabButton]
    var currentTabPage: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabsScrollView.delegate = self
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
    
    func setAllTabButtonsCollorGray() {
        for tabButton in tabButtons {
            tabButton?.setTitleColor(.gray, for: .normal)
        }
    }
    
    func setSelectedTabButtonCollorWhite(_ button: UIButton) {
        button.setTitleColor(.white, for: .normal)
    }
    
    func changeScrollViewPositionToSelectedTab(_ tabButton: UIButton) {
        currentTabPage = CGFloat(tabButtons.firstIndex(of: tabButton)!)
        tabsScrollView.contentOffset.x = view.frame.width * currentTabPage
    }
}

//MARK: - UIScrollViewDelegate

extension MainViewController: UIScrollViewDelegate {
        
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        currentTabPage = pageIndex
        tabsPageControl.currentPage = Int(pageIndex)
        
        setAllTabButtonsCollorGray()
        if pageIndex == 0 {
            setSelectedTabButtonCollorWhite(tabButtons[0]!)
        } else if pageIndex == 1 {
            setSelectedTabButtonCollorWhite(tabButtons[1]!)
        } else if pageIndex == 2 {
            setSelectedTabButtonCollorWhite(tabButtons[2]!)
        }
    }
}
