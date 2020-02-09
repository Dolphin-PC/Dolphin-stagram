//
//  statusCard.swift
//  dolphin_stagram
//
//  Created by 박찬영 on 2020/02/09.
//  Copyright © 2020 박찬영. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct StatusCard : View {
    
    var imName = ""
    var user = ""
    @Binding var show : Bool
    @Binding var user1 : String
    @Binding var url : String
    
    var body : some View{
     
            
        VStack{
            AnimatedImage(url: URL(string: imName))
                .resizable()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .onTapGesture {
                    
                    self.user1 = self.user
                    self.url = self.imName
                    self.show.toggle()
                    
            }
            
            Text(user).fontWeight(.light)
            
        }
        
    }
}

