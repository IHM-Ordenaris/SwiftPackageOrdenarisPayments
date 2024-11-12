import XCTest
@testable import OrdenarisPaymentsSPM

final class OrdenarisPaymentsSPMTests: XCTestCase {
    func testExample() throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
    }
    
    func testHello() throws {
        let package = OrdenarisPaymentsExample()
        XCTAssertEqual(package.hello(), "Hello, Swift Package!")
    }
}
