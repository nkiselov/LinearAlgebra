//
//  AlgebraicAlgorithms.swift
//  LinearAlgebra
//
//  Created by Nikita on 28.02.2020.
//  Copyright © 2020 Nikita Kiselov. All rights reserved.
//

import Foundation

func abs(_ a:Matrix)->Matrix{
    let res = a.copy()
    for r in 0..<res.rowsCount{
        for c in 0..<res.rowsCount{
            res[r, c] = abs(res[r, c])
        }
    }
    return res
}

func abs(_ v:Vector)->Vector{
    let res = v.copy()
    for i in 0..<v.count{
        res[i]=abs(v[i])
    }
    return res
}

func sign(_ d:Double)->Double{
    if(d>0){
        return 1
    }else if(d<0){
        return -1
    }else{
        return 0
    }
}

func hessenberg(_ a:Matrix)->Matrix{
    if(a.rowsCount != a.columnsCount){
        fatalError("Can not apply hesenberg reduction to non square matrix")
    }
    let h = a.copy()
    let c = h.rowsCount
    if(a.rowsCount>2){
        let a1 = h[1..<c,0].cols()[0]
        let e1 = Vector(c-1)
        e1[0]=1
        let sgn = sign(a1[0])
        var v = (a1+sgn*a1.norm*e1).mat
        v=v/v.norm
        let q1 = Matrix.identity(c-1)-2*(v*v.transpose)
        h[1..<c,0]=q1*h[1..<c,0]
        h[0,1..<c]=h[0,1..<c]*q1
        h[1..<c,1..<c]=hessenberg(q1*h[1..<c,1..<c]*q1.transpose)
    }
    return h
}
