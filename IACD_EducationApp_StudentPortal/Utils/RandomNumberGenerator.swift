//
//  RandomNumberGenerator.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/21.
//

import Foundation
import SwiftUI

struct RandomNumberGenerator{
    /*
     NOTE: When using the random number generator Call the random number generator first.
     Then to store the value from randomNumberGenerated in the variable or array you wish to store the generated number in.
    EXAMPLE TEST CODE
        var testArr:[Int] = []

        for _ in 1...100{
            RandomNumberGenerator.GenerateRanodmNumber(numberOfDigits: 6, arrayToCheck: testArr)
            testArr.append(RandomNumberGenerator.randomNumberGenerated)
        }

        print(testArr)
    */
    
    public static var randomNumberGenerated:Int = -1
    private var arrayToCheck:[Int] = []
    
        
    public static func GenerateRanodmNumber(numberOfDigits:Int, arrayToCheck:[Int]){
                
        let min = GenerateRequiredDigits(iToEdit: 1, numberOfDigitsRequired: numberOfDigits)
        let max = GenerateRequiredDigits(iToEdit: 9, numberOfDigitsRequired: numberOfDigits)
                                
        randomNumberGenerated = Int.random(in: min...max)
        
        //print("Random Number: \(randomNumberGenerated)")
        
        var inArray = true
        
        inArray = CheckForInteger(integerToFind: randomNumberGenerated,arrayToCheck: arrayToCheck)
        
        if(inArray)
        {
            print("Re-running number generation. Current Number Generated \(randomNumberGenerated)")
            GenerateRanodmNumber(numberOfDigits: numberOfDigits, arrayToCheck: arrayToCheck)
        }        
    }
    
    private static func GenerateRequiredDigits(iToEdit:Int, numberOfDigitsRequired:Int) -> Int{
        var iEdited = iToEdit
        
        if(numberOfDigitsRequired > 0){
            for _ in (1...numberOfDigitsRequired){
                iEdited = iEdited*10
            }
            
            if(numberOfDigitsRequired >= 1 && iToEdit == 9){
                let temp = String(iEdited)
                let tempUpdated = temp.replacingOccurrences(of: "0", with: "9")
                iEdited = Int(tempUpdated) ?? iEdited
            }
        }
        
        return iEdited;
    }
    
    //true = in array ; false = not in array
    private static func CheckForInteger(integerToFind:Int,arrayToCheck:[Int]) -> Bool{
        var ans = false
       
        for index in arrayToCheck{
            if(integerToFind != index)  { ans = false }
            else
            {
                ans = true
                return ans
            }
        }
        
        return ans;
    }
}
