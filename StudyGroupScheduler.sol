// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudyGroupScheduler {
    struct StudySession {
        uint256 id;
        address proposer;
        string subject;
        string dateTime;
        uint256 votes;
        bool confirmed;
    }

    address public owner;
    uint256 public sessionCounter;
    mapping(uint256 => StudySession) public studySessions;
    mapping(uint256 => mapping(address => bool)) public votes; // sessionId => (voter => voted)

    constructor() {
        owner = msg.sender;
        sessionCounter = 0;
    }

    event SessionProposed(uint256 id, address proposer, string subject, string dateTime);
    event SessionVoted(uint256 id, address voter);
    event SessionConfirmed(uint256 id);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }
    //REQUIRE
    function proposeSession(string memory _subject, string memory _dateTime) public {
        sessionCounter++;
        studySessions[sessionCounter] = StudySession({
            id: sessionCounter,
            proposer: msg.sender,
            subject: _subject,
            dateTime: _dateTime,
            votes: 0,
            confirmed: false
        });

        emit SessionProposed(sessionCounter, msg.sender, _subject, _dateTime);
    }
    //ASSERT
    function voteSession(uint256 _id) public {
        require(_id > 0 && _id <= sessionCounter, "Invalid session ID");
        require(!votes[_id][msg.sender], "You have already voted for this session");
        require(!studySessions[_id].confirmed, "Session already confirmed");

        votes[_id][msg.sender] = true;
        studySessions[_id].votes++;

        emit SessionVoted(_id, msg.sender);

        if (studySessions[_id].votes >= 3) { // Assuming 3 votes are needed to confirm a session
            studySessions[_id].confirmed = true;
            emit SessionConfirmed(_id);
        }
    }
    //REVERT
    function getSession(uint256 _id) public view returns (StudySession memory) {
        require(_id > 0 && _id <= sessionCounter, "Invalid session ID");
        return studySessions[_id];
    }

    function confirmSession(uint256 _id) public onlyOwner {
        require(_id > 0 && _id <= sessionCounter, "Invalid session ID");
        require(!studySessions[_id].confirmed, "Session already confirmed");
        require(studySessions[_id].votes >= 3, "Not enough votes to confirm");

        studySessions[_id].confirmed = true;
        emit SessionConfirmed(_id);
    }
}
