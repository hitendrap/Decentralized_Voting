// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
import "@openzeppelin/contracts/utils/Counters.sol";
contract first
{
    address contractOwner = msg.sender;
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    struct voterDetails{
        uint tokenId;
        address voter;
        string voterID;
        bool isVoted;
    }
    mapping(uint256 => voterDetails) private idToVoterDetails;

    uint public community1;
    uint public community2;
    uint public community3;
    // Register a new Voter
    function registerVoter(string memory voterId) public {
        _tokenIds.increment();
        uint tokenId = _tokenIds.current();
        address tempOwner;
        for (uint i = 0; i < tokenId; i++) {
          if (idToVoterDetails[i + 1].voter == msg.sender) {
            tempOwner = msg.sender;
          }
        }
        require(tempOwner != msg.sender,"Voter Already Exist");
        idToVoterDetails[tokenId].tokenId = tokenId;
        idToVoterDetails[tokenId].voter = msg.sender;
        idToVoterDetails[tokenId].voterID = voterId;
        idToVoterDetails[tokenId].isVoted = false;

    }
    // Return Voter Details
    function voterDetail(uint tokenId)public view returns (voterDetails memory) {
        voterDetails memory items = idToVoterDetails[tokenId];
        return items;
    }
    // fetch voter's details
    function fetchmyDetails() public view returns (voterDetails[] memory) {
        uint totalItemCount = _tokenIds.current();
        uint itemCount = 0;
        uint currentIndex = 0;

        for (uint i = 0; i < totalItemCount; i++) {
          if (idToVoterDetails[i + 1].voter == msg.sender) {
            itemCount += 1;
          }
        }
        voterDetails[] memory items = new voterDetails[](itemCount);
        for (uint i = 0; i < _tokenIds.current(); i++) {
          if (idToVoterDetails[i + 1].voter == msg.sender) {
            uint currentId = i + 1;
            voterDetails storage currentItem = idToVoterDetails[currentId];
            items[currentIndex] = currentItem;
            currentIndex += 1;
          }
        }
        return items;
    }

    // votind functions
    function vote_community1 (uint tokenId) public
    {
        require(idToVoterDetails[tokenId].voter == msg.sender,"invalid tokenId");
        require(idToVoterDetails[tokenId].isVoted == false,"voter already voted");
        community1 = community1 + 1;
        idToVoterDetails[tokenId].isVoted = true;
    }
    function vote_community2(uint tokenId) public
    {
        require(idToVoterDetails[tokenId].voter == msg.sender,"invalid tokenId");
        require(idToVoterDetails[tokenId].isVoted == false,"voter already voted");
        community2 = community2 + 1;
        idToVoterDetails[tokenId].isVoted = true;
    }
    function vote_community3(uint tokenId) public
    {
        require(idToVoterDetails[tokenId].voter == msg.sender,"invalid tokenId");
        require(idToVoterDetails[tokenId].isVoted == false,"voter already voted");
        community3 = community3 + 1;
        idToVoterDetails[tokenId].isVoted = true;
    }
    // reset voting
    function resetVoting() public {
        require(contractOwner == msg.sender,"you are not Owner");
        for(uint i = 0;i< _tokenIds.current();i++){
            delete idToVoterDetails[i];
        }
    }
}
