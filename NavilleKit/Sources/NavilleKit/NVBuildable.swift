//
//  NVBuildable.swift
//  NavilleKit
//
//  Created by 박지성 on 8/10/25.
//

// MARK: - Buildable
@MainActor
public protocol NVBuildable: AnyObject {
    associatedtype Screen
    associatedtype Options: NVBuildOptions
    func build(options: Options) async throws -> Screen
}

public protocol NVBuildOptions {
    associatedtype ScreenType
    var screenType: ScreenType { get }
}
