//
//  CloudyView.swift
//  WeatherApp
//
//  Created by Ana on 6/12/24.
//

import SwiftUI
import SpriteKit

struct CloudyView: View {
    @Environment(\.colorScheme) var colorScheme


    var body: some View {
        ZStack {

            LinearGradient(colors: [Color.cloudy1, Color.cloudy2], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)

            if colorScheme == .dark {
                DarkMode1()
            } else {
                LightMode1()
            }
        }
    }
}

struct LightMode1: View {

    var body: some View {
        ZStack {

            SpriteView(scene: ManyClouds(), options: [.allowsTransparency])
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all)

            Image("sun")
                .resizable()
                .frame(width: 138, height: 138)
                .position(x: 80, y: 70)
        }
    }
}

struct DarkMode1: View {
    var body: some View {
        ZStack {

            SpriteView(scene: ManyClouds(), options: [.allowsTransparency])
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all)

            Image("moon")
                .resizable()
                .frame(width: 138, height: 138)
                .position(x: 80, y: 70)
        }
    }
}

class ManyClouds: SKScene {
    override func sceneDidLoad() {
        size = UIScreen.main.bounds.size
        scaleMode = .aspectFill

        anchorPoint = CGPoint(x: 0.5, y: 1)

        backgroundColor = .clear

        let node = SKEmitterNode(fileNamed: "manyClouds.sks")!
        addChild(node)


        node.particlePositionRange.dx = UIScreen.main.bounds.width
    }
}


#Preview {
    CloudyView()
}
