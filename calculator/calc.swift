//
//  calc.swift
//  calculator
//
//  Created by 吉澤実 on H28/12/18.
//  Copyright © 平成28年 吉澤実. All rights reserved.
//

import Foundation

class calc {

    //記号格納用変数
    var operators:String = ""
    //-の場合に符号を判定させるための変数
    var resultMinus:Bool = false
    //計算用配列
    var calcArray:[Double] = []
    //確定値用配列
    var result:[Double] = [0]
    //文字列抜き出し用変数
    var loc:Int = 0
    //演算が行われた数をカウントしresult配列のどこに答えを格納するか判断するための変数
    var count:Int = 0
    
    init() {
        self.operators = "First"
    }
    
    func kakeru(Label: String?){
        //-符号が付いている場合、文字列の抜き出しは-も含めるようにする
        if(Label!.substring(from: Label!.index(before: Label!.endIndex))) == "-"{
            loc = loc+1
        }
        //指定した範囲の文字列を抜き出す。記号の前の数値を抜き出して計算用配列に格納する
        //substring(with:start,length:スタート地点からの文字数まで)
        if loc != 0 {
        let textTmp = NSString(string: Label!).substring(with: NSRange(location: loc, length: (Label?.characters.count)!-loc))

        calcArray.append(Double(textTmp)!)
        }else{
            //let textTemp = Label?.substring(to: (Label?.index(after: (Label?.startIndex)!))!)
            calcArray.append(Double(Label!)!)
        }
        //２個以上格納されていたら計算して確定値配列に格納する
        print("calcArray.count = \(calcArray.count)")
        
        //+でカウントが消えるから必要ない？
        if calcArray.count == 2 {
            if operators == "*" {
                print("calcArray[0]=\(calcArray[0]),calcArray[1]=\(calcArray[1])")
                if result[count] == 0 {
                    //resultに何も入っていない場合（一番最初の場合）
                    result[count] = result[count] + calcArray[0]*calcArray[1]
                }else {
                    //resultに値が入ってる場合その数値と掛け合わせる
                    result[count] = result[count] * calcArray[1]
                }
                calcArray.removeLast()
                calcArray[0] = result[count]
            }else if operators == "/" {
                print("calcArray[0]=\(calcArray[0]),calcArray[1]=\(calcArray[1])")
                if result[count] == 0 {
                    //resultに何も入っていない場合（一番最初の場合）
                    //0除算の処理
                    if calcArray[1] != 0{
                        result[count] = result[count] + calcArray[0]/calcArray[1]
                    }else{
                        print("0除算が発生")
                    }
                }else {
                    //resultに値が入ってる場合その数値と掛け合わせる
                    result[count] = result[count] / calcArray[1]
                }
                calcArray.removeLast()
                calcArray[0] = result[count]
            }
        }
        print("result = \(result)")
        operators = ("*")
        //文字列抜き出しの開始位置をずらす（計算済みのところを排除したい）
        loc = (Label?.characters.count)!+3
    }
    
    func waru(Label: String?){
        //-符号が付いている場合、文字列の抜き出しは-も含めるようにする
        if(Label!.substring(from: Label!.index(before: Label!.endIndex))) == "-"{
            loc = loc+1
        }
        //指定した範囲の文字列を抜き出す。記号の前の数値を抜き出して計算用配列に格納する
        //substring(with:start,length:スタート地点からの文字数まで)
        if loc != 0 {
            let textTmp = NSString(string: Label!).substring(with: NSRange(location: loc, length: (Label?.characters.count)!-loc))
            
            calcArray.append(Double(textTmp)!)
        }else{
            //let textTemp = Label?.substring(to: (Label?.index(after: (Label?.startIndex)!))!)
            calcArray.append(Double(Label!)!)
        }
        //２個以上格納されていたら計算して確定値配列に格納する
        print("calcArray.count = \(calcArray.count)")
        
        //+でカウントが消えるから必要ない？
        if calcArray.count == 2 {
            if operators == "*" {
                print("calcArray[0]=\(calcArray[0]),calcArray[1]=\(calcArray[1])")
                if result[count] == 0 {
                    //resultに何も入っていない場合（一番最初の場合）
                    result[count] = result[count] + calcArray[0]*calcArray[1]
                }else {
                    //resultに値が入ってる場合その数値と掛け合わせる
                    result[count] = result[count] * calcArray[1]
                }
                calcArray.removeLast()
                calcArray[0] = result[count]
            }else if operators == "/" {
                print("calcArray[0]=\(calcArray[0]),calcArray[1]=\(calcArray[1])")
                if result[count] == 0 {
                    //resultに何も入っていない場合（一番最初の場合）
                    //0除算の処理
                    if calcArray[1] != 0{
                        result[count] = result[count] + calcArray[0]/calcArray[1]
                    }else{
                        print("0除算が発生")
                    }
                }else {
                    //resultに値が入ってる場合その数値と掛け合わせる
                    result[count] = result[count] / calcArray[1]
                }
                calcArray.removeLast()
                calcArray[0] = result[count]
            }
        }
        print("result = \(result)")
        operators = ("/")
        //文字列抜き出しの開始位置をずらす（計算済みのところを排除したい）
        loc = (Label?.characters.count)!+3
    
    }
    
