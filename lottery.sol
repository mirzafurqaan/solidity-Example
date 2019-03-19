pragma solidity ^0.5.0;

contract lottery{

//to manage the whole lottery system create a manager
address public manager;
address payable[] public players; // It is a dynamic array to add the players in the lottery

constructor() public{
    manager = msg.sender;
} 

//this function is for players who wants to enter in the lottery
//and they have to enter minimum 0.1 enter amount to get the lottery ticket
//if the amount is 0.1 ether or above then player will get the lottery ticket
function enter() public payable{
    require(msg.value> 0.1 ether);
    
//when above condition is true then manager will add 
//the player account address to the array that sends the ether
    players.push(msg.sender);
    }
    
//this function is generating the pseudo-random integer number 
function random() private view returns(uint){
return uint(keccak256(abi.encodePacked(block.difficulty,now,players)));
}
//this function is for picking the winner randomly
function pickWinner() public restricted{
//modulo function is used to pick the player from the list
    uint index = random() % players.length;
//this will transfer the lottery amount to the winner account
    players[index].transfer(address(this).balance);
//It will make the dynamic array empty    
    players =new address payable[](0);
}

// this will check that if there is any manager is present or not 
//if it returns false then it will be reverted and canceled
 modifier restricted{
     require(msg.sender == manager);
     _; //this symbol is used to continue the rest of the function body
 }
 
//this will give the list of players participating in the lottery
function getPlayers() public view returns(address payable[] memory){
    return players;
}
}
