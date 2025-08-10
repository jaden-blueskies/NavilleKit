//
//  NVPresentable.swift
//  NavilleKit
//
//  Created by 박지성 on 8/10/25.
//

// MARK: - Presentable
public protocol NVPresentable: AnyObject {
    associatedtype Screen
    associatedtype PresentOptions: NVPresentOptions
    associatedtype PresentResult: NVPresentResult
    associatedtype DismissOptions: NVDismissOptions
    associatedtype DismissResult: NVDismissResult
    func present(screen: Screen, options: PresentOptions) async throws -> PresentResult
    func dismiss(screen: Screen, options: DismissOptions) async throws -> DismissResult
}


// MARK: - Present
public protocol NVPresentOptions {
    associatedtype PresentType
    var presentType: PresentType { get }
    var animated: Bool { get }
}

public protocol NVPresentResult {
    
}


// MARK: - Dismiss
public protocol NVDismissOptions {
    var animated: Bool { get }
}

public protocol NVDismissResult {
    
}
