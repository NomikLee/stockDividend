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
    
    //配息計算部分
    @IBOutlet weak var cashDividendInput: UITextField!
    @IBOutlet weak var stockDividendInput: UITextField!
    @IBOutlet weak var stockPrice: UITextField!
    @IBOutlet weak var nowQuantity: UITextField!
    @IBOutlet weak var buyAyear: UITextField!
    @IBOutlet weak var howYear: UITextField!
    @IBOutlet weak var switchAgainOn: UISwitch!
    @IBOutlet weak var sliderControl: UISlider!
    
    //殖利率計算部分
    @IBOutlet weak var yieldStockPrice: UITextField!
    @IBOutlet weak var yieldNowQuantity: UITextField!
    @IBOutlet weak var yieldPercent: UITextField!
    @IBOutlet weak var yieldBuyAyear: UITextField!
    @IBOutlet weak var sliderYieldControl: UISlider!
    @IBOutlet weak var yieldHowYear: UITextField!
    
    @IBOutlet weak var outPutAll: UILabel!
    
    @IBOutlet weak var stockPageControl: UIPageControl!
    @IBOutlet weak var stockSelect: UISegmentedControl!
    @IBOutlet weak var scollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //在畫面上加入一個動畫的箭頭圖片
        let imageView = UIImageView(frame: CGRect(x: 17, y: 450, width: 200, height: 130))
        view.addSubview(imageView)
        let animatedImage = UIImage.animatedImageNamed("animated-arrow-image-0553-", duration: 1)
        imageView.image = animatedImage
        
        
        // 所有計算部分的輸入框美化
        cashDividendInput.layer.cornerRadius = 5
        cashDividendInput.layer.borderWidth = 3
        cashDividendInput.layer.borderColor = CGColor(red: 241/255, green: 91/255, blue: 108/255, alpha: 0.7)
        cashDividendInput.backgroundColor = UIColor(red: 0/255, green: 174/255, blue: 157/255, alpha: 0.7)
        stockDividendInput.layer.cornerRadius = 5
        stockDividendInput.layer.borderWidth = 3
        stockDividendInput.layer.borderColor = CGColor(red: 241/255, green: 91/255, blue: 108/255, alpha: 0.7)
        stockDividendInput.backgroundColor = UIColor(red: 0/255, green: 174/255, blue: 157/255, alpha: 0.7)
        stockPrice.layer.cornerRadius = 5
        stockPrice.layer.borderWidth = 3
        stockPrice.layer.borderColor = CGColor(red: 241/255, green: 91/255, blue: 108/255, alpha: 0.7)
        stockPrice.backgroundColor = UIColor(red: 0/255, green: 174/255, blue: 157/255, alpha: 0.7)
        nowQuantity.layer.cornerRadius = 5
        nowQuantity.layer.borderWidth = 3
        nowQuantity.layer.borderColor = CGColor(red: 241/255, green: 91/255, blue: 108/255, alpha: 0.7)
        nowQuantity.backgroundColor = UIColor(red: 0/255, green: 174/255, blue: 157/255, alpha: 0.7)
        buyAyear.layer.cornerRadius = 5
        buyAyear.layer.borderWidth = 3
        buyAyear.layer.borderColor = CGColor(red: 241/255, green: 91/255, blue: 108/255, alpha: 0.7)
        buyAyear.backgroundColor = UIColor(red: 0/255, green: 174/255, blue: 157/255, alpha: 0.7)
        howYear.layer.cornerRadius = 5
        howYear.layer.borderWidth = 3
        howYear.layer.borderColor = CGColor(red: 241/255, green: 91/255, blue: 108/255, alpha: 0.7)
        howYear.backgroundColor = UIColor(red: 0/255, green: 174/255, blue: 157/255, alpha: 0.7)
        
        yieldStockPrice.layer.cornerRadius = 5
        yieldStockPrice.layer.borderWidth = 3
        yieldStockPrice.layer.borderColor = CGColor(red: 241/255, green: 91/255, blue: 108/255, alpha: 0.7)
        yieldStockPrice.backgroundColor = UIColor(red: 0/255, green: 174/255, blue: 157/255, alpha: 0.7)
        yieldNowQuantity.layer.cornerRadius = 5
        yieldNowQuantity.layer.borderWidth = 3
        yieldNowQuantity.layer.borderColor = CGColor(red: 241/255, green: 91/255, blue: 108/255, alpha: 0.7)
        yieldNowQuantity.backgroundColor = UIColor(red: 0/255, green: 174/255, blue: 157/255, alpha: 0.7)
        yieldPercent.layer.cornerRadius = 5
        yieldPercent.layer.borderWidth = 3
        yieldPercent.layer.borderColor = CGColor(red: 241/255, green: 91/255, blue: 108/255, alpha: 0.7)
        yieldPercent.backgroundColor = UIColor(red: 0/255, green: 174/255, blue: 157/255, alpha: 0.7)
        yieldBuyAyear.layer.cornerRadius = 5
        yieldBuyAyear.layer.borderWidth = 3
        yieldBuyAyear.layer.borderColor = CGColor(red: 241/255, green: 91/255, blue: 108/255, alpha: 0.7)
        yieldBuyAyear.backgroundColor = UIColor(red: 0/255, green: 174/255, blue: 157/255, alpha: 0.7)
        yieldHowYear.layer.cornerRadius = 5
        yieldHowYear.layer.borderWidth = 3
        yieldHowYear.layer.borderColor = CGColor(red: 241/255, green: 91/255, blue: 108/255, alpha: 0.7)
        yieldHowYear.backgroundColor = UIColor(red: 0/255, green: 174/255, blue: 157/255, alpha: 0.7)
        
    }
    
    //更新頁面的方法，同步顯示分頁控制元件和分段控制元件的選擇
    func pageSync() {
        stockSelect.selectedSegmentIndex = pageNum
        stockPageControl.currentPage = pageNum
    }
    
    //股票複利計算的方法
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
                outPutAll.text = "複利\(how)年後你股票張數變成\(round(allTotelyear))股\n大約為\(round(allTotelyear/1000))張"
            }else{
                allTotelyear -= cashAll / price
                for _ in 1...how {
                    let stockAlltwo = stock * 100 * (allTotelyear / 1000)
                    allTotelyear = allTotelyear + stockAlltwo + (buy * 1000)
                }
                outPutAll.text = "複利\(how)年後你股票張數變成\(round(allTotelyear))股\n大約為\(round(allTotelyear/1000))張"
            }
            
        } else {
               outPutAll.text = "請輸入有效的數字"
        }
    }
    
    //殖利率計算的方法
    func stockYield() {
        if let yieldPrice = Double(yieldStockPrice.text!),
            let yieldNow = Double(yieldNowQuantity.text!),
            let percent = Double(yieldPercent.text!),
            let yieldBuy = Double(yieldBuyAyear.text!),
            let yieldHow = Int(yieldHowYear.text!){
            
            let yieldAll = yieldPrice * yieldNow * (percent / 100)
            var yieldAlltotel = yieldPrice * yieldNow + yieldAll
            
            for _ in 1...yieldHow {
                yieldAlltotel = yieldAlltotel * (percent / 100) + yieldAlltotel + yieldBuy
            }
            outPutAll.text = "複利\(yieldHow)年後\n你股票價值變成\n\(round(yieldAlltotel))元\n"
        }else{
            outPutAll.text = "請輸入有效的數字"
            
        }
    }
    
    //配息計算部分的滑動條事件處理方法
    @IBAction func sliderInput(_ sender: UISlider) {
        let sliderYearValue = Int(sender.value)
        howYear.text = "\(sliderYearValue)"
    }
    
    //殖利率計算部分的滑動條事件處理方法
    @IBAction func sliderYieldInput(_ sender: UISlider) {
        let sliderYieldYearValue = Int(sender.value)
        yieldHowYear.text = "\(sliderYieldYearValue)"
    }
    
    //計算按鈕的事件處理方法，根據選擇的分頁進行不同的計算
    @IBAction func allCalculate(_ sender: Any) {
        if stockSelect.selectedSegmentIndex == 0 {
            stockCompound()
        }else if stockSelect.selectedSegmentIndex == 1{
            stockYield()
        }
        view.endEditing(true)
    }
    
    //分頁控制元件的事件處理方法，切換到指定分頁
    @IBAction func stockChangePage(_ sender: Any) {
        let point = CGPoint(x: scollView.bounds.width * CGFloat((sender as AnyObject).currentPage), y: 0)
        scollView.setContentOffset(point, animated: true)
        pageNum = stockPageControl.currentPage
        pageSync()
    }
    
    //分段控制元件的事件處理方法，切換到指定分頁
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

//預覽視圖，用於在Interface Builder中預覽ViewController的外觀
#Preview {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: "ViewController")
}
