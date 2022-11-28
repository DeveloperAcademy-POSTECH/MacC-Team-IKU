//
//  PersistenceManagerTest.swift
//  PersistenceTest
//
//  Created by Shin Jae Ung on 2022/11/21.
//

import XCTest

final class PersistenceManagerTest: XCTestCase {
    var persistenceManager: PersistenceManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        self.persistenceManager = try PersistenceManager()
    }

    override func tearDownWithError() throws {
        let dbURL: URL = try documentFolderURL()
        persistenceManager = nil
        for item in try allFileNamesInDocumentDirectory() {
            try FileManager.default.removeItem(at: dbURL.appendingPathComponent(item))
        }
        try super.tearDownWithError()
    }

    func test_save_video_without_prefixed_values() throws {
        try persistenceManager.save(
            videoURL: try exampleFileURLWithCreatingFile(),
            withARKitResult: [:],
            isLeftEye: true,
            uncoveredPhotoTime: 0,
            coveredPhotoTime: 1.2
        )
    }
    
    func test_save_video_with_all_values() throws {
        try persistenceManager.save(
            videoURL: try exampleFileURLWithCreatingFile(),
            withARKitResult: [:],
            isLeftEye: true,
            uncoveredPhotoTime: 0,
            coveredPhotoTime: 1.2,
            creationDate: Date.now,
            isBookMarked: false
        )
    }
    
    func test_fetch_all_video() throws {
        let currentDate = "2022-11-22 00:12:34".toDate()!
        try persistenceManager.save(
            videoURL: try exampleFileURLWithCreatingFile(),
            withARKitResult: [2.2:3.3],
            isLeftEye: true,
            uncoveredPhotoTime: 0,
            coveredPhotoTime: 1.2,
            creationDate: currentDate,
            isBookMarked: false
        )
        let result = try persistenceManager.fetchVideo(.all)
        XCTAssertEqual(result.count, 1)
        XCTAssertEqual(result.first?.angles, [2.2:3.3])
        XCTAssertEqual(result.first?.measurementResult.isLeftEye, true)
        XCTAssertEqual(result.first?.measurementResult.timeOne, 0)
        XCTAssertEqual(result.first?.measurementResult.timeTwo, 1.2)
        XCTAssertEqual(result.first?.measurementResult.creationDate, currentDate)
        XCTAssertEqual(result.first?.measurementResult.isBookMarked, false)
    }
    
    func test_delete_video_throws_error_using_wrong_local_identifier() throws {
        XCTAssertThrowsError(
            try persistenceManager.deleteVideo(withLocalIdentifier: "wrongLocalIdentifier")
        )
    }
    
    func test_delete_video() throws {
        try persistenceManager.save(
            videoURL: try exampleFileURLWithCreatingFile(),
            withARKitResult: [2.2:3.3],
            isLeftEye: true,
            uncoveredPhotoTime: 0,
            coveredPhotoTime: 1.2,
            creationDate: "2022-11-22 00:12:34".toDate()!,
            isBookMarked: false
        )
        let resultsBeforeDeletion = try persistenceManager.fetchVideo(.all)
        XCTAssertEqual(resultsBeforeDeletion.count, 1)
        
        guard let localIdentifier = resultsBeforeDeletion.first?.measurementResult.localIdentifier else { return }
        try persistenceManager.deleteVideo(withLocalIdentifier: localIdentifier)
        
        let resultsAfterDeletion = try persistenceManager.fetchVideo(.all)
        XCTAssertEqual(resultsAfterDeletion.count, 0)
    }
    
    func test_update_video_bookmark() throws {
        try persistenceManager.save(
            videoURL: try exampleFileURLWithCreatingFile(),
            withARKitResult: [2.2:3.3],
            isLeftEye: true,
            uncoveredPhotoTime: 0,
            coveredPhotoTime: 1.2,
            creationDate: "2022-11-22 00:12:34".toDate()!,
            isBookMarked: false
        )
        let resultsBeforeUpdate = try persistenceManager.fetchVideo(.all)
        guard let resultBeforeUpdate = resultsBeforeUpdate.first?.measurementResult else {
            XCTAssert(false)
            return
        }
        XCTAssertFalse(resultBeforeUpdate.isBookMarked)
        
        try persistenceManager.updateVideo(withLocalIdentifier: resultBeforeUpdate.localIdentifier, bookmarked: true)
        
        let resultsAfterUpdate = try persistenceManager.fetchVideo(.all)
        guard let resultAfterUpdate = resultsAfterUpdate.first?.measurementResult else {
            XCTAssert(false)
            return
        }
        XCTAssertTrue(resultAfterUpdate.isBookMarked)
    }
    
    func test_update_video_uncoverd_photo_time_and_covered_photo_time() throws {
        try persistenceManager.save(
            videoURL: try exampleFileURLWithCreatingFile(),
            withARKitResult: [2.2:3.3],
            isLeftEye: true,
            uncoveredPhotoTime: 0,
            coveredPhotoTime: 1.2,
            creationDate: "2022-11-22 00:12:34".toDate()!,
            isBookMarked: false
        )
        let resultsBeforeUpdate = try persistenceManager.fetchVideo(.all)
        guard let resultBeforeUpdate = resultsBeforeUpdate.first?.measurementResult else {
            XCTAssert(false)
            return
        }
        XCTAssertEqual(resultBeforeUpdate.timeOne, 0)
        XCTAssertEqual(resultBeforeUpdate.timeTwo, 1.2)
        
        try persistenceManager.updateVideo(
            withLocalIdentifier: resultBeforeUpdate.localIdentifier,
            setUncoveredPhotoTimeTo: 11,
            setCoveredPhotoTimeTo: 2.2
        )
        
        let resultsAfterUpdate = try persistenceManager.fetchVideo(.all)
        guard let resultAfterUpdate = resultsAfterUpdate.first?.measurementResult else {
            XCTAssert(false)
            return
        }
        XCTAssertEqual(resultAfterUpdate.timeOne, 11)
        XCTAssertEqual(resultAfterUpdate.timeTwo, 2.2)
    }
    
    func test_clear_garbage_files() throws {
        try persistenceManager.clearGarbageFilesInDocumentFolder()
        _ = try exampleFileURLWithCreatingFile()
        var expectedFiles: Set<String> = ["example.mp4", SQLiteService.path, JSONService.path, VideoURLService.path]
        
        for fileName in try allFileNamesInDocumentDirectory() {
            XCTAssertTrue(expectedFiles.contains(fileName))
            expectedFiles.remove(fileName)
        }
        
        try persistenceManager.clearGarbageFilesInDocumentFolder()
        
        expectedFiles = [SQLiteService.path, JSONService.path, VideoURLService.path]
        
        for fileName in try allFileNamesInDocumentDirectory() {
            XCTAssertTrue(expectedFiles.contains(fileName))
            expectedFiles.remove(fileName)
        }
    }
}
