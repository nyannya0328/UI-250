//
//  CustomContextView.swift
//  UI-250
//
//  Created by nyannyan0328 on 2021/07/02.
//

import SwiftUI

struct CustomContextView<Content:View,PreView:View>: View {
    var content : Content
    var preView : PreView
    
    var menu : UIMenu
    var onEnd : ()->()
    
    init(@ViewBuilder content : @escaping()->Content,@ViewBuilder preView : @escaping()->PreView,actions : @escaping()->UIMenu, onEnd : @escaping()->()){
        
        
        self.content = content()
        self.preView = preView()
        self.menu = actions()
        self.onEnd = onEnd
        
        
        
    }
    
    var body: some View{
        
        ZStack{
            
            content
                .hidden()
                .overlay( contextMenuHelper(content: content, preview: preView, actions: menu, onEnd: onEnd))
            
           
        }
    }
    
}

struct CustomContextView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct contextMenuHelper<Content:View,PreView:View> : UIViewRepresentable{
    var content : Content
    
    var preview : PreView
    var menu : UIMenu
    var onEnd : ()->()
    
    init(content : Content,preview : PreView,actions : UIMenu,onEnd : @escaping ()->()){
        
        
        
        self.content = content
        self.preview = preview
        self.menu = actions
        self.onEnd = onEnd
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) ->UIView {
        
        let view = UIView()
        view.backgroundColor = .clear
        
        let hostView = UIHostingController(rootView: content)
        
       
        
        hostView.view.translatesAutoresizingMaskIntoConstraints = false
        
        
        let contains = [

            view.topAnchor.constraint(equalTo: view.topAnchor),
            view.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: view.trailingAnchor),


            view.widthAnchor.constraint(equalTo: view.widthAnchor),
            view.heightAnchor.constraint(equalTo: view.heightAnchor),


        ]
        view.addConstraints(contains)
        view.addSubview(hostView.view)
        
       
        
        let insteraction = UIContextMenuInteraction(delegate: context.coordinator)
        
        view.addInteraction(insteraction)
        
        return view
        
        
        
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    class Coordinator : NSObject,UIContextMenuInteractionDelegate{
        
        
        
        var parent : contextMenuHelper
        init(parent : contextMenuHelper){
            self.parent = parent
            
        }
        
        func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
            
            
            return UIContextMenuConfiguration(identifier: nil) {
                
                let previewController = UIHostingController(rootView: self.parent.preview)
                
                previewController.view.backgroundColor = .clear
                
                return previewController
                
            } actionProvider: { items in
                
                
                return self.parent.menu
            }

            
            
        }
        
        func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {
            
            
            animator.addCompletion {
                
                self.parent.onEnd()
                
            }
        }
        
        
    }
    
    
    
    
    
    
    
    
}
