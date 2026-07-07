import XCTest
@testable import Doselog

@MainActor
final class DoselogTests: XCTestCase {
    func makeStore() -> Store {
        Store()
    }

    func testSeedDataLoadedOnFreshInstall() {
        let store = makeStore()
        XCTAssertFalse(store.entries.isEmpty)
    }

    func testSeedCountIsBelowFreeLimit() {
        XCTAssertLessThan(Store.seedData.count, Store.freeLimit)
    }

    func testAddEntryIncreasesCount() {
        let store = makeStore()
        let before = store.entries.count
        store.add(DoseEntry(title: "Test", stage: DoseEntry.stageOptions[0], date: Date(), note: ""))
        XCTAssertEqual(store.entries.count, before + 1)
    }

    func testCanAddMoreWhenUnderLimitAndNotPro() {
        let store = makeStore()
        store.isPro = false
        XCTAssertTrue(store.canAddMore)
    }

    func testCannotAddMoreWhenAtLimitAndNotPro() {
        let store = makeStore()
        store.isPro = false
        for i in 0..<Store.freeLimit {
            store.add(DoseEntry(title: "Item \(i)", stage: DoseEntry.stageOptions[0], date: Date(), note: ""))
        }
        XCTAssertFalse(store.canAddMore)
    }

    func testCanAddMoreWhenProRegardlessOfCount() {
        let store = makeStore()
        store.isPro = true
        for i in 0..<(Store.freeLimit + 5) {
            store.add(DoseEntry(title: "Item \(i)", stage: DoseEntry.stageOptions[0], date: Date(), note: ""))
        }
        XCTAssertTrue(store.canAddMore)
    }

    func testDeleteRemovesEntry() {
        let store = makeStore()
        let entry = DoseEntry(title: "ToDelete", stage: DoseEntry.stageOptions[0], date: Date(), note: "")
        store.add(entry)
        store.delete(id: entry.id)
        XCTAssertFalse(store.entries.contains(where: { $0.id == entry.id }))
    }

    func testUpdateEntryChangesFields() {
        let store = makeStore()
        var entry = DoseEntry(title: "Orig", stage: DoseEntry.stageOptions[0], date: Date(), note: "")
        store.add(entry)
        entry.title = "Updated"
        store.update(entry)
        XCTAssertEqual(store.entries.first(where: { $0.id == entry.id })?.title, "Updated")
    }
}
