//
//  EigenAlgorithms.swift
//  LinearAlgebra
//
//  Created by Nikita on 28.02.2020.
//  Copyright © 2020 Nikita Kiselov. All rights reserved.
//

import Foundation

private let epsilon = 0.0000000001

//func getEigen2(_ m:Matrix)->Double{
//    if(m.rowsCount != m.columnsCount){
//        fatalError("Can't compute eigenvalues of non square matrix")
//    }
//    var a = m.copy()
//    for e in 0..<a.rowsCount{
//        var bnorm:Double=0
//        var brow=0
//        let rows = a.rows()
//        for i in 0..<rows.count{
//            let norm = rows[i].norm
//            if(norm>bnorm){
//                brow=i
//                bnorm=norm
//            }
//        }
//        var vec = rows[brow]
//        while(true){
//            var nextVec = a*vec
//            nextVec=nextVec/nextVec.norm
//            if((abs(nextVec)-abs(vec)).norm<epsilon){
//                    break
//            }
//            vec=nextVec
//        }
//        let eig = (a*vec)*vec
//        print(vec)
//        print(eig)
//        a=a-eig*vec.mat*vec.mat.transpose
//    }
//    return 2
//}

//Find eigenvalues using QR algorithm
func getEigen(_ a:Matrix)->([Double],[Vector]){
    if(a.rowsCount != a.columnsCount){
        fatalError("Can't compute eigenvalues of non square matrix")
    }
    let count = a.rowsCount
    var iter = a.copy()
    var i=0
    while true{
        //let mu = wilkinsonShift(a:iter[count-2,count-2],b:iter[count-1,count-1],c:iter[count-2,count-1])
        //let shift = Matrix.identity(count)*mu
        let qr = QRDecomposition(iter)
        i+=1
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
    var eigenvalueRepeats:[(Double,Int)]=[]
    for i in 0..<eigenvalues.count{
        let eig = eigenvalues[i]
        var new = true
        for j in 0..<eigenvalueRepeats.count{
            if(abs(eigenvalueRepeats[j].0-eig)<100*epsilon){
                eigenvalueRepeats[j].1+=1
                new = false
                break
            }
        }
        if(new){
            eigenvalueRepeats.append((eig,1))
        }
    }
    var eigenvectors:[Vector]=[]
    for i in 0..<eigenvalueRepeats.count{
        let c = eigenvalueRepeats[i].1
        let m = a-Matrix.identity(a.rowsCount)*eigenvalueRepeats[i].0
        let q = QRDecomposition(m.transpose).q
        let cols = q.cols()
        eigenvectors.append(contentsOf: cols[(cols.count-c)..<cols.count])
    }
    return (eigenvalues,eigenvectors)
}

func wilkinsonShift(a:Double,b:Double,c:Double)->Double{
    let d = (a-c)/2
    let b2 = b*b
    let div = abs(d)+sqrt(d*d+b2)
    return c-sign(d)*b2/div
}
