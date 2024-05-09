//
//  GeneralView.swift
//  Beev
//
//  Created by Michela D'Avino on 09/05/24.
//


import SwiftUI

struct GeneralView: View {
  
    @State var fogliaSelected : Bool = true
    @State var bottigliaSelected : Bool
    @State var gocciaSelected : Bool
    
    
    var body: some View {
        
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 100){
            
                ZStack{
//                    Circle()
//                        .stroke()
//                        .foregroundColor(.green)
//                        .frame(width: 250, height: 250)
                    
                    if fogliaSelected {
                        Image("CO2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 321, height: 292)
                    } else if bottigliaSelected{
                        Image("Bottle")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 321, height: 292)
                    } else if gocciaSelected {
                        Image("Acqua")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 321, height: 292)
                    }
                    
                    Text("Number")
                        .foregroundColor(.white)
                    
                }
       
            HStack {
             
                
                    Button(action: {
                        if !fogliaSelected{
                            fogliaSelected = true
                            bottigliaSelected = false
                            gocciaSelected = false
                        }
                        
                    }) {
                        Image("Foglia")
                            .frame(width: 80, height: 64)
                            .background(Color(red: 32/255, green: 32/255, blue: 32/255))
                            .cornerRadius(13)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 13)
//                                    .stroke(Color.green, lineWidth: 1)
//                            )
                        
                    }.overlay(
                        RoundedRectangle(cornerRadius: 13)
                            .stroke(Color.green, lineWidth: fogliaSelected ? 1 : 0)
                    )
                    .padding()
                    
                    Button(action: {
                        if !bottigliaSelected{
                            bottigliaSelected = true
                            fogliaSelected = false
                            gocciaSelected = false
                        }
                        
                    }) {
                        Image("Bottiglia")
                            .frame(width: 80, height: 64)
                            .background(Color(red: 32/255, green: 32/255, blue: 32/255))
                            .cornerRadius(13)
                        
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 13)
                            .stroke(Color.yellow, lineWidth: bottigliaSelected ? 1 : 0)
                    )
                    .padding()
                    
                    Button(action: {
                        if !gocciaSelected{
                            gocciaSelected = true
                            bottigliaSelected = false
                            fogliaSelected = false
                        }
                    }) {
                        Image("Goccia")
                            .frame(width: 80, height: 64)
                            .background(Color(red: 32/255, green: 32/255, blue: 32/255))
                            .cornerRadius(13)

                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 13)
                            .stroke(Color.cyan, lineWidth: gocciaSelected ? 1 : 0)
                    )
                    .padding()
                    
                }
            }
            
        }
    }
}


#Preview {
    GeneralView(fogliaSelected: true, bottigliaSelected: false, gocciaSelected: false)
}

