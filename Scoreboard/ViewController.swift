//
//  ViewController.swift
//  Scoreboard
//
//  Created by 王威力 on 2021/8/3.
//

import UIKit

class ViewController: UIViewController {
    var countL = 0
    var countR = 0
    var totalcount = 0
    var boardLsmall = 0
    var boardRsmall = 0
    //平局
    var Deuce : Bool = false
//    var stepList = [PingPong]()
    
    @IBOutlet weak var leftScore: UILabel!
    @IBOutlet weak var rightScore: UILabel!
    @IBOutlet weak var leftSmallScore: UILabel!
    @IBOutlet weak var rightSmallScore: UILabel!
    @IBOutlet weak var leftServe: UILabel!
    @IBOutlet weak var rightServe: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initStep()
    }
    
    @IBAction func btRewind(_ sender: Any) {
        self.view.showToast(text: "此功能尚未完成！！！！")
    }
    
    @IBAction func btChangdSide(_ sender: Any) {
        
        let lScore = leftScore.text
        let rScore = rightScore.text
        let lBoard = leftSmallScore.text
        let rBoard = rightSmallScore.text
        let lServe = leftServe.text
        let rServe = rightServe.text
        let lCount = countL
        let rCount = countR
        
        leftScore.text = rScore
        rightScore.text = lScore
        leftSmallScore.text = rBoard
        rightSmallScore.text = lBoard
        leftServe.text = rServe
        rightServe.text = lServe
        countL = rCount
        countR = lCount
        
        changeBackgrand()
    }
    
    @IBAction func btReset(_ sender: Any) {
        initStep()
    }
    
    @IBAction func btLeftScore(_ sender: Any) {
        countL += 1
        totalcount += 1
        leftScore.text = "\(countL)"
        changeBoth(totalcount)
        
        if Deuce {
            var disCount = countL - countR
            var deuceCount = abs(disCount) //取絕對值
            if deuceCount == 2 {
                self.view.showToast(text: "LeftPlayer Win!")
                countL = 0
                countR = 0
                leftScore.text = "0"
                rightScore.text = "0"
                
                boardLsmall += 1
                boardRsmall = 0
                leftSmallScore.text = "\(boardLsmall)"
                totalcount = 0
                Deuce = false
                
            }
        } else {
            if leftScore.text == rightScore.text && countL == 10 {
                Deuce = true
                self.view.showToast(text: "Deuce")
            } else {
                if countL == 11 && leftScore.text != rightScore.text {
                    self.view.showToast(text: "LeftPlayer Win!")
                    countL = 0
                    countR = 0
                    leftScore.text = "0"
                    rightScore.text = "0"
                    
                    boardLsmall += 1
                    boardRsmall = 0
                    leftSmallScore.text = "\(boardLsmall)"
                    totalcount = 0
                }
            }
        }
        if boardLsmall == 2 {
            self.view.showToast(text: "LeftPlayer is Final Win!")
            initStep()
        }
        
    }
    
    @IBAction func btReightScore(_ sender: Any) {
        countR += 1
        totalcount += 1
        rightScore.text = "\(countR)"
        changeBoth(totalcount)
        
        if Deuce {
            var disCount = countR - countL
            var deuceCount = abs(disCount) //取絕對值
            if deuceCount == 2 {
                self.view.showToast(text: "RightPlayer Win!")
                countL = 0
                countR = 0
                leftScore.text = "0"
                rightScore.text = "0"
                
                boardLsmall = 0
                boardRsmall += 1
                rightSmallScore.text = "\(boardRsmall)"
                totalcount = 0
                Deuce = false
                
            }
        } else {
            if leftScore.text == rightScore.text && countR == 10 {
                Deuce = true
                self.view.showToast(text: "Deuce")
            } else {
                if countR == 11 && rightScore.text != leftScore.text {
                    self.view.showToast(text: "RightPlayer Win!")
                    countL = 0
                    countR = 0
                    leftScore.text = "0"
                    rightScore.text = "0"
                    
                    boardLsmall = 0
                    boardRsmall += 1
                    rightSmallScore.text = "\(boardRsmall)"
                    totalcount = 0
                }
            }
        }
        
        //先贏兩局者獲勝, 並重來
        if boardRsmall == 2 {
            self.view.showToast(text: "RightPlayer is Final Win!")
            initStep()
        }
    }
    
    
    //初始化
    func initStep() {
        leftScore.text = "0"
        rightScore.text = "0"
        leftServe.text = "Serve"
        rightServe.text = ""
        leftSmallScore.text = "0"
        rightSmallScore.text = "0"
        countL = 0
        countR = 0
        totalcount = 0
        boardLsmall = 0
        boardRsmall = 0
    }
    
    //發兩球換邊
    func changeBoth(_ totalcount : Int) {
        
        if totalcount % 2 == 0 {
            let pingScore = leftServe.text
            leftServe.text = rightServe.text
            rightServe.text = pingScore
            changeBackgrand()
        } else {
            changeBackgrand()
        }
    }
    
    //換背景
    func changeBackgrand() {
        if leftServe.text == "Serve" {
            
            view.backgroundColor = UIColor.systemGreen
        } else {
            view.backgroundColor = UIColor.systemBlue
        }
    }

}




//show toast
extension UIView{

    func showToast(text: String){
        
        self.hideToast()
        let toastLb = UILabel()
        toastLb.numberOfLines = 0
        toastLb.lineBreakMode = .byWordWrapping
        toastLb.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastLb.textColor = UIColor.white
        toastLb.layer.cornerRadius = 10.0
        toastLb.textAlignment = .center
        toastLb.font = UIFont.systemFont(ofSize: 15.0)
        toastLb.text = text
        toastLb.layer.masksToBounds = true
        toastLb.tag = 9999//tag：hideToast實用來判斷要remove哪個label
        
        let maxSize = CGSize(width: self.bounds.width - 40, height: self.bounds.height)
        var expectedSize = toastLb.sizeThatFits(maxSize)
        var lbWidth = maxSize.width
        var lbHeight = maxSize.height
        if maxSize.width >= expectedSize.width{
            lbWidth = expectedSize.width
        }
        if maxSize.height >= expectedSize.height{
            lbHeight = expectedSize.height
        }
        expectedSize = CGSize(width: lbWidth, height: lbHeight)
        toastLb.frame = CGRect(x: ((self.bounds.size.width)/2) - ((expectedSize.width + 20)/2), y: self.bounds.height - expectedSize.height - 40 - 20, width: expectedSize.width + 20, height: expectedSize.height + 20)
        self.addSubview(toastLb)
        
        UIView.animate(withDuration: 1.5, delay: 1.5, animations: {
            toastLb.alpha = 0.0
        }) { (complete) in
            toastLb.removeFromSuperview()
        }
    }
    
    func hideToast(){
        for view in self.subviews{
            if view is UILabel , view.tag == 9999{
                view.removeFromSuperview()
            }
        }
    }
}
