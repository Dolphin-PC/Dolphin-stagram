//
//  statusView.swift
//  dolphin_stagram
//
//  Created by 박찬영 on 2020/02/09.
//  Copyright © 2020 박찬영. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct statusView : View {
    
    var url = ""
    var name = ""
    
    var body : some View{
        
        ZStack{
            
            AnimatedImage(url: URL(string: url)).resizable()
            
            VStack{
                
                HStack{
                    
                    Text(name).font(.headline).fontWeight(.heavy).padding()
                    Spacer()
                }
                Spacer()
            }
        }
        
    }
}


struct statusView_Previews: PreviewProvider {
    static var previews: some View {
        statusView()
    }
}
