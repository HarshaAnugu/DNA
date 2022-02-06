//
//  RecogVi.swift
//  DNA8.0
//
//  Created by edX on 2022-02-05.
//

import VisionKit
import SwiftUI

struct RecogVi: UIViewControllerRepresentable {
    private let completionHandler: ([String]?) -> Void
     
    init(completion: @escaping ([String]?) -> Void) {
        self.completionHandler=completion
    }
     
    typealias UIViewControllerType=VNDocumentCameraViewController
     
    func makeUIViewController(context:UIViewControllerRepresentableContext<RecogVi>)->VNDocumentCameraViewController {
        let viewController=VNDocumentCameraViewController()
        viewController.delegate=context.coordinator
        
        return viewController
    }
    
    
     
    func updateUIViewController(_ uiViewController:VNDocumentCameraViewController, context:Context) {}
     
    func makeCoordinator()->Coordinator {
        return Coordinator(completion: completionHandler)
    }
     
    final class Coordinator:NSObject, VNDocumentCameraViewControllerDelegate {
        private let completionHandler:([String]?)->Void
         
        init(completion:@escaping ([String]?)->Void){
            self.completionHandler=completion
        }
         
        func documentCameraViewController(_ controller:VNDocumentCameraViewController, didFinishWith scan:VNDocumentCameraScan) {
            print("Document camera view controller did finish with ", scan)
            let recognizer=TextRecognizer(Scancam: scan)
            recognizer.recognizeText(withCompletionHandler: completionHandler)
        }
         
        func documentCameraViewControllerDidCancel(_ controller:VNDocumentCameraViewController) {
            completionHandler(nil)
        }
         
        func documentCameraViewController(_ controller:VNDocumentCameraViewController, didFailWithError error: Error) {
            print("Document camera view controller did finish with error ", error)
            completionHandler(nil)
        }
    }
}
