//
//  ProgramRoute.swift
//  ChannelViewer
//
//  Created by subhajit halder on 09/05/23.
//

import Foundation

protocol ProgramRoute {
    func openProgram()
}

extension ProgramRoute where Self: Router {
    func openProgram() {}
}
