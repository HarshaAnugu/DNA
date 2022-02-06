//
//  RegocData.swift
//  DNA8.0
//
//  Created by edX on 2022-02-05.
//

import Foundation


struct RecogData:Identifiable {
    var id=UUID()
    let content:String
    
    init(content:String) {
        self.content=content
    }
}
