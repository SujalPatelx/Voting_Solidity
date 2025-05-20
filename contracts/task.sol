// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract Task{

    struct Candidate {
        string name;
        uint256 vote;
    }
    
    address private admin;
    string public winner;
    Candidate[] public candidates;
    mapping(address => bool) public hasVoted;

    constructor(){
        admin = msg.sender;
    }

    modifier OnlyAdmin{
        require(admin == msg.sender, "Not admin");
        _;
    }

    modifier OnceVote{
        require(!hasVoted[msg.sender],"You have already voted");
        _;
    }

    function addCandidate (string memory _candidate) public OnlyAdmin {
        candidates.push(Candidate({name:_candidate,vote : 0}));
    }

    function voteCandidate(uint256 _candidateIndex) public OnceVote {
        candidates[_candidateIndex].vote++;
        hasVoted[msg.sender] = true;
    }

    function declareWinner () public OnlyAdmin returns (string memory) {

        uint maxVote = 0;
        uint winnerIndex = 0;

        for (uint i = 0; i < candidates.length; i++) 
        {   
            if(candidates[i].vote > maxVote){
                maxVote = candidates[i].vote;
                winnerIndex = i;
            }
        }
        winner = candidates[winnerIndex].name;
        return  (winner);
    }

    function allCandidates () public view returns (Candidate[] memory) {
        return(candidates);
    }

}