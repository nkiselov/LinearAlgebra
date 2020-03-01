//
//  VectorOperators.swift
//  LinearAlgebra
//
//  Created by Nikita on 28.02.2020.
//  Copyright © 2020 Nikita Kiselov. All rights reserved.
//
//  Useful vector operators in linear algebra

import Foundation

//Dot product
public func *(lhs: Vector, rhs: Vector) -> Double {
    if(!(lhs.count==rhs.count)){
        fatalError("Can't apply dot product to different sized vectors")
    }
    var product:Double = 0
    for i in 0..<lhs.count{
        product += lhs.elements[i]*rhs.elements[i]
    }
    return product
}

//Cross product
infix operator **:MultiplicationPrecedence
public func **(lhs: Vector, rhs: Vector) -> Vector {
    if(!(lhs.count==3 && rhs.count==3)){
        fatalError("Can't apply cross product to not 3 sized vectors")
    }
    return Vector([
        lhs[1]*rhs[2]-lhs[2]*rhs[1],
        lhs[2]*rhs[0]-lhs[0]*rhs[2],
        lhs[0]*rhs[1]-lhs[1]*rhs[0]
    ])
}

public func +(lhs: Vector, rhs:Vector)->Vector{
    if(!(lhs.count==rhs.count)){
        fatalError("Can't add different sized vectors")
    }
    let res = Vector(lhs.count)
    for i in 0..<lhs.count{
        res[i] = lhs[i]+rhs[i]
    }
    return res
}

public func -(lhs: Vector, rhs:Vector)->Vector{
    if(!(lhs.count==rhs.count)){
        fatalError("Can't subtract different sized vectors")
    }
    let res = Vector(lhs.count)
    for i in 0..<lhs.count{
        res[i] = lhs[i]-rhs[i]
    }
    return res
}

public func *(lhs: Vector, rhs: Double) -> Vector {
    let product:Vector = Vector(lhs.count)
    for i in 0..<lhs.count{
        product[i] = lhs[i]*rhs
    }
    return product
}

public func *(lhs: Double, rhs: Vector) -> Vector {
    let product:Vector = Vector(rhs.count)
    for i in 0..<rhs.count{
        product[i] = rhs[i]*lhs
    }
    return product
}

public func /(lhs: Vector, rhs: Double) -> Vector {
    let product:Vector = Vector(lhs.count)
    for i in 0..<lhs.count{
        product[i] = lhs[i]/rhs
    }
    return product
}
