pragma solidity >=0.4.24 <0.6.0;

contract MessageContract{
    
    string private message = "Hello World";
    
    function getMessage() public constant returns(string) {
        return message;
    }
    function setMessage(string newMessage) public{
        
        message =newMessage;
    }
}
