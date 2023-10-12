// SPDX-License-Identifier: UNLICENSE
pragma solidity 0.8.20;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/Math.sol";

contract waifu is Ownable {
    using Math for uint256;

     mapping(uint => DetailWaifu) public listOfWaifu; //npw => book detail

     struct DetailWaifu {
        uint npw; //index (primary key/kunci utama)
        uint256 birthday; //format unix timestamp
        string WaifuName;
        string WaifuSkill;
        address WaifuAddress;
    }

    event WaifuCreated(uint indexed npw, address indexed sender, uint256 timestamp);    
    event WaifuUpdated(uint indexed npw, address indexed sender, uint256 timestamp);
    event WaifuDeleted(uint indexed npw, address indexed sender, uint256 timestamp);

    constructor() Ownable(msg.sender){
    }

    //ADD WAIFU
    function addWaifu(
        uint _npw,
        uint256 _birthday,
        string memory _WaifuName,
        string memory _WaifuSkill,
        address _WaifuAddress

    ) public onlyOwner(){
        listOfWaifu[_npw] = DetailWaifu(_npw, _birthday, _WaifuName, _WaifuSkill, _WaifuAddress);

        emit WaifuCreated(_npw, msg.sender, block.timestamp);

    }

    //DELETE WAIFU
    function deleteWaifu(uint _npw) public onlyOwner(){
        listOfWaifu[_npw] = DetailWaifu(0, 0, string(""), string(""), address(0));

        emit WaifuDeleted(_npw, msg.sender, block.timestamp);
    }

    //GET WAIFU BY NPW
    function getWaifu(uint _npw) public view returns 
    (   
        uint __npw,
        uint256 __birthday,
        string memory __WaifuName,
        string  memory __WaifuSkill,
        address __WaifuAddress
        
    ){

        __npw = listOfWaifu[_npw].npw;
        __birthday = listOfWaifu[_npw].birthday;
        __WaifuName = listOfWaifu[_npw].WaifuName;
        __WaifuSkill = listOfWaifu[_npw].WaifuSkill;
        __WaifuAddress = listOfWaifu[_npw].WaifuAddress;

        return ( __npw, __birthday, __WaifuName, __WaifuSkill, __WaifuAddress);
    }

    //UPDATE
    function updateWaifu(uint _npw, string memory _WaifuName) public onlyOwner(){
        listOfWaifu[_npw].WaifuName = _WaifuName;

        emit WaifuUpdated(_npw, msg.sender, block.timestamp);
    }
}