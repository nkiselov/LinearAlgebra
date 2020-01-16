//
//  Matrix.swift
//  Matrix
//
//  Created by Nikita Kiselov on 1/15/20.
//  Copyright © 2020 Nikita Kiselov. All rights reserved.
//

import Foundation

precedencegroup MatrixProduct {
    lowerThan: BitwiseShiftPrecedence
    higherThan: MultiplicationPrecedence
    associativity: left
    assignment: false
}

infix operator *:MatrixProduct
func *(lhs: Matrix, rhs: Matrix) -> Matrix {
    if(!(rhs.rowsCount==lhs.columnsCount)){
        fatalError("Can't apply matrix product to matrices with lhs columns count different than rhs rows count")
    }
    let res = Matrix(lhs.rowsCount,rhs.columnsCount)
    for r in 0 ..< res.rowsCount{
        for c in 0 ..< res.columnsCount{
            var sum:Double = 0
            for i in 0..<rhs.rowsCount{
                sum+=lhs.get(r, i)*rhs.get(i, c)
            }
            res.set(r, c, sum)
        }
    }
    return res
}

class Matrix: CustomStringConvertible{
    var elements:[[Double]]
    var rowsCount:Int{
        return elements.count
    }
    var columnsCount:Int{
        return elements[0].count
    }
    public var description: String {
        var table:[[String]] = Array(repeating: Array(repeating: "", count: columnsCount+1), count: rowsCount+1)
        var maxLengths:[Int] = Array(repeating: 0, count: columnsCount+1)
        for c in 0..<columnsCount{
            table[0][c+1]=c.description+":"
        }
        for r in 0..<rowsCount{
            let l=r.description+":"
            if(maxLengths[0]<l.count){
                maxLengths[0]=l.count
            }
            table[r+1][0] = l
            for c in 0..<columnsCount{
                let s = elements[r][c].description
                if(maxLengths[c+1]<s.count){
                    maxLengths[c+1]=s.count
                }
                table[r+1][c+1]=s
            }
        }
        var description = "Matrix "+rowsCount.description+"x"+columnsCount.description+":"
        for r in 0...rowsCount{
            var line=""
            for c in 0...columnsCount{
                line+=table[r][c].padding(toLength: maxLengths[c]+4, withPad: " ", startingAt: 0)
            }
            description+="\n"+line
        }
        return description
    }
    
    init(_ rowsCount:Int, _ columnsCount:Int){
        elements = Array(repeating: Array(repeating: 0, count: columnsCount), count: rowsCount)
    }
    
    convenience init(rows: [Vector]){
        let rowsCount = rows.count
        let columnsCount = rows[0].count
        self.init(rowsCount,columnsCount)
        for r in 0..<rowsCount{
            if(!(rows[r].count==columnsCount)){
                fatalError("Can't create matrix from different sized rows")
            }
            for c in 0..<columnsCount{
                elements[r][c]=rows[r].get(c)
            }
        }
    }
    
    convenience init(columns: [Vector]){
        let rowsCount = columns[0].count
        let columnsCount = columns.count
        self.init(rowsCount,columnsCount)
        for c in 0..<columnsCount{
            if(!(columns[c].count==rowsCount)){
                fatalError("Can't create matrix from different sized columns")
            }
            for r in 0..<rowsCount{
                elements[r][c]=columns[c].get(r)
            }
        }
    }
    
    func get(_ r:Int, _ c:Int)->Double{
        return elements[r][c]
    }
    
    func set(_ r:Int, _ c:Int, _ v:Double){
         elements[r][c]=v
    }
}
