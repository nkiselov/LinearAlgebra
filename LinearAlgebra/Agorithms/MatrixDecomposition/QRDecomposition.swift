//
//  QRDecomposition.swift
//  LinearAlgebra
//
//  Created by Nikita on 28.02.2020.
//  Copyright © 2020 Nikita Kiselov. All rights reserved.
//

import Foundation

public class QRDecomposition:MatrixDecomposition{
    
    public var q:Matrix
    public var r:Matrix
    
    public required init(_ a: Matrix) {
//        let si = a.count
//        let q = Matrix.identity(si.0)
//        let r = a.copy()
//
//        //Use Householder transformations to get qr decomposition
//        for j in 0..<si.1{
//            let normx = r[j..<si.0,j].norm
//            let s = -sign(r[j,j])
//            let u1 = r[j,j] - s*normx
//            let w = r[j..<si.0,j].cols()[0]/u1
//            w[0] = 1
//            let tau = -s*u1/normx
//
//            let m = w.mat.transpose*r[j..<si.0,0..<si.1]
//            r[j..<si.0,0..<si.1] = r[j..<si.0,0..<si.1] - (tau*w).mat*m
//            q[0..<si.0,j..<si.1] = q[0..<si.0,j..<si.1] - (q[0..<si.0,j..<si.1]*w).mat*(tau*w).mat.transpose
//        }
//        self.q=q
//        self.r=r
        let aColumns = a.cols()
        let qColumns = gramSchmidt(aColumns)
        let r = Matrix(qColumns.count, a.columnsCount)
        for j in 0..<r.columnsCount{
            for i in 0..<j+1{
                r[i,j] = aColumns[j]*qColumns[i]
            }
        }
        q=Matrix(columns: qColumns)
        self.r=r
    }
}
