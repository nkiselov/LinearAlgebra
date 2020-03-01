//
//  MatrixOperators.swift
//  LinearAlgebra
//
//  Created by Nikita on 28.02.2020.
//  Copyright © 2020 Nikita Kiselov. All rights reserved.
//
//  Useful matrix operators in linear algebra

import Foundation

//Regular matrix multiplication
public func *(lhs: Matrix, rhs: Matrix) -> Matrix {
    if(!(rhs.rowsCount==lhs.columnsCount)){
        fatalError("Can't apply matrix product to matrices with lhs columns count different than rhs rows count")
    }
    let res = Matrix(lhs.rowsCount,rhs.columnsCount)
    for r in 0 ..< res.rowsCount{
        for c in 0 ..< res.columnsCount{
            var sum:Double = 0
            for i in 0..<rhs.rowsCount{
                sum+=lhs[r, i]*rhs[i, c]
            }
            res[r, c] = sum
        }
    }
    return res
}

//Matrix-Vector product
public func *(lhs: Matrix, rhs: Vector) -> Vector {
    if(!(rhs.count==lhs.columnsCount)){
        fatalError("Can't apply matrix-vector product to matricex with columns count different than vector size")
    }
    let res = Vector(lhs.rowsCount)
    for r in 0 ..< lhs.rowsCount{
        var sum:Double=0
        for c in 0 ..< lhs.columnsCount{
            sum+=lhs[r, c]*rhs[c]
        }
        res[r] = sum
    }
    return res
}

//Regular matrix addition
public func +(lhs: Matrix, rhs: Matrix) -> Matrix {
    if(!(rhs.rowsCount==lhs.rowsCount && rhs.columnsCount==lhs.columnsCount)){
        fatalError("Can't apply matrix addition to matrices of different size")
    }
    let res = Matrix(rhs.rowsCount,rhs.columnsCount)
    for r in 0 ..< res.rowsCount{
        for c in 0 ..< res.columnsCount{
            res[r, c] = lhs[r, c]+rhs[r, c]
        }
    }
    return res
}

//Regular matrix subtraction
public func -(lhs: Matrix, rhs: Matrix) -> Matrix {
    if(!(rhs.rowsCount==lhs.rowsCount && rhs.columnsCount==lhs.columnsCount)){
        fatalError("Can't apply matrix addition to matrices of different size")
    }
    let res = Matrix(rhs.rowsCount,rhs.columnsCount)
    for r in 0 ..< res.rowsCount{
        for c in 0 ..< res.columnsCount{
            res[r, c] = lhs[r, c]-rhs[r, c]
        }
    }
    return res
}

//Two ways to mulyiply matrix by a scalar
public func *(lhs: Double, rhs: Matrix) -> Matrix {
    let res = Matrix(rhs.rowsCount,rhs.columnsCount)
    for r in 0 ..< res.rowsCount{
        for c in 0 ..< res.columnsCount{
            res[r, c] = lhs*rhs[r, c]
        }
    }
    return res
}

public func *(lhs: Matrix, rhs: Double) -> Matrix {
    let res = Matrix(lhs.rowsCount,lhs.columnsCount)
    for r in 0 ..< res.rowsCount{
        for c in 0 ..< res.columnsCount{
            res[r, c] = rhs*lhs[r, c]
        }
    }
    return res
}

//Divide matrix
public func /(lhs: Matrix, rhs: Double) -> Matrix {
    let res = Matrix(lhs.rowsCount,lhs.columnsCount)
    for r in 0 ..< res.rowsCount{
        for c in 0 ..< res.columnsCount{
            res[r, c] = lhs[r, c]/rhs
        }
    }
    return res
}
