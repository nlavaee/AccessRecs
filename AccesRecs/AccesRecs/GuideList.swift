//
//  GuideList.swift
//  AccesRecs
//
//  Created by Norin Lavaee on 10/9/19.
//  Copyright © 2019 Norin Lavaee. All rights reserved.
//

// creating the whole list of the Guide



import SwiftUI
import UIKit
import Foundation


struct ModalDismiss : View {
    @Binding var showingModal:Bool

    var body: some View {
        Button(action: {
            self.showingModal = false
        }) {
            Text("Dismiss").frame(height: 60)
        }
    }
}


struct GuideList: View {
    
    
    @State private var searchTerm: String = ""
    @State var showingModal = false
    var categoryType: String  // default Motion = false, Vision = true
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
//    init() {
//       UITableView.appearance().tableFooterView = UIView()
//    }
//
//    init() {
//        // To remove only extra separators below the list:
//        UITableView.appearance().tableFooterView = UIView()
//
//        // To remove all separators including the actual ones:
//        UITableView.appearance().separatorStyle = .none
//    }
    var body: some View {
        
        VStack(){
        
        NavigationView {
            Group{
                
                //VStack(){
                    Text("")
                    .font(.title)
                //}
                
               //VStack() {
                    SearchBar(text: $searchTerm)
               // }
                //VStack(){
                List(Guidedata.filter { i in
                    if(!self.searchTerm.isEmpty){
                        if(i.name.localizedCaseInsensitiveContains(self.searchTerm)){
                            return true
                        }
                    }
                    else {
                         return true
                    }
                    return false
                }) { guide in
                    
                    if(guide.category == self.categoryType){
                        
                        NavigationLink(destination: DropDown(guide: guide)) {
                            
                                GuideRow(guide: guide)
                            
                                Spacer()
//                            Divider()
                                    
                        }
                    }
                    
                }
              //}
            }
                .navigationBarTitle(Text("Guide"), displayMode: .inline)
                .navigationBarBackButtonHidden(true)
                .navigationBarItems(leading: Button("") {
                    print("tapped")
                    
                })

            //}
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
                    
                }) {
                Text(String("Dismiss")).font(.headline)
                .minimumScaleFactor(0.01)
                .lineLimit(nil)
                .padding()
            }
        }
      }

    }

}
//struct ModalView: View {
//
//  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//
//  var body: some View {
//    Group {
//      Text("Modal view")
//      Button(action: {
//         self.presentationMode.wrappedValue.dismiss()
//      }) {
//        Text("Dismiss")
//      }
//    }
//  }
//}


//struct GuideList_Previews: PreviewProvider {
//    static var previews: some View {
//        GuideList()
//    }
//}
