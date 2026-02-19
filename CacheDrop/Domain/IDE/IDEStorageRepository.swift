//
//  IDEStorageRepository.swift
//  CacheDrop
//
//  Created by Fatin on 16/02/26.
//

protocol IDEStorageRepository {
    func size(of location: any ClearableLocation) async throws -> UInt64
    func delete(location: any ClearableLocation) async throws

}

protocol XcodeArchiveStorageRepository: IDEStorageRepository {
    func listXcodeArchives() async throws -> [DirectoryItem]
}

protocol XcodeDeviceSupportRepository: IDEStorageRepository {
    func listXcodeDeviceSupports() async throws -> [DirectoryItem]
}
