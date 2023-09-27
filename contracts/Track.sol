// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract Track {
    struct FarmerInfo {
        string foodId;
        string foodName;
        string cultivationDate;
        string location;
        string fertilizerType;
    }

    mapping(string => FarmerInfo) public farmerInfo;

    event FarmerInfoAdded(
        string indexed foodId,
        string foodName,
        string cultivationDate,
        string location,
        string fertilizerType
    );

    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addFarmerInfo(
        string memory _foodId,
        string memory _foodName,
        string memory _cultivationDate,
        string memory _location,
        string memory _fertilizerType
    ) public onlyOwner {
        // Check if the foodId already exists
        require(bytes(farmerInfo[_foodId].foodId).length == 0, "Food ID already exists");

        farmerInfo[_foodId] = FarmerInfo(
            _foodId,
            _foodName,
            _cultivationDate,
            _location,
            _fertilizerType
        );

        emit FarmerInfoAdded(
            _foodId,
            _foodName,
            _cultivationDate,
            _location,
            _fertilizerType
        );
    }

    function getFarmerInfo(string memory _foodId)
    public
    view
    returns (
        string memory foodId,
        string memory foodName,
        string memory cultivationDate,
        string memory location,
        string memory fertilizerType
    )
    {
        FarmerInfo memory info = farmerInfo[_foodId];
        return (
        info.foodId,
        info.foodName,
        info.cultivationDate,
        info.location,
        info.fertilizerType
        );
    }
}