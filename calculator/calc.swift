//
//  calc.swift
//  calculator
//
//  Created by 吉澤実 on H28/12/18.
//  Copyright © 平成28年 吉澤実. All rights reserved.
//

import Foundation

class calc {

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
    
    
    func kakeru(Label:String){
        //指定した範囲の文字列を抜き出す。記号の前の数値を抜き出して計算用配列に格納する
        //substring(with:start,length:スタート地点からの文字数まで)
        let textTmp = NSString(string: Label).substring(with: NSRange(location: loc, length: (Label.count)!-loc))
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
    
    
}
