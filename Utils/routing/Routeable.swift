//
//  Routeable.swift
//  FinalTestApp
//
//  Created by Toby Youngberg on 10/16/19.
//  Copyright © 2019 Toby Youngberg. All rights reserved.
//

import Foundation

protocol Route {
    static func routeForPathComponents(pathComponents: [String]) -> Self?
}

protocol Routable {
    associatedtype RouteType: Route
    func routeTo(route: RouteType)
}
