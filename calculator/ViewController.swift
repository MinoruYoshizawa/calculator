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
        //初期状態、記号の後、＝の直後（数値が末尾）の場合以外
        if Label.text != "" && (Label.text!.substring(from: Label.text!.index(before: Label.text!.endIndex))) != " " && calcDate.operators != "=" {
            //計算結果を入手
            let result = calcDate.equal(Label: Label.text!)
            Label.text?.append(" = ")
            //計算結果を出力
            Label.text?.append(" \(result) ")
        }
    }

    //数字の処理をまとめて記述
    @IBAction func num(_ sender: UIButton) {
        print((NSString(string: Label.text!).substring(with: NSRange(location: calcDate.loc, length: (Label.text!.characters.count)-calcDate.loc))).contains("."))
        print("calcDAte.loc = \(calcDate.loc)")
        print("length = \(Label.text!.characters.count-calcDate.loc)")
        print("sender.tag = \(sender.tag)")
        //=の後には出力しない
        if calcDate.operators != "="{
            //数字の場合
            if sender.tag < 10 {
                Label.text?.append("\(sender.tag)")
            //ピリオドの場合
            }else if Label.text != "" && (Label.text!.substring(from: Label.text!.index(before: Label.text!.endIndex))) != " " {
                //ピリオドを連続で出力することを防止する
                if (NSString(string: Label.text!).substring(with: NSRange(location: calcDate.loc, length: (Label.text!.characters.count)-calcDate.loc))).contains(".") == false {
                    Label.text?.append(".")
                }
            }
        }
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

