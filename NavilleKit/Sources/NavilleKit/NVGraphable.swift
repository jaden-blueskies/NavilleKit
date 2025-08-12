//
//  NVGraphable.swift
//  NavilleKit
//
//  Created by 60156789 on 8/12/25.
//

@MainActor
public protocol NVGraphable: AnyObject {
    associatedtype Screen
    associatedtype ScreenId
    func screen(byId screenId: ScreenId) throws -> Screen
}
