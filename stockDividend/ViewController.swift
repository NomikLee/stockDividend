//
//  ViewController.swift
//  stockDividend
//
//  Created by Pinocchio on 2023/7/26.
//

import UIKit
import OSLog

class ViewController: UIViewController {
    
    let logout = Logger()
    var index = 0
    
    @IBOutlet weak var stockPageControl: UIPageControl!
    @IBOutlet weak var stockSelect: UISegmentedControl!
    @IBOutlet weak var scollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func updateUI() {
        stockSelect.selectedSegmentIndex = index
        stockPageControl.currentPage = index
    }
    
    @IBAction func stockChangePage(_ sender: Any) {
        let point = CGPoint(x: scollView.bounds.width * CGFloat((sender as AnyObject).currentPage), y: 0)
        scollView.setContentOffset(point, animated: true)
        index = stockPageControl.currentPage
        updateUI()
    }
    
    @IBAction func stockSelectPage(_ sender: Any) {
        let point = CGPoint(x: scollView.bounds.width * CGFloat(stockSelect.selectedSegmentIndex), y: 0)
        scollView.setContentOffset(point, animated: true)
        index = stockSelect.selectedSegmentIndex
        updateUI()
    }
}
    



extension ViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.bounds.width
        stockPageControl.currentPage = Int(page)
        stockSelect.selectedSegmentIndex = Int(page)
    }
}

#Preview {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: "ViewController")
}
