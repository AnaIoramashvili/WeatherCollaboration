//
//  RainyView.swift
//  WeatherApp
//
//  Created by Ana on 6/12/24.
//

import SwiftUI
import SpriteKit

struct RainyView: View {
    @Environment(\.colorScheme) var colorScheme


    var body: some View {
        ZStack {

            LinearGradient(colors: [Color.rainy1, Color.rainy2], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)

            if colorScheme == .dark {
                DarkModeAnimation()
            } else {
                LightModeAnimation()
            }
        }
    }
}

struct LightModeAnimation: View {

    var body: some View {
        ZStack {
            SpriteView(scene: RainFall(), options: [.allowsTransparency])
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all)

            SpriteView(scene: Cloud(), options: [.allowsTransparency])
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all)

            Image("sun")
                .resizable()
                .frame(width: 138, height: 138)
                .position(x: 80, y: 70)
        }
    }
}

struct DarkModeAnimation: View {
    var body: some View {
        ZStack {
            SpriteView(scene: RainFall(), options: [.allowsTransparency])
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all)

            SpriteView(scene: Cloud(), options: [.allowsTransparency])
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all)

            Image("moon")
                .resizable()
                .frame(width: 138, height: 138)
                .position(x: 80, y: 70)
        }
    }
}


class RainFall: SKScene {
    override func sceneDidLoad() {
        size = UIScreen.main.bounds.size
        scaleMode = .aspectFill

        anchorPoint = CGPoint(x: 0.5, y: 1)

        backgroundColor = .clear

        let node = SKEmitterNode(fileNamed: "rainFall.sks")!
        addChild(node)


        node.particlePositionRange.dx = UIScreen.main.bounds.width
    }
}

class Cloud: SKScene {
    override func sceneDidLoad() {
        size = UIScreen.main.bounds.size
        scaleMode = .aspectFill

        anchorPoint = CGPoint(x: 0, y: 0.8)

        backgroundColor = .clear

        let node = SKEmitterNode(fileNamed: "clouds.sks")!
        
        addChild(node)
    }
}



#Preview {
    RainyView()
}


