//
//  ViewController.swift
//  calculator
//
//  Created by 吉澤実 on H28/12/10.
//  Copyright © 平成28年 吉澤実. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var calc:calc!
    var textCount = 0
    //記号格納用配列
    var operators:String = ""
    //計算用配列
    var calcArray:[Int64] = []
    //確定値用配列
    var result:[Int64] = [0]
    //
    var count:Int = 0
    //
    var loc:Int = 0
    
    @IBOutlet weak var Label: UILabel!
    
    
    @IBAction func AC(_ sender: Any) {
        Label.text = ""
    }
    
    @IBAction func plus_minus(_ sender: Any) {
        
    }
    
    
    @IBAction func percent(_ sender: Any) {
        Label.text?.append(" % ")
    }

    
    @IBAction func waru(_ sender: Any) {
        let textTmp = Label.text
        //文字列を数値にキャストして計算用配列に代入
        calcArray.append(Int64(textTmp!)!)
        operators.append("/")
        Label.text?.append(" / ")
        //0除算のエラー処理
    }

    @IBAction func kakeru(_ sender: Any) {
        //指定した範囲の文字列を抜き出す。記号の前の数値を抜き出して計算用配列に格納する
        //substring(with:start,length:スタート地点からの文字数まで)
        let textTmp = NSString(string: Label.text!).substring(with: NSRange(location: loc, length: (Label.text?.characters.count)!-loc))
        calcArray.append(Int64(textTmp)!)
        //２個以上格納されていたら計算して確定値配列に格納する
        print("calcArray.count = \(calcArray.count)")
        if calcArray.count == 2 {
            if operators == "*" {
                print("calcArray[0]=\(calcArray[0]),calcArray[1]=\(calcArray[1])")
                if result[count] == 0 {
                    result[count] = result[count] + calcArray[0]*calcArray[1]
                    print("1")
                }else {
                    result[count] = result[count] * calcArray[1]
                    print("2")
                }
                calcArray.removeLast()
                calcArray[0] = result[count]
            }else if operators == "/" {
                //result = calcArray[0]/calcArray[1]
                calcArray.removeLast()
                //calcArray[0] = result
            }else if operators == "+" {
                print("count=\(count), result = \(result.count)")
                result[count-1] = calcArray[0]
                calcArray.removeFirst()
                print("++3")
            }else if operators == "-" {
                //result = calcArray[0]-calcArray[1]
            }
            
        }
        print("result = \(result)")
        operators = ("*")
        Label.text?.append(" × ")
        loc = (Label.text?.characters.count)!
    }
    
    @IBAction func minus(_ sender: Any) {
        Label.text?.append(" - ")
        //マイナスフラグを反転させる
    }
    
    
    @IBAction func plus(_ sender: Any) {
        //let textTmp = Label.text
        //plusArray.append(1)
        //result = result + calcData
        count = count + 1
        result.append(0)
        let textTmp = NSString(string: Label.text!).substring(with: NSRange(location: loc, length: (Label.text?.characters.count)!-loc))
        calcArray.append(Int64(textTmp)!)
        if calcArray.count == 2 {
            result[count-1] = calcArray[0]*calcArray[1]
        }else{
            result[count-1] = calcArray[0]
        }
        calcArray.removeAll()
        //２個以上格納されていたら計算して確定値配列に格納する
        if calcArray.count == 2 {
            if operators == "*" {
                print("＋のcalcArray[0]=\(calcArray[0]),calcArray[1]=\(calcArray[1])")
                //result = calcArray[0]*calcArray[1]
            }else if operators == "/" {
                //result = calcArray[0]/calcArray[1]
            }else if operators == "+" {
                //result = calcArray[0]+calcArray[1]
                calcArray.removeLast()
                //calcArray[0] = result
            }else if operators == "-" {
                //result = calcArray[0]-calcArray[1]
            }
            calcArray.removeLast()
            //calcArray[0] = result
        }
        print("+のresult = \(result)")
        operators = ("+")
        Label.text?.append(" + ")
        loc = (Label.text?.characters.count)!
    }
    
    @IBAction func equal(_ sender: Any) {
        //Label.text?.append(" = ")
        var str = Label.text!
        //calc.calc(str: str)
    }
    
    @IBAction func button7(_ sender: Any) {
        Label.text?.append("7")
    }
    
    @IBAction func button8(_ sender: Any) {
        Label.text?.append("8")
    }
    
    @IBAction func button9(_ sender: Any) {
        Label.text?.append("9")
    }
    
    @IBAction func button4(_ sender: Any) {
        Label.text?.append("4")
    }
    
    @IBAction func button5(_ sender: Any) {
        Label.text?.append("5")
    }
    
    @IBAction func button6(_ sender: Any) {
        Label.text?.append("6")
    }
    
    @IBAction func button1(_ sender: Any) {
        Label.text?.append("1")
    }
    
    @IBAction func button2(_ sender: Any) {
        Label.text?.append("2")
    }
   
    @IBAction func button3(_ sender: Any) {
        Label.text?.append("3")
    }
    
    @IBAction func button0(_ sender: Any) {
        Label.text?.append("0")
    }
    
    @IBAction func buttonP(_ sender: Any) {
        Label.text?.append(".")
        
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

