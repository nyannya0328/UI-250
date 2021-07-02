//
//  Home.swift
//  UI-250
//
//  Created by nyannyan0328 on 2021/07/02.
//

import SwiftUI

struct Home: View {
    @State var onEnd = false
    var body: some View {
        
    
        
        NavigationView{
            
            
            ZStack{
                
                
                CustomContextView {
                    Label {
                        Text("Lock me")
                    } icon: {
                        Image(systemName: "lock.fill")
                            
                    }
                    
                    .font(.title3.italic())
                    .foregroundColor(.white)
                    .padding(.vertical,10)
                    .padding(.horizontal,10)
                    .background(.purple)
                    .cornerRadius(10)

                    
                } preView: {
                    
                   Image("p1")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                    
                } actions: {
                    
                    let like = UIAction(title:"Like",image: UIImage(systemName: "suit.heart.fill")) { _ in
                        
                        
                        
                        print("Like")
                    }
                    let share = UIAction(title:"share",image: UIImage(systemName: "square.and.arrow.up.fill")) { _ in
                        
                        
                        
                        print("Like")
                    }
                    
                    
                    
                    
                    
                    return  UIMenu(title: "",children: [like,share])
                    
                } onEnd: {
                    
                    
                    withAnimation{
                        
                        
                        onEnd.toggle()
                    }
                }
                
                if onEnd{
                    
                    
                    GeometryReader{proxy in
                        
                        
                        let size = proxy.size
                        
                        
                        Image("p1")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                        
                        
                    }
                    .ignoresSafeArea(.all, edges: .bottom)
                    .transition(.slide)
                    
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            
                            
                            Button("Cancel"){
                                
                                
                                onEnd.toggle()
                            }
                        }
                    }
                    
                }
                
            }
            .navigationBarTitle(onEnd ? "Unlocked" : "Custom ContentItem")
            .navigationBarTitleDisplayMode(onEnd ? .inline : .large)
                
        }
        

    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
