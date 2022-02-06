//
//  RecogTxT.swift
//  DNA8.0
//
//  Created by edX on 2022-02-05.
//

import Foundation
import Vision
import VisionKit

final class TextRecognizer{
    let Scancam: VNDocumentCameraScan
    init(Scancam:VNDocumentCameraScan) {
        self.Scancam = Scancam
    }
    private let queue = DispatchQueue(label: "scan-codes",qos: .default,attributes: [],autoreleaseFrequency: .workItem)
    func recognizeText(withCompletionHandler completionHandler:@escaping ([String])-> Void) {
        queue.async {
            let images = (0..<self.Scancam.pageCount).compactMap({
                self.Scancam.imageOfPage(at: $0).cgImage
            })
            let imagnReq = images.map({(image: $0, request:VNRecognizeTextRequest())})
            let textPerPage = imagnReq.map{image,request->String in
                let handler = VNImageRequestHandler(cgImage: image, options: [:])
                do{
                    try handler.perform([request])
                    guard let observations = request.results else{return ""}
                    return observations.compactMap({$0.topCandidates(1).first?.string}).joined(separator: "\n")
                }
                catch{
                    print(error)
                    return ""
                }
            }
            DispatchQueue.main.async {
                completionHandler(textPerPage)
            }
        }
    }
}
