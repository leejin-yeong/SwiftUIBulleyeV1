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
        Int(sliderValue.rounded())
    }
    
    var sliderTargetDifference: Int{
        abs(sliderValueRounded - target)
    }
    //User interface conent and layout
    var body: some View {
        VStack{
            Spacer()
            //Target row
            HStack{
                Text("Put the bullseye as close as you can to:")
              //  Text("100")
                Text("\(target)")
            }
            Spacer()
            //Slider row
            //Todo: Add views for the slider row here.
            HStack{
                Text("1")
                Slider(value: $sliderValue, in: 1...100)
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
            .alert(isPresented: $alertIsVisible){
                Alert(title: Text(alertTitle()),
                      message: Text(scoringMessage()),
                      dismissButton: .default(Text("Awesome!")){
                        self.startNewRound()
                })
            }//End of .alert
            Spacer()
            //Score row
            //Todo: Add view for the score, rounds, and start and info buttons here.
            HStack{
                Button(action: {
                    self.startNewGame()
                    
                }){
                    Text("Start over")
                }
                Spacer()
                Text("Score:")
               // Text("999999")
                Text("\(score)")
                Spacer()
                Text("Round:")
                Text("\(round)")
                Spacer()
                Button(action:{}){
                    Text("Inform")
                }
            }.padding(.bottom, 20)
        }//End of VStack
        .onAppear(){
            self.startNewGame()}
    }//End of body
    //Methods
    //=====
    func pointsForCurrentRound()->Int{
        
        let maximumScore = 100
       // let difference = abs(self.sliderValueRounded - self.target)
        
        let points: Int
        if sliderTargetDifference == 0 {
            points = 200
        }else if sliderTargetDifference == 1{
            points = 150
        }else {
            points = maximumScore - sliderTargetDifference }
        
            return points
    }
    
    func scoringMessage() -> String{
        return "The slider's value is \(sliderValueRounded).\n" +
        "The target value is \(target).\n" +
        "You scored \(pointsForCurrentRound()) points this round."
    }
    
    func alertTitle()->String{
        let difference: Int = abs(self.sliderValueRounded - self.target)
        let title: String
        if difference == 0 {
            title = "Perfect!"
        }else if sliderTargetDifference < 5 {
            title = "You almost had it!"
        }else if sliderTargetDifference <= 10{
            title = "Not bad." } else {
            title = "Are you even trying?"
        }
        return title
    }
    
    func startNewGame(){
        score = 0
        round = 1
        resetSliderAndTarget()
    }
    
    func startNewRound(){
        score = score + pointsForCurrentRound()
        round += 1
        resetSliderAndTarget()
    }
    
    func resetSliderAndTarget(){
        sliderValue = Double.random(in: 1...100)
        target = Int.random(in: 1...100)
    }
}//End of struct

//Preview
//======
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
