// SPDX-License-Identifier: MIT
pragma solidity 0.7.6;

import "./zombiefeeding.sol";

contract ZombieHelper is ZombieFeeding {
    // function helper modifier to check zombie level
    modifier aboveLevel(uint _level, uint _zombieId) {
        require(zombies[_zombieId].level >= _level);
        _;
    }

    // cnageName function provided zombie level is > 2
    function changeName(
        uint _zombieId,
        string calldata _newName
    ) external aboveLevel(2, _zombieId) {
        require(msg.sender == zombieToOwner[_zombieId]);
        zombies[_zombieId].name = _newName;
    }

    // changeDna function provided zombie level > 20
    function changeDna(
        uint _zombieId,
        uint _newDna
    ) external aboveLevel(20, _zombieId) {
        require(msg.sender == zombieToOwner[_zombieId]);
        zombies[_zombieId].dna = _newDna;
    }

    // external view function
    function getZombiesByOwner(
        address _owner
    ) external view returns (uint[] memory) {
        // defining array in memory
        uint[] memory result = new uint[](ownerZombieCount[_owner]);
        uint counter = 0;
        for(uint i = 0; i<zombies.length; i++){
            if(zombieToOwner[i]==_owner){
                result[counter]=i;
                counter++;
            }
        }
        return result;
    }
}
