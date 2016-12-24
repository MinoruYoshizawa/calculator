//
//  ViewController.swift
//  calculator
//
//  Created by 吉澤実 on H28/12/10.
//  Copyright © 平成28年 吉澤実. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let calcDate = calc()
    //var textCount = 0
    //記号格納用配列
    //var operators:String = ""
    //計算用配列
    //var calcArray:[Int64] = []
    //確定値用配列
    //var result:[Int64] = [0]
    //
    //var count:Int = 0
    //
    //var loc:Int = 0
    var labelTmp:String = ""
    
    @IBOutlet weak var Label: UILabel!
    
    
    @IBAction func AC(_ sender: Any) {
        //ラベルを初期化
        Label.text = ""
        //calcDateの変数を初期化
        calcDate.operators = ""
        calcDate.resultMinus = false
        calcDate.calcArray.removeAll()
        calcDate.result.removeAll()
        calcDate.loc = 0
        calcDate.count = 0
    }
    
    @IBAction func plus_minus(_ sender: Any) {
        
    }
    
    
    @IBAction func percent(_ sender: Any) {
        Label.text?.append(" % ")
    }

    
    @IBAction func waru(_ sender: Any) {
        if Label.text != ""{
            if(Label.text!.substring(from: Label.text!.index(before: Label.text!.endIndex))) != " "{
                calcDate.waru(Label: Label.text!)
                Label.text?.append(" ÷ ")
            }
        }
        //0除算のエラー処理
    }

    @IBAction func kakeru(_ sender: Any) {
        if Label.text != ""{
            if(Label.text!.substring(from: Label.text!.index(before: Label.text!.endIndex))) != " "{
                calcDate.kakeru(Label: Label.text!)
                Label.text?.append(" × ")
            }
        }
        
    }
    
    @IBAction func minus(_ sender: Any) {
        //文字列に数字が含まれているかチェックするインスタンスを用意
        let predicate = NSPredicate(format: "SELF MATCHES '\\\\d+'")
        //Labelが空でない場合
        if Label.text != ""{
            //末尾が-でない場合
            if (Label.text!.substring(from: Label.text!.index(before: Label.text!.endIndex))) != "-"{
                //末尾が記号でない場合
                if (Label.text!.substring(from: Label.text!.index(before: Label.text!.endIndex))) != " " {
                    calcDate.minus(Label: Label.text!)
                    Label.text?.append(" - ")
                }
                //末尾が数字でない場合
                else if predicate.evaluate(with: (Label.text!.substring(from: Label.text!.index(before: Label.text!.endIndex)))) && calcDate.operators != "="{
                    Label.text?.append("-")
                }
                //末尾が記号の場合
                else if (Label.text!.substring(from: Label.text!.index(before: Label.text!.endIndex))) == " " && calcDate.operators != "="{
                    Label.text?.append("-")
                }
                
            }
        }else if Label.text == ""{
            Label.text?.append("-")
        }
    }
    
    
    @IBAction func plus(_ sender: Any) {
            if Label.text != ""{
                if(Label.text!.substring(from: Label.text!.index(before: Label.text!.endIndex))) != " "{
                    calcDate.plus(Label: Label.text!)
                    Label.text?.append(" + ")
                }
            }
            print("result = \(calcDate.result)")
    }
    
    @IBAction func equal(_ sender: Any) {
        if Label.text != "" && (Label.text!.substring(from: Label.text!.index(before: Label.text!.endIndex))) != " " && calcDate.operators != "=" {
            let result = calcDate.equal(Label: Label.text!)
            Label.text?.append(" = ")
            Label.text?.append(" \(result) ")
        }
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

