//
//  DirectionModalView.swift
//  Beev
//
//  Created by Michela D'Avino on 13/05/24.
//

import SwiftUI
import MapKit

struct DirectionModalView: View {
    var directions: [MKRoute.Step]

     var body: some View {
         NavigationView {
             List {
                 ForEach(directions, id: \.instructions) { step in
                     VStack(alignment: .leading) {
                         Text(step.instructions)
                             .font(.headline)
                         Text(step.notice ?? "")
                             .font(.subheadline)
                             .foregroundColor(.gray)
                     }
                     .listRowBackground(Color.clear)
                 }
             }
             .navigationBarTitle("Directions")
         }
    
     }
}

//#Preview {
//    DirectionModalView(directions: )
//}
