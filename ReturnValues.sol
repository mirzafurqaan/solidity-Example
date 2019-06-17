pragma solidity ^0.4.19;

contract ReturnValues{
    uint counter;
    
    function SetNumber() public {
        
        counter = block.number;
    }
    
    function getBlockNumber() returns (uint) {
        
        return counter;
    }
    
    function getBlockNumber1() returns(uint result){
        result = counter;
    }
}
