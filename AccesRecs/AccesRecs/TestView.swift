//
//  TestView.swift
//  AccesRecs
//
//  Created by Daniel Haines on 10/9/19.
//  Copyright © 2019 Daniel Haines. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

struct LargeTextTestView: View {
    @State private var textSize: Int = 6
    var body: some View {
        VStack(){
            Text("Can you easily read the text below?")
            Spacer()
            Text("This is a sentence")
                .font(Font.system(size: CGFloat(textSize)))
                .multilineTextAlignment(.center)
            
                HStack() {
                    Button(action:{self.canRead(flag: true)}) {
                        Text("Yes")
                    }
                    
                    Spacer()
                    Button(action:{self.canRead(flag: false)})
                    {
                        Text("No")
                    }
                    
                    
                }
                } .padding()
        }
    
    func canRead(flag: Bool) {
        if flag {
            
        } else {
            textSize += 2
        }
    }

}


//Find out how to pass in name of image and correct answer, then use that and a
// assets to load multiple tests in a row
struct ColorBlindTestView: View {
    @State private var guess:String = ""
    @State private var idx: Int = 0
    @State private var score: Int = 0
    @State private var image: String = Testdata[0].tests[0].imageName
    @State private var name: String = Testdata[0].tests[0].name
    @State private var correct: String = String(Testdata[0].tests[0].answer)
    @State private var id: Int = Testdata[0].tests[0].id
    @State private var finished = false

    var body: some View {
        //VStack(alignment: .center){
            VStack() {
            
            HStack(alignment: .top) {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: CGFloat(250.00), height: CGFloat(250.00), alignment: .top)
            }
//            Spacer()
//                .frame(height: 200)
            
            VStack(alignment: .center) {
                Text("Enter the number you see")
                
                TextField("", text: $guess)
                    .font(.subheadline)
                    .frame(width: 80, height: 40, alignment: .center)
                    .border(Color.gray, width: 2)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                
                if(finished) {
                    Button(action:{self.finish()}) {
                        Text("Complete Test")
                    }
                } else {
                    Button(action:{self.nextQuestion()}) {
                        Text("Next Question")
                    }
                }
                
                Spacer()
                    .frame(height: 150)
                
//                Text("Score: \(score)")
                    
                Spacer()
                .frame(height: 50)
            }
        }
    .padding()
    }
    
    func nextQuestion() {
        idx = idx + 1
        if guess == correct {
            score += 1
        }
        
        if(idx == Testdata[0].tests.count) {
            finished = true
        } else {
            name = Testdata[0].tests[idx].name
            correct = String(Testdata[0].tests[idx].answer)
            id = Testdata[0].tests[idx].id
            image = Testdata[0].tests[idx].imageName
            guess = ""
        }
    }
    
    func finish() {
        //Send to results view
    }
    
}




#if DEBUG
struct ColorBlindTestView_Preview: PreviewProvider {
    static var previews: some View {
        ColorBlindTestView() // Add something here??
    }
}
#endif

#if DEBUG
struct LargeTextTestView_Preview: PreviewProvider {
    static var previews: some View {
        LargeTextTestView() // Add something here??
    }
}
#endif