    func plus(Label: String?){
        count = count + 1
        if(Label!.substring(from: Label!.index(before: Label!.endIndex))) == "-"{
            loc = loc+1
        }
        //resultの配列要素を増やす（新しく追加した+以前の数値を計算済みとする）
        result.append(0)
        //最初の計算でない時
        if loc != 0 {
        let textTmp = NSString(string: Label!).substring(with: NSRange(location: loc, length: (Label?.characters.count)!-loc))
        calcArray.append(Double(textTmp)!)
        //最初の計算の時
        }else{
            calcArray.append(Double(Label!)!)
        }
        print("calcArray2 = \(calcArray)")
        //×とか/の計算が必要な場合
        if calcArray.count == 2 {
            if operators == "*" {
                result[count-1] = calcArray[0]*calcArray[1]
            }else if operators == "/" {
                if calcArray[1] != 0{
                    result[count-1] = calcArray[0]/calcArray[1]
                }else{
                    
                }
            }
            //演算子が-の場合符号を反転させる
            if resultMinus == true {
                result[count-1] = result[count-1] * -1
            }
        //計算が必要ない場合
        }else{
            result[count-1] = calcArray[0]
            if resultMinus == true {
                result[count-1] = result[count-1] * -1
            }
        }
        //計算用配列全消去
        calcArray.removeAll()
        resultMinus = false
        print("+のresult = \(result)")
        //ラベルの文字数と演算子分の文字数（３）を足す
        loc = (Label?.characters.count)!+3
        operators = ("+")
        
    }
    
    func minus(Label: String?){
        count = count + 1
        if(Label!.substring(from: Label!.index(before: Label!.endIndex))) == "-"{
            loc = loc+1
        }
        //resultの配列要素を増やす（新しく追加した+以前の数値を計算済みとする）
        result.append(0)
        //最初の計算でない時
        if loc != 0 {
            let textTmp = NSString(string: Label!).substring(with: NSRange(location: loc, length: (Label?.characters.count)!-loc))
            calcArray.append(Double(textTmp)!)
            //最初の計算の時
        }else{
            calcArray.append(Double(Label!)!)
        }
        print("calcArray2 = \(calcArray)")
        
        if calcArray.count == 2 {
            if operators == "*" {
                result[count-1] = calcArray[0]*calcArray[1]
            }else if operators == "/" {
                if calcArray[1] != 0{
                    result[count-1] = calcArray[0]/calcArray[1]
                }else{
                    
                }
            }
        }else{
            result[count-1] = calcArray[0]
        }
        //計算用配列全消去
        calcArray.removeAll()
        //符号を反転
        if resultMinus == true {
            result[count-1] = result[count-1] * -1
        }
        print("+のresult = \(result)")
        //ラベルの文字数と演算子分の文字数（３）を足す
        loc = (Label?.characters.count)!+3
        operators = ("-")
        resultMinus = true
    }
    
    func equal(Label: String?) -> Double{
        count = count + 1
        if(Label!.substring(from: Label!.index(before: Label!.endIndex))) == "-"{
            loc = loc+1
        }
        //resultの配列要素を増やす（新しく追加した+以前の数値を計算済みとする）
        result.append(0)
        //最初の計算でない時
        if loc != 0 {
            let textTmp = NSString(string: Label!).substring(with: NSRange(location: loc, length: (Label?.characters.count)!-loc))
            calcArray.append(Double(textTmp)!)
            //最初の計算の時
        }else{
            calcArray.append(Double(Label!)!)
        }
        print("calcArray2 = \(calcArray)")
        //×とか/の計算が必要な場合
        if calcArray.count == 2 {
            if operators == "*" {
                result[count-1] = calcArray[0]*calcArray[1]
            }else if operators == "/" {
                if calcArray[1] != 0{
                    result[count-1] = calcArray[0]/calcArray[1]
                }else{
                    
                }
            }
            //演算子が-の場合符号を反転させる
            if resultMinus == true {
                result[count-1] = result[count-1] * -1
            }
            //計算が必要ない場合
        }else{
            result[count-1] = calcArray[0]
            if resultMinus == true {
                result[count-1] = result[count-1] * -1
            }
        }
        //計算用配列全消去
        calcArray.removeAll()
        //resultMinus = false
        print("+のresult = \(result)")
        //ラベルの文字数と演算子分の文字数（３）を足す
        //loc = (Label?.characters.count)!+3
        operators = ("=")
        //return配列の中身を足し合わせる
        return (result.reduce(0, { $0 + $1 }))
    }
    
    
}
