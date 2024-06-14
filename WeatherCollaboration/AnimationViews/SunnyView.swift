//
//  SunnyView.swift
//  WeatherApp
//
//  Created by Ana on 6/13/24.
//

import SwiftUI
import SpriteKit

struct SunnyView: View {
    @Environment(\.colorScheme) var colorScheme

    @State private var bird1Position: CGPoint = .zero
    @State private var bird2Position: CGPoint = .zero
    @State private var bird3Position: CGPoint = .zero

    var body: some View {
        ZStack {
            LinearGradient(colors: [Color.sunny1, Color.sunny2], startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)

            if colorScheme == .dark {
                DarkMode2()
                
                
            } else {
                LightMode2()
                
                GeometryReader { geometry in
                    let width = geometry.size.width
                    let height = geometry.size.height

                    Image("bird")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .position(bird1Position)
                        .onAppear {
                            startBirdAnimation(birdIndex: 1, width: width, height: height)
                        }

                    Image("bird")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .position(bird2Position)
                        .onAppear {
                            startBirdAnimation(birdIndex: 2, width: width, height: height)
                        }

                    Image("bird")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .position(bird3Position)
                        .onAppear {
                            startBirdAnimation(birdIndex: 3, width: width, height: height)
                        }
                }

            }
        }
    }

    func startBirdAnimation(birdIndex: Int, width: CGFloat, height: CGFloat) {
        let initialX = width + 300
        let initialY = CGFloat.random(in: 50...height - 50)
        let initialPosition = CGPoint(x: initialX, y: initialY)

        let sunPosition = CGPoint(x: 80, y: 70)
        let endPosition = sunPosition

        let duration: Double = Double.random(in: 5...6)

        if birdIndex == 1 {
            bird1Position = initialPosition
            withAnimation(Animation.linear(duration: duration).repeatForever(autoreverses: false)) {
                bird1Position = endPosition
            }
        } else if birdIndex == 2 {
            bird2Position = initialPosition
            withAnimation(Animation.linear(duration: duration).repeatForever(autoreverses: false)) {
                bird2Position = endPosition
            }
        } else if birdIndex == 3 {
            bird3Position = initialPosition
            withAnimation(Animation.linear(duration: duration).repeatForever(autoreverses: false)) {
                bird3Position = endPosition
            }
        }
    }
}

struct LightMode2: View {
    var body: some View {
        ZStack {
            Image("sun")
                .resizable()
                .frame(width: 138, height: 138)
                .position(x: 80, y: 70)
        }
    }
}

struct DarkMode2: View {
    var body: some View {
        ZStack {
            
            Image("moon")
                .resizable()
                .frame(width: 138, height: 138)
                .position(x: 80, y: 70)
            
            SpriteView(scene: Stars() , options: [.allowsTransparency])
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea(.all)
        }
    }
}

class Stars: SKScene {
    override func sceneDidLoad() {
        size = UIScreen.main.bounds.size
        scaleMode = .aspectFill

        anchorPoint = CGPoint(x: 0.5, y: 1)

        backgroundColor = .clear

        let node = SKEmitterNode(fileNamed: "stars.sks")!
        addChild(node)


        node.particlePositionRange.dx = UIScreen.main.bounds.width
    }
}

#Preview {
    SunnyView()
}
