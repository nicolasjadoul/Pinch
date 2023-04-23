//
//  ContentView.swift
//  Pinch
//
//  Created by Jadoul Nicolas on 22/04/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var isAnimating: Bool = false
    @State private var imageScaling: CGFloat = 1
    @State private var imageOffset: CGSize = .zero
    @State private var isDrawerOpen: Bool = false 
    let pages: [Page] = pagesdata
    @State private var pageIndex: Int = 1
    
    func resetImageState() {
        return withAnimation(.spring()) {
            imageScaling = 1
            imageOffset = .zero
        }
    }
    
    func currentPage() -> String {
        return pages[pageIndex - 1].imageName
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.clear
                Image(currentPage())
                    .resizable()
//                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0)
                    .offset(x: imageOffset.width, y: imageOffset.height)
                    .scaleEffect(imageScaling)
                    .onTapGesture(count: 2, perform: {
                        if imageScaling == 1 {
                            withAnimation(.spring()) {
                                imageScaling = 5
                            }
                        } else {
                            resetImageState()
                        }
                    })
                    .gesture(DragGesture()
                        .onChanged { value in
                            withAnimation(.linear(duration: 1)) {
                                imageOffset = value.translation
                            }
                        }
                        .onEnded {_ in
                            if imageScaling <= 1 {
                                resetImageState()
                            }
                        }
                    )
                    .gesture(
                        MagnificationGesture()
                            .onChanged {
                                value in
//                                withAnimation(.linear(duration: 1)) {
                                    if imageScaling >= 1 && imageScaling <= 5 {
                                        imageScaling = value
                                    } else if imageScaling > 5 {
                                        imageScaling = 5
                                    } else if imageScaling < 1 {
                                        imageScaling = 1
                                    }
                                
//                                }
                            }
                    )
            }
            .navigationTitle("Pinch & Zool")
            .foregroundColor(.black)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform: {
                withAnimation(.linear(duration : 1)) {
                    isAnimating = true
                }
            })
            .overlay(
                InfoPanelView(scale: imageScaling, offset: imageOffset)
            .padding(.horizontal)
            .padding(.top, 30)
                , alignment: .top)
            .overlay(
                Group {
                    HStack {
                        Button {
                            withAnimation(.spring()) {
                                if imageScaling > 1 {
                                    imageScaling -= 1
                                    
                                    if imageScaling <= 1 {
                                        resetImageState()
                                    }
                                }
                            }
                        } label: {
                            ControlImageView(icon: "minus.magnifyingglass")
                        }
                        Button {
                            resetImageState()
                        } label: {
                            ControlImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                        }
                        Button {
                            withAnimation(.spring()) {
                                if imageScaling < 5 {
                                    imageScaling += 1
                                    
                                    if imageScaling > 5 {
                                        imageScaling = 5
                                    }
                                }
                            }
                        } label: {
                            ControlImageView(icon: "plus.magnifyingglass")
                        }
                    }
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 1 : 0)
                }
                    .padding(.bottom, 30), alignment: .bottom
            )
            .overlay(
                HStack(spacing: 12) {
                    Image(systemName: isDrawerOpen ? "chevron.compact.right" : "chevron.compact.left")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 40)
                        .padding(8)
                        .foregroundStyle(.secondary)
                        .onTapGesture {
                            withAnimation(.easeOut) {
                                isDrawerOpen.toggle()
                            }
                        }
                    ForEach(pages) { page in
                        Image(page.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80)
                            .cornerRadius(8)
                            .shadow(radius: 4)
                            .onTapGesture {
                                pageIndex = page.id
                            }
                    }
                    Spacer()
                }
                    .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 1 : 0)
                    .frame(width: 260)
                    .padding(.top, UIScreen.main.bounds.height / 12)
                    .offset(x: isDrawerOpen ? 20 : 215)
                , alignment: .topTrailing
            )
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
