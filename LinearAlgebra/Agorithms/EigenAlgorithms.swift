//
//  EigenAlgorithms.swift
//  LinearAlgebra
//
//  Created by Nikita on 28.02.2020.
//  Copyright © 2020 Nikita Kiselov. All rights reserved.
//

import Foundation

private let epsilon = 0.0000000001
//Find eigenvalues using QR algorithm
func getEigen(_ a:Matrix)->[Double]{
    if(a.rowsCount != a.columnsCount){
        fatalError("Can't compute eigenvalues of non square matrix")
    }
    let count = a.rowsCount
    var iter = a
    while true{
        let qr = QRDecomposition(iter)
        iter=qr.r*qr.q
        var sum:Double = 0
        for i in 0..<count{
            for j in 0..<i{
                sum+=abs(iter[i,j])
            }
        }
        if(sum<epsilon){
            break
        }
    }
    var eigenvalues:[Double] = []
    for i in 0..<iter.columnsCount{
        eigenvalues.append(iter[i,i])
    }
    return eigenvalues
}
