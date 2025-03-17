import XCTest

final class CarMaxUITests: XCTestCase {

    override func setUpWithError() throws {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        UserDefaults.standard.synchronize()

        // test for failure
        continueAfterFailure = false

        // set initial state orientation
        let app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
       // add teardown code
    }

    func testExample() throws {
        let app = XCUIApplication()
        
        // Verify element exists
        let searchField = app.textFields["SearchField"]
        XCTAssertTrue(searchField.exists, "Search field should exist")

        // Interact with element
        searchField.tap()
        searchField.typeText("CarMax Test")

        // Submit search
        app.buttons["SearchButton"].tap()

        // Verify that a result appears
        let resultLabel = app.staticTexts["ResultLabel"]
        XCTAssertTrue(resultLabel.exists, "Result label should exist")
    }

    func testNavigation() throws {
        let app = XCUIApplication()
        
        // Navigate to different screen
        app.buttons["GoToDetailsButton"].tap()

        // Verify new screen is displayed
        let detailView = app.otherElements["DetailView"]
        XCTAssertTrue(detailView.exists, "Detail view should be visible")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
