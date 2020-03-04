//
//  PCAAlgorithm.swift
//  LinearAlgebra
//
//  Created by Nikita on 04.03.2020.
//  Copyright © 2020 Nikita Kiselov. All rights reserved.
//

import Foundation

func getPCAMatrix(_ points:[Vector], _ dim:Int)->Matrix{
    let x = Matrix(columns:  points)
    let ei = x*x.transpose
    let eigen = getEigen(ei)
    let eigval = eigen.0
    let eigvec = eigen.1
    var top:[(Double,Vector)]=[]
    for i in 0..<eigval.count{
        let val = eigval[i]
        var j=0
        while j<top.count{
            if(val>top[j].0){
                break
            }
            j+=1
        }
        if(j<dim){
            top.insert((val,eigvec[i]), at: j)
        }
        if(top.count > dim){
            top = Array(top[0..<dim])
        }
    }
    var rows:[Vector] = []
    for i in 0..<top.count{
        rows.append(top[i].1)
    }
    return Matrix(rows: rows)
}
