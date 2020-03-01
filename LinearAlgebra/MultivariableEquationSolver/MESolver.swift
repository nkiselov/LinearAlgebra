//
//  MESolver.swift
//  LinearAlgebra
//
//  Created by Nikita on 21.01.2020.
//  Copyright © 2020 Nikita Kiselov. All rights reserved.
//
//  Multivariate solver using Newton-Raphson model (even though this is not linear algebra, it is a very useful tool
import Foundation

class MESolver {
    static let epsilon = 0.00000001

    public static func solve(mEquation:MEquation, start:Vector)->Vector{
        var pos = start.copy()
        while(true){
            let value = mEquation.evaluate(pos)
            var columns = Array(repeating: Vector(mEquation.outAmount),count: mEquation.inAmount)
            for i in 0..<mEquation.inAmount{
                let step = Vector(mEquation.inAmount)
                step[i] = epsilon
                columns[i] = (mEquation.evaluate(pos+step)-value)/epsilon
            }
            let derivative = Matrix(columns: columns)
            let netChange = derivative.rightInverse*value
            pos=pos-netChange
            if(netChange.sqrNorm<epsilon){
                break
            }
        }
        return pos
    }
}
