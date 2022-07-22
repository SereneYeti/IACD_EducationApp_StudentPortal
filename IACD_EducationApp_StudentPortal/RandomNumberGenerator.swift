//
//  RandomNumberGenerator.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-011 on 2022/07/21.
//

import Foundation
import SwiftUI

struct RandomNumberGenerator{
    static var randomNumberGenerated:Int = -1
    private var arrayToCheck:[Int] = []
    
        
    public static func GenerateRanodmNumber(numberOfDigits:Int, arrayToCheck:[Int]) -> Int{
        
        var min = GenerateRequiredDigits(iToEdit: 1, numberOfDigitsRequired: numberOfDigits)
        var max = GenerateRequiredDigits(iToEdit: 9, numberOfDigitsRequired: numberOfDigits)
                                
        randomNumberGenerated = Int.random(in: min...max)
        
        var inArray = true
        inArray = CheckForInteger(integerToFind: randomNumberGenerated,arrayToCheck: arrayToCheck)
        
        if(!inArray)
        {
            return randomNumberGenerated
        }
        else
        {
            GenerateRanodmNumber(numberOfDigits: numberOfDigits, arrayToCheck: arrayToCheck)
        }
        
        return -1;
        
    }
    
    private static func GenerateRequiredDigits(iToEdit:Int, numberOfDigitsRequired:Int) -> Int{
        var iEdited = iToEdit
        
        for _ in (1...numberOfDigitsRequired){
            iEdited = iEdited*10
        }
        
        return iEdited;
    }
    
    private static func CheckForInteger(integerToFind:Int,arrayToCheck:[Int]) -> Bool{
        var ans = false
        
        for index in arrayToCheck{
            if(integerToFind != index)  { ans = false }
            else
            {
                ans = true
                break;
            }
        }
        
        return ans;
    }
}
