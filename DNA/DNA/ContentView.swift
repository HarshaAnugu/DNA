//
//  ContentView.swift
//  DNA8.0
//
//  Created by edX on 2022-02-05.
//

import SwiftUI

struct ContentView:View {
    @State private var Recogsh=false
    @State private var texts:[RecogData]=[]
    var body:some View {
        NavigationView{
            VStack(alignment:.trailing){
                if texts.count > 0{
                    List{
                        ForEach(texts){text in
                            NavigationLink(
                                destination:ScrollView{Text(text.content)},
                                label:{
                                    Text(text.content).lineLimit(1)
                        })
                            
                        }
                    }
                }
                else{
                    Text("Please scan your diagnosis report using the button on the top right corner of the screen").font(.headline)
                }
            }
                .navigationTitle("Your Info")
                .navigationBarItems(trailing:Button(action:{self.Recogsh=true},
                label: {Image(systemName: "doc.viewfinder").font(.title)})
                .sheet(isPresented: $Recogsh, content: {
                    self.makeScannerView()
                    
                })
                )
        }
        
    }
   private func makeScannerView()->RecogVi{
        RecogVi(completion: {
            textPerPage in
            if let outputText = textPerPage?.joined(separator:"\n").trimmingCharacters(in: .whitespacesAndNewlines){
                let newScanData=RecogData(content:outputText)
                self.texts.append(newScanData)
            }
            self.Recogsh=false
        })
   
            }

   }
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


