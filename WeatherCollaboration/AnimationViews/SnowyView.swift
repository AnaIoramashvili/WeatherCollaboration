//
//  SnowyView.swift
//  WeatherApp
//
//  Created by Ana on 6/12/24.
//

import SwiftUI
import SpriteKit

struct SnowyView: View {
    @Environment(\.colorScheme) var colorScheme


    var body: some View {
        ZStack {

            LinearGradient(colors: [Color.snowy1, Color.snowy2], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)

            if colorScheme == .dark {
                DarkMode()
            } else {
                LightMode()
            }
        }
    }
}

struct LightMode: View {

    var body: some View {
        ZStack {
            SpriteView(scene: SnowFall(), options: [.allowsTransparency])
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

struct DarkMode: View {
    var body: some View {
        ZStack {
            SpriteView(scene: SnowFall(), options: [.allowsTransparency])
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

class SnowFall: SKScene {
    override func sceneDidLoad() {
        size = UIScreen.main.bounds.size
        scaleMode = .aspectFill

        anchorPoint = CGPoint(x: 0.5, y: 1)

        backgroundColor = .clear

        let node = SKEmitterNode(fileNamed: "snowFall.sks")!
        addChild(node)

        node.particlePositionRange.dx = UIScreen.main.bounds.width
    }
}


#Preview {
    SnowyView()
}
