//
//  ViewController.swift
//  stockDividend
//
//  Created by Pinocchio on 2023/7/26.
//

import UIKit
import OSLog

class ViewController: UIViewController {
    
    let logger = Logger()
    var pageNum = 0
    
    //配息計算
    @IBOutlet weak var cashDividendInput: UITextField!
    @IBOutlet weak var stockDividendInput: UITextField!
    @IBOutlet weak var stockPrice: UITextField!
    @IBOutlet weak var nowQuantity: UITextField!
    @IBOutlet weak var buyAyear: UITextField!
    @IBOutlet weak var howYear: UITextField!
    @IBOutlet weak var switchAgainOn: UISwitch!
    @IBOutlet weak var sliderControl: UISlider!
    
    //殖利率計算
    @IBOutlet weak var yieldStockPrice: UITextField!
    @IBOutlet weak var yieldNowQuantity: UITextField!
    @IBOutlet weak var yieldPercent: UITextField!
    @IBOutlet weak var yieldBuyAyear: UITextField!
    @IBOutlet weak var yieldHowYear: UITextField!
    
    @IBOutlet weak var outPutAll: UILabel!
    
    @IBOutlet weak var stockPageControl: UIPageControl!
    @IBOutlet weak var stockSelect: UISegmentedControl!
    @IBOutlet weak var scollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    func pageSync() {
        stockSelect.selectedSegmentIndex = pageNum
        stockPageControl.currentPage = pageNum
    }
    
    func stockCompound() {
        if let cash = Double(cashDividendInput.text!),
           let stock = Double(stockDividendInput.text!),
           let price = Double(stockPrice.text!),
           let now = Double(nowQuantity.text!),
           let buy = Double(buyAyear.text!),
           let how = Int(howYear.text!) {
            
            let cashAll = cash * now
            let stockAll = stock * 100 * (now / 1000)
            var allTotelyear = (cashAll / price) + now + stockAll
            
            
            if switchAgainOn.isOn {
                for _ in 1...how {
                    let cashAlltwo = cash * allTotelyear
                    let stockAlltwo = stock * 100 * (allTotelyear / 1000)
                    allTotelyear = (cashAlltwo / price) + allTotelyear + stockAlltwo + (buy * 1000)
                    logger.log("\(cashAlltwo) \(stockAlltwo) \(allTotelyear)")
                }
                outPutAll.text = "複利\(how)年後你股票張數變成\n\(allTotelyear)股\n換算後為\(allTotelyear/1000)張"
            }else{
                allTotelyear -= cashAll / price
                for _ in 1...how {
                    let stockAlltwo = stock * 100 * (allTotelyear / 1000)
                    allTotelyear = allTotelyear + stockAlltwo + (buy * 1000)
                }
                outPutAll.text = "複利\(how)年後你股票張數變成\n\(allTotelyear)股\n換算後為\(allTotelyear/1000)張"
            }
            
        } else {
               outPutAll.text = "請輸入有效的數字"
        }
    }
    
    func stockYield() {
        if let yieldPrice = Double(yieldStockPrice.text!),
            let yieldNow = Double(yieldNowQuantity.text!),
            let percent = Double(yieldPercent.text!),
            let yieldBuy = Double(yieldBuyAyear.text!),
            let yieldHow = Int(yieldHowYear.text!){
            
            let yieldAll = yieldPrice * yieldNow * (percent / 100)
            var yieldAlltotel = yieldPrice * yieldNow + yieldAll
            
            for _ in 1..<yieldHow {
                yieldAlltotel = yieldPrice * yieldAlltotel * (percent / 100) + yieldAlltotel + yieldBuy
            }
            outPutAll.text = "複利\(yieldHow)年後你股票價值變成\n\(yieldAlltotel)元\n"
        }else{
            outPutAll.text = "請輸入有效的數字"
            
        }
    }
    
    @IBAction func sliderInput(_ sender: UISlider) {
        let sliderYearValue = Int(sender.value)
        howYear.text = "\(sliderYearValue)"
    }
    @IBAction func allCalculate(_ sender: Any) {
        stockCompound()
    }
    
    
    
    @IBAction func stockChangePage(_ sender: Any) {
        let point = CGPoint(x: scollView.bounds.width * CGFloat((sender as AnyObject).currentPage), y: 0)
        scollView.setContentOffset(point, animated: true)
        pageNum = stockPageControl.currentPage
        pageSync()
    }
    
    
    @IBAction func stockSelectPage(_ sender: Any) {
        let point = CGPoint(x: scollView.bounds.width * CGFloat(stockSelect.selectedSegmentIndex), y: 0)
        scollView.setContentOffset(point, animated: true)
        pageNum = stockSelect.selectedSegmentIndex
        pageSync()
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
