//
//  DiagnosticsLoggerTests.swift
//  DiagnosticsTests
//

@testable import Diagnostics
import XCTest

final class DiagnosticsLoggerTests: XCTestCase {

    #if os(macOS)
    /// On unsandboxed macOS processes (including the `swift test` runner), the Application
    /// Support directory used for the log file must be scoped by the current bundle identifier
    /// so that multiple unsandboxed apps embedding this package do not collide on the same
    /// `diagnostics_log.txt` at `~/Library/Application Support/`.
    func testApplicationSupportDirectoryIsScopedByBundleIDWhenUnsandboxed() throws {
        XCTAssertFalse(FileManager.isSandboxed, "The swift test runner is expected to be unsandboxed.")

        let bundleIdentifier = try XCTUnwrap(Bundle.main.bundleIdentifier)
        let path = FileManager.default.applicationSupportDirectory.path
        XCTAssertTrue(
            path.hasSuffix("/\(bundleIdentifier)"),
            "Expected Application Support directory to end with /\(bundleIdentifier); got \(path)"
        )
    }
    #endif
}
