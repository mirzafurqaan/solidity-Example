pragma solidity ^0.4.19;

contract whileLoop {
    mapping (uint => uint) blockNumber;
    uint counter;
    event uintNumber(uint);
    bytes aa;
    
    function SetNumber() public {
        blockNumber[counter++] = block.number;
    }
    
    function getNumbers() public{
        uint i = 0;
        while (i < counter){
           emit uintNumber(blockNumber[i]);
            i = i+ 1;
        }
    }
}
