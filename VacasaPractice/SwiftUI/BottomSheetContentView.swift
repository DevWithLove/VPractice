//
//  BottomSheetContentView.swift
//  VacasaPractice
//
//  Created by Tony Mu on 3/02/22.
//

import SwiftUI

struct BottomSheetContentView: View {
    @Binding var show: Bool
    
    var body: some View {
        ZStack {
            Button {
                withAnimation {
                    show.toggle()
                }
            } label: {
                Image(systemName: "xmark")
                    .font(.body.bold())
                    .foregroundColor(.white)
                    .padding(9)
                    .background(Color(uiColor: .systemRed))
                    .mask(Circle())
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
            .padding(10)
            
            VStack {
                RoundedRectangle(cornerRadius: 3, style: .continuous)
                    .frame(width: 40, height: 5)
                    .padding(8)
                
                HStack(spacing: 16) {
                    Text("Cards").font(.largeTitle).bold()
                    Button {
                        
                    } label: {
                        Label("Add", systemImage: "plus.circle.fill")
                            .font(.body.bold())
                            .foregroundColor(.white)
                            .padding(8)
                            .padding(.horizontal, 8)
                    }
                    .background(Color(UIColor(.accentColor)))
                    .cornerRadius(30)
                    
                    Spacer()
                }
                .padding(24)
                
                Spacer()
            }
        }
        
        
    }
}

struct BottomSheetContentView_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetContentView(show: .constant(true))
    }
}
