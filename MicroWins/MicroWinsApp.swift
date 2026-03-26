//
//  MicroWinsApp.swift
//  MicroWins
//
//  Author: Blen Abebe - 101213539
//  Team edits:
//Shalev Haimovitz
//Jonathan Ivanov
//Melica Alikhani-Marquet
import SwiftUI

@main
struct MicroWinsApp: App {
    @StateObject private var store = MicroWinsStore()
    @State private var showSplash = true

    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashView(showSplash: $showSplash)
                    .environmentObject(store)
            } else {
                RootTabView()
                    .environmentObject(store)
            }
        }
    }
}

