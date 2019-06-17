pragma solidity ^0.4.19;

contract pragma solidity ^0.4.19;

contract doWhileLoop{
    mapping (uint => uint) blockNumber;
    uint counter;
    
    event uintNumber(uint);
    bytes aa;
    
    function SetNumber() public {
        blockNumber[counter++] = block.number;
    }
    
    function getNumbers() public {
        uint i=0;
        do{
            uintNumber(blockNumber[i]);
            i = i + 1;
        }while (i< counter);
    }
}{
    mapping (uint => uint) blockNumber;
    uint counter;
    
    event uintNumber(uint);
    bytes aa;
    
    function SetNumber() public {
        blockNumber[counter++] = block.number;
    }
    
    function getNumbers() public {
        uint i=0;
        do{
            uintNumber(blockNumber[i]);
            i = i + 1;
        }while (i< counter);
    }
}
