//
//  Matrix.swift
//  Matrix
//
//  Created by Nikita Kiselov on 1/15/20.
//  Copyright © 2020 Nikita Kiselov. All rights reserved.
//

import Foundation


public class Matrix: CustomStringConvertible{
    
    var elements:[[Double]]
    
    public var rowsCount:Int{
        return elements.count
    }
    
    public var columnsCount:Int{
        return elements[0].count
    }
    
    public var count:(Int,Int){
        return (rowsCount,columnsCount)
    }
    
    public var transpose:Matrix {
        let transpose = Matrix(columnsCount,rowsCount)
        for i in 0..<rowsCount{
            for j in 0..<columnsCount{
                transpose[j,i]=self[i,j]
            }
        }
        return transpose
    }
    
    public var inverse:Matrix {
        if(!(rowsCount==columnsCount)){
        fatalError("Can't take inverse of non square matrix, try left/right inverse")
        }
        let size = rowsCount
        let reduced = copy()
        let result = Matrix.identity(size)
        var columns:[Int]=[]
        for i in 0..<size{
            columns.append(i)
        }
        var order = Array(repeating: 0, count: size)
        print(reduced)
        print(result)
        for i in 0..<size{
            var scale:Double = 0
            var c = 0
            for ci in 0..<columns.count{
                c = columns[ci]
                scale = reduced[i,c]
                if(scale != 0){
                    break;
                }
            }
            order[c]=i
            for j in 0..<size{
                reduced[i, j]/=scale
                result[i, j]/=scale
            }
            for a in 0..<size{
                let multiple = reduced[a, c]
                if (a != i) {
                    for j in 0..<size{
                        reduced[a, j] -= multiple*reduced[i,j]
                        result[a, j] -= multiple*result[i,j]
                    }
                }
            }
            print("-------------------------------------")
            print(reduced)
            print(result)
        }
        var flippedRows:[Vector] = []
        for i in 0..<size{
            flippedRows.append(result[order[i],0..<result.columnsCount].rows()[0])
        }
        return Matrix(rows: flippedRows)
    }
    
    public var rightInverse:Matrix {
        return self.transpose*(self*self.transpose).inverse
    }
    
    public var leftInverse:Matrix {
        return (self.transpose*self).inverse*self.transpose
    }
    
    public var sqrNorm:Double{
         var sqrNorm:Double=0
         for i in 0..<rowsCount{
            for j in 0..<columnsCount{
                sqrNorm+=elements[i][j]*elements[i][j]
            }
         }
         return sqrNorm
    }
    
    public var norm:Double{
        return sqrt(sqrNorm)
    }
    
