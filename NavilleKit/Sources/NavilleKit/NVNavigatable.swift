//
//  NVNavigatable.swift
//  NavilleKit
//
//  Created by 박지성 on 8/10/25.
//

// MARK: - Navigatable
public protocol NVNavigatable: AnyObject where
Builder.Screen == Presenter.Screen,
Builder.Screen == OpenResult.Screen,
Builder.Screen == CloseRequest.Screen,
Builder.Options == OpenRequest.BuildOptions,
Presenter.PresentOptions == OpenRequest.PresentOptions,
Presenter.PresentResult == OpenResult.PresentResult,
Presenter.DismissOptions == CloseRequest.DismissOptions,
Presenter.DismissResult == CloseResult.DismissResult
{
    associatedtype Builder: NVBuildable
    associatedtype Presenter: NVPresentable
    associatedtype OpenRequest: NVOpenRequest
    associatedtype OpenResult: NVOpenResult
    associatedtype CloseRequest: NVCloseRequest
    associatedtype CloseResult: NVCloseResult
    
    var builder: Builder { get }
    var presenter: Presenter { get }
    
    func open(request: OpenRequest) async throws -> OpenResult
    func close(request: CloseRequest) async throws -> CloseResult
}

public extension NVNavigatable {
    
    func open(request: OpenRequest) async throws -> OpenResult {
        let buildOptions = request.buildOptions
        let presentOptions = request.presentOptions
        let screen = try await self.builder.build(options: buildOptions)
        let presentResult = try await self.presenter.present(screen: screen, options: presentOptions)
        let result = OpenResult(screen: screen, presentResult: presentResult)
        return result
    }
    
    func close(request: CloseRequest) async throws -> CloseResult {
        let screen = request.screen
        let dismissOptions = request.dismissOptions
        let dismissResult = try await self.presenter.dismiss(screen: screen, options: dismissOptions)
        let result = CloseResult(dismissResult: dismissResult)
        return result
    }
    
}


// MARK: - Open
public protocol NVOpenRequest {
    associatedtype BuildOptions: NVBuildOptions
    associatedtype PresentOptions: NVPresentOptions
    var buildOptions: BuildOptions { get }
    var presentOptions: PresentOptions { get }
}

public protocol NVOpenResult {
    associatedtype Screen
    associatedtype PresentResult: NVPresentResult
    var screen: Screen { get }
    var presentResult: PresentResult { get }
    init(screen: Screen, presentResult: PresentResult)
}


// MARK: - Close
public protocol NVCloseRequest {
    associatedtype Screen
    associatedtype DismissOptions: NVDismissOptions
    var screen: Screen { get }
    var dismissOptions: DismissOptions { get }
}

public protocol NVCloseResult {
    associatedtype DismissResult: NVDismissResult
    var dismissResult: DismissResult { get }
    init(dismissResult: DismissResult)
}
