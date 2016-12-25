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
    var strTmp:String = ""
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var Label: UILabel!
    
    
    @IBAction func AC(_ sender: Any) {
        //ラベルを初期化
        Label.text = ""
        //calcクラスの変数を初期化
        calcDate.operators = ""
        calcDate.resultMinus = false
        calcDate.calcArray.removeAll()
        calcDate.result.removeAll()
        calcDate.result = [0]
        calcDate.loc = 0
        calcDate.count = 0
    }
    
    @IBAction func waru(_ sender: Any) {
        //ラベルに何も入っていない場合は除く
        if Label.text != ""{
            //記号の直後は除外する（記号は半角スペースが挿入されるので末尾に無いかチェック）
            if(Label.text!.substring(from: Label.text!.index(before: Label.text!.endIndex))) != " "{
                if (Label.text!.substring(from: Label.text!.index(before: Label.text!.endIndex))) != "-"{
                    calcDate.waru(Label: Label.text!)
                    Label.text?.append(" ÷ ")
                }
            }
        }
    }

    @IBAction func kakeru(_ sender: Any) {
        if Label.text != ""{
            if(Label.text!.substring(from: Label.text!.index(before: Label.text!.endIndex))) != " "{
                //直前が-でない場合
                if (Label.text!.substring(from: Label.text!.index(before: Label.text!.endIndex))) != "-"{
                    calcDate.kakeru(Label: Label.text!)
                    Label.text?.append(" × ")
                }
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
                    if calcDate.operators != "-" {
                        if(calcDate.operators != "+"){
                            Label.text?.append("-")
                        }
                    }
                }
                //末尾が記号の場合
                else if (Label.text!.substring(from: Label.text!.index(before: Label.text!.endIndex))) == " " && calcDate.operators != "="{
                    if calcDate.operators != "-" {
                        if(calcDate.operators != "+"){
                            Label.text?.append("-")
                        }
                    }
                }
                
            }
        }else if Label.text == ""{
            Label.text?.append("-")
        }
    }
    
    //minusは考慮すべきケースが多いがplusはそんなに無い
    @IBAction func plus(_ sender: Any) {
            if Label.text != ""{
                if(Label.text!.substring(from: Label.text!.index(before: Label.text!.endIndex))) != " "{
                    if (Label.text!.substring(from: Label.text!.index(before: Label.text!.endIndex))) != "-"{
                        calcDate.plus(Label: Label.text!)
                        Label.text?.append(" + ")
                    }
                }
            }
            print("result = \(calcDate.result)")
    }
    
    @IBAction func equal(_ sender: Any) {
        //初期状態、記号の後、＝の直後（数値が末尾）の場合以外
        if Label.text != "" && (Label.text!.substring(from: Label.text!.index(before: Label.text!.endIndex))) != " " && calcDate.operators != "=" {
            if (Label.text!.substring(from: Label.text!.index(before: Label.text!.endIndex))) != "-"{
                //計算結果を入手
                var result = calcDate.equal(Label: Label.text!)
                Label.text?.append(" = ")
                //計算結果を出力(四捨五入して小数点第３桁まで表示)
                result = result * 1000
                //0除算の場合のエラー処理も入れておく("÷ 0 "が含まれていない場合答えを出力する)
                if Label.text!.contains("÷ 0 ") == false {
                    Label.text?.append(" \(round(result) / 1000) ")
                }else{
                    Label.text?.append(" \nError :due to division by zero ")
                }
            }
        }
    }

    //数字の処理をまとめて記述
    @IBAction func num(_ sender: UIButton) {
        print((NSString(string: Label.text!).substring(with: NSRange(location: calcDate.loc, length: (Label.text!.characters.count)-calcDate.loc))).contains("."))
        print("calcDAte.loc = \(calcDate.loc)")
        print("length = \(Label.text!.characters.count-calcDate.loc)")
        print("sender.tag = \(sender.tag)")
        strTmp = (NSString(string: Label.text!).substring(with: NSRange(location: calcDate.loc, length: (Label.text!.characters.count)-calcDate.loc)))
        //=の後には出力しない
        if calcDate.operators != "="{
            //数字の場合
            if sender.tag < 10{
                if strTmp != "" && strTmp[strTmp.startIndex] != "0" {
            
                        Label.text?.append("\(sender.tag)")
                    
                }else if strTmp.characters.count > 1 && strTmp[strTmp.index(after: strTmp.startIndex)] == "." {
                    Label.text?.append("\(sender.tag)")
                }else if strTmp == "" {
                    Label.text?.append("\(sender.tag)")
                }
                
            //ピリオドの場合
            }else if Label.text != "" && (Label.text!.substring(from: Label.text!.index(before: Label.text!.endIndex))) != " " {
                //ピリオドを連続で出力することを防止する(現状の計算する文字列にピリオドが含まれているかチェック)
                if (NSString(string: Label.text!).substring(with: NSRange(location: calcDate.loc, length: (Label.text!.characters.count)-calcDate.loc))).contains(".") == false {
                    //直前が-でない場合
                    if (Label.text!.substring(from: Label.text!.index(before: Label.text!.endIndex))) != "-"{
                        Label.text?.append(".")
                    }
                }
            }
            if sender.tag == 0{
                
                /*
                if strTmp != "" && strTmp[strTmp.startIndex] != "0" {
                    Label.text?.append("\(sender.tag)")
                }else if strTmp == "" {
                    Label.text?.append("\(sender.tag)")
                }else if strTmp.characters.count > 1 && strTmp[strTmp.index(after: strTmp.startIndex)] == "." {
                    Label.text?.append("\(sender.tag)")
                }
                */
                /*
                if(calcDate.loc != 0){
                    //print("label.text.endIndex = \((Label.text?.endIndex)!), offsetBy:\((Label.text!.characters.count)-calcDate.loc))))")
                    //print("before:label = \(Label.text?.index(before:(Label.text?.endIndex)!))")
                    
                    //strTmp = (Label.text?.substring(to:Label.text!.index((Label.text?.endIndex)!, offsetBy: (Label.text!.characters.count)-calcDate.loc)))!
                    
                    //let str = (NSString(string: Label.text!).substring(with: NSRange(location: calcDate.loc, length: (Label.text!.characters.count)-calcDate.loc)))
                    //print(str[str.startIndex])
                    
                
                }else if strTmp != ""{
                    if strTmp[strTmp.startIndex] != "0" {
                        self.Label.text?.append("\(sender.tag)")
                    }
                }else {
                    self.Label.text?.append("\(sender.tag)")
                }
                */
                
                
                //if (NSString(string: Label.text!).substring(with: NSRange(location: calcDate.loc, length: (Label.text!.characters.count)-calcDate.loc))).contains(".") == true {
                   // if Label.text?.substring(to:Label.text!.index((Label.text?.endIndex)!, offsetBy: (Label.text!.characters.count)-calcDate.loc)) == ""{
                       // self.Label.text?.append("\(sender.tag)")
                   // }
                //}
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.view.backgroundColor = UIColor.white
        //let screenSize = UIScreen.main.bounds.size
        // 表示可能最大行数を無制限にする.
        Label.numberOfLines = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

