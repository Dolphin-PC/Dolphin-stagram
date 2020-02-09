//
//  postCard.swift
//  dolphin_stagram
//
//  Created by 박찬영 on 2020/02/09.
//  Copyright © 2020 박찬영. All rights reserved.
//


import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct postCard : View {
    
    var user = ""
    var image = ""
    var id = ""
    var likes = ""
    var comments = ""
    
    var body : some View{
        
        VStack(alignment: .leading, content: {
 
            HStack{
                
                AnimatedImage(url: URL(string: image)).resizable().frame(width: 30, height: 30).clipShape(Circle())
                Text(user)
                Spacer()
                Button(action: {
                    
                }) {
                    
                    Image("menu").resizable().frame(width: 15, height: 15)
                }.foregroundColor(Color("darkAndWhite"))
            }
            
            AnimatedImage(url: URL(string: image)).resizable().frame(height: 350)
            
            HStack{
                
                Button(action: {
                    
                }) {
                    
                    Image("comment").resizable().frame(width: 26, height: 26)
                }.foregroundColor(Color("darkAndWhite"))
                
                Button(action: {
                    
                    // update likes...
                    
                    let db = Firestore.firestore()
                   
                    let like = Int.init(self.likes)!
                    db.collection("posts").document(self.id).updateData(["likes": "\(like + 1)"]) { (err) in
                        
                        if err != nil{
                            
                            print((err))
                            return
                        }
                        
                        print("updated....")
                    }
                    
                }) {
                    
                    Image("heart").resizable().frame(width: 26, height: 26)
                }.foregroundColor(Color("darkAndWhite"))
                
                Spacer()
                
                Button(action: {
                    
                }) {
                    
                    Image("saved").resizable().frame(width: 30, height: 30)
                }.foregroundColor(Color("darkAndWhite"))
                
            }.padding(.top, 8)
            
            
            Text("\(likes) Likes").padding(.top, 8)
            Text("View all \(comments) Comments")
            
         }).padding(8)
    }
}


struct postCard_Previews: PreviewProvider {
    static var previews: some View {
        postCard()
    }
}
