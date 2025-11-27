//
//  ContentView.swift
//  Atlys
//
//  Created by Shalini Goyal on 27/11/25.
//

import SwiftUI

let kDeviceWidth = UIScreen.main.bounds.size.width
let kDeviceHeight = UIScreen.main.bounds.size.height

struct OnboardingPageView: View {
    let images: [String] = ["image1", "image2", "image3", "S1", "S2", "S3"]
    @State private var currentIndex: Int = 0
    @GestureState private var dragOffset: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 36) {
            ZStack {
                ForEach(images.indices, id: \.self) { index in
                    Image(images[index])
                        .resizable()
                        .scaledToFill()
                        .frame(width: kDeviceWidth * 0.6, height: kDeviceWidth * 0.6)
                        .cornerRadius(20)
                        .clipped()
                        .scaleEffect(scale(for: index))
                        .offset(x: offset(for: index))
                        .zIndex(index == currentIndex ? 1 : 0)
                        .animation(.easeInOut(duration: 0.25), value: currentIndex)
                }
            }
            .frame(height: kDeviceWidth * 0.6 + 20)
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        state = value.translation.width
                    }
                    .onEnded { value in
                        let threshold: CGFloat = kDeviceWidth * 0.3
                        if value.translation.width < -threshold {
                            currentIndex = min(currentIndex + 1, images.count - 1)
                        } else if value.translation.width > threshold {
                            currentIndex = max(currentIndex - 1, 0)
                        }
                    }
            )
            HStack(spacing: 8) {
                ForEach(images.indices, id: \.self) { index in
                    let dotSize = index == currentIndex ? 8.0 : 6.0
                    Circle()
                        .frame(width:dotSize, height: dotSize)
                        .foregroundColor(index == currentIndex ? .gray: .gray.opacity(0.4))
                }
            }
        }
        .onAppear {
            if images.count > 1 {
                currentIndex = 1
            }
        }
    }
    
    func offset(for index: Int) -> CGFloat {
        let diff = CGFloat(index - currentIndex)
        let backSpacing = 24.0
        return diff * (kDeviceWidth * 0.6 - backSpacing) + dragOffset
    }

    func scale(for index: Int) -> CGFloat {
        let dragAmount = min(1, abs(dragOffset) / 100)
        let isCenter = (index == currentIndex)
        let maxCardScale = isCenter ? 1.2 : 0.9
        let minCardScale = 0.9
        return maxCardScale - (maxCardScale - minCardScale) * dragAmount
    }
}

#Preview {
    OnboardingPageView()
}
