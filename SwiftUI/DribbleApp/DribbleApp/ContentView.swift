//
//  ContentView.swift
//  DribbleApp
//
//  Created by Alp Ceylan on 3.11.2020.
//

import SwiftUI

struct ContentView: View {
    let deviceHeight = UIScreen.main.bounds.height
    let deviceWidth = UIScreen.main.bounds.width
    
    var body: some View {
        VStack {
            HeaderTwo(deviceHeight: deviceHeight, deviceWidth: deviceWidth)
            SearchTwo(deviceHeight: deviceHeight, deviceWidth: deviceWidth)
            ButtonsTwo(deviceHeight: deviceHeight, deviceWidth: deviceWidth)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct HeaderTwo: View {
    var deviceHeight: CGFloat
    var deviceWidth: CGFloat
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Good Morning,")
                    .font(.system(size: 19, weight: .medium, design: .serif))
                    .foregroundColor(Color(#colorLiteral(red: 0.9473686937, green: 0.4907266039, blue: 0.6672841515, alpha: 1)))
                Text("Shaileen!")
                    .font(.system(size: 28, weight: .medium, design: .serif))
                    .foregroundColor(Color(#colorLiteral(red: 0.9473686937, green: 0.4907266039, blue: 0.6672841515, alpha: 1)))
                    .padding(.top, deviceHeight * 0.002)
            }
            Spacer()
            Image("Aj")
                .resizable()
                .frame(width: deviceWidth * 0.13, height: deviceWidth * 0.13)
        }.padding(.horizontal, deviceWidth * 0.1)
    }
}

struct SearchTwo: View {
    var deviceHeight: CGFloat
    var deviceWidth: CGFloat
    
    var body: some View {
        HStack {
            Text("Search for 3D Products!")
                .foregroundColor(.gray)
                .font(.system(size: 15))
                .padding(.leading, deviceWidth * 0.1)
            Spacer()
            Image(systemName: "magnifyingglass")
                .font(.system(size: 26, weight: .medium, design: .serif))
                .foregroundColor(Color(#colorLiteral(red: 0.9473686937, green: 0.4907266039, blue: 0.6672841515, alpha: 1)))
                .padding(.trailing, deviceWidth * 0.07)
        }.frame(width: deviceWidth * 0.8, height: deviceHeight * 0.06)
        .background(Color.white)
        .cornerRadius(14)
    }
}

struct ButtonsTwo: View {
    var deviceHeight: CGFloat
    var deviceWidth: CGFloat
    
    var body: some View {
        HStack(spacing: deviceWidth * 0.11) {
            VStack {
                VStack {
                    Image(systemName: "clock")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                }.frame(width: deviceWidth * 0.12, height: deviceWidth * 0.12)
                .background(Color(#colorLiteral(red: 0.9473686937, green: 0.4907266039, blue: 0.6672841515, alpha: 1)))
                .cornerRadius(10)
                Text("Recent")
                    .font(.system(size: 12, weight: .bold, design: .serif))
                    .foregroundColor(Color(#colorLiteral(red: 0.9473686937, green: 0.4907266039, blue: 0.6672841515, alpha: 1)))
                    .padding(.top, deviceHeight * 0.003)
            }
            VStack {
                VStack {
                    Image(systemName: "clock")
                        .font(.system(size: 24))
                        .foregroundColor(.gray)
                }.frame(width: deviceWidth * 0.12, height: deviceWidth * 0.12)
                .background(Color.white)
                .cornerRadius(10)
                Text("Trending")
                    .font(.system(size: 12, weight: .bold, design: .serif))
                    .foregroundColor(.gray)
                    .padding(.top, deviceHeight * 0.003)
            }
            VStack {
                VStack {
                    Image(systemName: "crown")
                        .font(.system(size: 24))
                        .foregroundColor(.gray)
                }.frame(width: deviceWidth * 0.12, height: deviceWidth * 0.12)
                .background(Color.white)
                .cornerRadius(10)
                Text("Popular")
                    .font(.system(size: 12, weight: .bold, design: .serif))
                    .foregroundColor(.gray)
                    .padding(.top, deviceHeight * 0.003)
            }
            VStack {
                VStack {
                    Image(systemName: "diamond")
                        .font(.system(size: 24))
                        .foregroundColor(.gray)
                }.frame(width: deviceWidth * 0.12, height: deviceWidth * 0.12)
                .background(Color.white)
                .cornerRadius(10)
                Text("Trending")
                    .font(.system(size: 12, weight: .bold, design: .serif))
                    .foregroundColor(.gray)
                    .padding(.top, deviceHeight * 0.003)
            }
        }
    }
}
