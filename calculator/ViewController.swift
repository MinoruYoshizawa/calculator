//
//  ViewController.swift
//  calculator
//
//  Created by 吉澤実 on H28/12/10.
//  Copyright © 平成28年 吉澤実. All rights reserved.
//  

//四則演算を行う計算機、結果は小数点第４位で四捨五入される,10桁までの演算に制限
import UIKit

class ViewController: UIViewController {
    //calcクラスのインスタンスを作っておく
    let calcDate = calc()
    //計算する部分のラベル文字列を入れておくための箱
    var strTmp:String = ""
    //ラベルを改行したかったので用意
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
        calcDate.result = [0]//最初に1要素が必要な作りにしてしまったので用意しとく
        calcDate.loc = 0
        calcDate.count = 0
        //"-0"のチェックをするための箱を初期化
        calcDate.MinusZeroCheck = ""
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

    //数字ボタンが押されたときの処理をまとめて記述
    @IBAction func num(_ sender: UIButton) {
        //デバッグ用print文
//        print((NSString(string: Label.text!).substring(with: NSRange(location: calcDate.loc, length: (Label.text!.characters.count)-calcDate.loc))).contains("."))
//        print("calcDAte.loc = \(calcDate.loc)")
//        print("length = \(Label.text!.characters.count-calcDate.loc)")
//        print("sender.tag = \(sender.tag)")
        
        //例外処理を行うために現在の計算部分を抜き出しておく
        strTmp = (NSString(string: Label.text!).substring(with: NSRange(location: calcDate.loc, length: (Label.text!.characters.count)-calcDate.loc)))
        //"-0"の時数字を入力できないようにするために、先頭二文字を抜き出しておく
        if strTmp.characters.count > 1 {
            let str1 = strTmp[strTmp.startIndex]
            let str2 = strTmp[strTmp.index(after: strTmp.startIndex)]
            calcDate.MinusZeroCheck = String(str1) + String(str2)
        }
        
        //全ての場合で=の後には出力しない
        if calcDate.operators != "=" {
            //数字の場合（数字は0~9のtagが設定されている）
            if sender.tag < 10{
                //最初の数字が0じゃない場合（01234とかを入力させない),10桁までしか入力させない,-と-0じゃない時
                if strTmp != "" && strTmp[strTmp.startIndex] != "0" && (Label.text!.substring(from: Label.text!.index(before: Label.text!.endIndex))) != "-" && calcDate.MinusZeroCheck != "-0" && fabs(Double(strTmp)!) < 100000000.0{
                        Label.text?.append("\(sender.tag)")
                //二番目の文字が.の場合（0.000）
                }else if strTmp.characters.count > 1 && strTmp[strTmp.index(after: strTmp.startIndex)] == "." {
                    Label.text?.append("\(sender.tag)")
                //現在の計算部分に何も入力されていない場合は何の制限も無い
                }else if strTmp == "" {
                    Label.text?.append("\(sender.tag)")
                //末尾が-の場合は入力できる
                }else if (Label.text!.substring(from: Label.text!.index(before: Label.text!.endIndex))) == "-" {
                    Label.text?.append("\(sender.tag)")
                //三番目の文字が.の場合（-0.000）
                }else if strTmp.characters.count > 2 && strTmp[strTmp.index(after: strTmp.index(after: strTmp.startIndex))] == "." {
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
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //self.view.backgroundColor = UIColor.white
        //let screenSize = UIScreen.main.bounds.size
        // ラベルの表示可能最大行数を無制限にする.
        Label.numberOfLines = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