    public var determinant:Double{
        if(rowsCount != columnsCount){
            fatalError("Cn not take determinant of a non square matrix")
        }
        var det:Double = 1
        let size = rowsCount
        let reduced = copy()
        var columns:[Int]=[]
        for i in 0..<size{
            columns.append(i)
        }
        var order = Array(repeating: 0, count: size)
        var set:[Int] = []
        for i in 0..<size{
            var scale:Double = 0
            var c = 0
            for ci in 0..<columns.count{
                c = columns[ci]
                scale = reduced[i, c]
                if(scale != 0){
                    break;
                }
            }
            if(set.contains(c)){
                return 0
            }
            order[c]=i
            set.append(c)
            det*=scale
            for j in 0..<size{
                reduced[i, j]/=scale
            }
            for a in 0..<size{
                let multiple = reduced[a, c]
                if (a != i) {
                    for j in 0..<size{
                        reduced[a, j] -= multiple*reduced[i,j]
                    }
                }
            }
        }
        var elim = Array(repeating: 0, count: size)
        for i in 0..<elim.count{
            elim[i]=i
        }
        var t=0
        for i in 0..<size{
            let index = elim.firstIndex(of: order[i])!
            t+=index%2
            elim.remove(at: index)
        }
        if(t%2==1){
            det = -det
        }
        return det
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
    
    public init(_ elements:[[Double]]){
        self.elements=elements
    }
    
    public init(_ rowsCount:Int, _ columnsCount:Int){
        elements = Array(repeating: Array(repeating: 0, count: columnsCount), count: rowsCount)
    }
    
    public convenience init(rows: [Vector]){
        let rowsCount = rows.count
        let columnsCount = rows[0].count
        self.init(rowsCount,columnsCount)
        for r in 0..<rowsCount{
            if(!(rows[r].count==columnsCount)){
                fatalError("Can't create matrix from different sized rows")
            }
            for c in 0..<columnsCount{
                elements[r][c]=rows[r][c]
            }
        }
    }
    
    public convenience init(columns: [Vector]){
        let rowsCount = columns[0].count
        let columnsCount = columns.count
        self.init(rowsCount,columnsCount)
        for c in 0..<columnsCount{
            if(!(columns[c].count==rowsCount)){
                fatalError("Can't create matrix from different sized columns")
            }
            for r in 0..<rowsCount{
                elements[r][c]=columns[c][r]
            }
        }
    }
    
    subscript(r: Int,c: Int)->Double{
        get{
            return elements[r][c]
        }
        set(m){
            elements[r][c]=m
        }
    }
    
    subscript(r: Range<Int>,c: Int)->Matrix{
        get{
            let m = Matrix(r.count, 1)
            for i in 0..<r.count{
                m[i,0]=self[r.lowerBound+i,c]
            }
            return m
        }
        set(m){
            for i in 0..<r.count{
                self[r.lowerBound+i,c]=m[i,0]
            }
        }
    }
    
    subscript(r: ClosedRange<Int>,c: Int)->Matrix{
        get{
            let m = Matrix(r.count, 1)
            for i in 0..<r.count{
                m[i,0]=self[r.lowerBound+i,c]
            }
            return m
        }
        set(m){
            for i in 0..<r.count{
                self[r.lowerBound+i,c]=m[i,0]
            }
        }
    }
    
    subscript(r: Int,c: Range<Int>)->Matrix{
        get{
            let m = Matrix(1,c.count)
            for i in 0..<c.count{
                m[0,i]=self[r,c.lowerBound+i]
            }
            return m
        }
        set(m){
            for i in 0..<c.count{
                self[r,c.lowerBound+i]=m[0,i]
            }
        }
    }
    
    subscript(r: Int,c: ClosedRange<Int>)->Matrix{
        get{
            let m = Matrix(1,c.count)
            for i in 0..<c.count{
                m[0,i]=self[r,c.lowerBound+i]
            }
            return m
        }
        set(m){
            for i in 0..<c.count{
                self[r,c.lowerBound+i]=m[0,i]
            }
        }
    }
    
    subscript(r: Range<Int>,c: Range<Int>)->Matrix{
        get{
            let m = Matrix(r.count, c.count)
            for i in 0..<r.count{
                for j in 0..<c.count{
                    m[i,j]=self[r.lowerBound+i,c.lowerBound+j]
                }
            }
            return m
        }
        set(m){
            for i in 0..<r.count{
                for j in 0..<c.count{
                    self[r.lowerBound+i,c.lowerBound+j]=m[i,j]
                }
            }
        }
    }
    
    subscript(r: ClosedRange<Int>,c: ClosedRange<Int>)->Matrix{
        get{
            let m = Matrix(r.count, c.count)
            for i in 0..<r.count{
                for j in 0..<c.count{
                    m[i,j]=self[r.lowerBound+i,c.lowerBound+j]
                }
            }
            return m
        }
        set(m){
            for i in 0..<r.count{
                for j in 0..<c.count{
                    self[r.lowerBound+i,c.lowerBound+j]=m[i,j]
                }
            }
        }
    }
    
    public func cols()->[Vector]{
        var columns:[Vector] = []
        for j in 0..<columnsCount{
            columns.append(Vector(rowsCount))
            for i in 0..<rowsCount{
                columns[j][i]=self[i,j]
            }
        }
        return columns
    }
    
    public func rows()->[Vector]{
        var rows:[Vector] = []
        for i in 0..<rowsCount{
            rows.append(Vector(columnsCount))
            for j in 0..<columnsCount{
                rows[i][j]=self[i,j]
            }
        }
        return rows
    }
    
    public func getElements()->[[Double]]{
        return elements
    }
    
    public func copy()->Matrix{
        let ret = Matrix(rowsCount,columnsCount)
        for i in 0..<rowsCount{
            for j in 0..<columnsCount{
                ret[i,j]=elements[i][j]
            }
        }
        return ret
    }
    
    public static func identity(_ size:Int)->Matrix{
        let identity = Matrix(size,size)
        for i in 0..<size{
            identity[i, i] = 1
        }
        return identity
    }
    
    public static func diagonal(_ entries:[Double])->Matrix{
        let size = entries.count
        let diagonal = Matrix(size,size)
        for i in 0..<size{
            diagonal[i, i] = entries[i]
        }
        return diagonal
    }
}
