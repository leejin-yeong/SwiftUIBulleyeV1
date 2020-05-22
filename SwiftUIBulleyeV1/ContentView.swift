//
//  ContentView.swift
//  SwiftUIBulleyeV1
//
//  Created by Release on 2020/05/13.
//  Copyright © 2020 Jinyoung Lee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    //Properties
    //=======
    
    //state for User interface views
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 1
    var sliderValueRounded: Int{
        Int(self.sliderValue.rounded())
    }
    //User interface conent and layout
    var body: some View {
        VStack{
            Spacer()
            //Target row
            HStack{
                Text("Put the bullseye as close as you can to:")
              //  Text("100")
                Text("\(self.target)")
            }
            Spacer()
            //Slider row
            //Todo: Add views for the slider row here.
            HStack{
                Text("1")
                Slider(value: self.$sliderValue, in: 1...100)
                Text("100")
            }
            Spacer()
            //Button row
            Button(action: {
               // print("Button pressed!")
                print("Points awarded: \(self.pointsForCurrentRound())")
                self.alertIsVisible = true

            }) {
                Text(/*@START_MENU_TOKEN@*/"Hit me!"/*@END_MENU_TOKEN@*/)
            }
            //State for alert
            .alert(isPresented: self.$alertIsVisible){
                Alert(title: Text("Hello there!"),
                      message: Text(self.scoringMessage()),
                      dismissButton: .default(Text("Awesome!")){
                        self.score = self.score + self.pointsForCurrentRound()
                        self.target = Int.random(in: 1...100)
                        self.round += 1
                })
            }//End of .alert
            Spacer()
            //Score row
            //Todo: Add view for the score, rounds, and start and info buttons here.
            HStack{
                Button(action:{}){
                    Text("Start over")
                }
                Spacer()
                Text("Score:")
               // Text("999999")
                Text("\(self.score)")
                Spacer()
                Text("Round:")
                Text("\(self.round)")
                Spacer()
                Button(action:{}){
                    Text("Inform")
                }
            }.padding(.bottom, 20)
        }//End of VStack
    }//End of body
    //Methods
    //=====
    func pointsForCurrentRound()->Int{
        
        let maximumScore = 100
        let difference = abs(self.sliderValueRounded - self.target)
        return maximumScore - difference
    }
    
    func scoringMessage()->String{
        return "The slider's value is \(self.sliderValueRounded)\n" +
            "The target value is \(self.target).\n" +
        "You scored \(self.pointsForCurrentRound()) points this round"
    }
}//End of struct

//Preview
//======
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
