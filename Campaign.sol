pragma solidity ^0.4.17;

//contract for compaignFactory
contract compaignFactory{
    address[] public deployedCampaigns; //to hold the list of all deployed campaigns

//declares a function that allows a user to create a new instance of campaign    
    function createCampaign(uint minimum) public {   
        // to deploy a new instance of Campaign and return address of newly created Campaign
        address newCampaign = new Campaign(minimum, msg.sender);
        deployedCampaigns.push(newCampaign); // it will add the new campaign to the deployedCampaigns
    }
    
    // function that returns whole array of deployed Campaigns
    // public means anyone can call this function, view means no data inside the contract is modified, returns address array
    function getDeployedCampaigns() public view returns(address[]){ 
    return deployedCampaigns;     
    }
}

//create a contract named Campaign
contract Campaign{
    
    //creating a structure for Request having different parameters 
    struct Request{
        string description; // name of item to buy
        uint value;         // price of item
        address recipient; //address of recipient to receive amount of item 
        bool complete;    // the default value is false, when approvers give approval then value will be true
        uint approvalCount;  // Number of approvers who approved the request  
        mapping (address => bool) approvals; // this will map the approvers address with its decision
    }

    Request[] public requests; // dynamic array to store all the requests
    address public manager;    // manager will manage the requests
    uint public minimumContribution; // there has to be minimum amount to be declared for contribution
    mapping(address =>bool) public approvers; 
    uint public approversCount;
    
    modifier restricted(){
        require(msg.sender == manager); // it 
        _; //
    }
    
    // create a function Campaign having a manager and a minimum contribution
    function Campaign(uint minimum, address creator) public{
        manager = creator; // here the creator is the manager of the Campaign
        minimumContribution = minimum;
    }
    
    // create a function contribute which will have condition to contribute minimum or above amount
    function contribute() public payable{
        require(msg.value > minimumContribution); // check the condition that contributor has entered minimum amount or not
        
        approvers[msg.sender] = true; 
        approversCount++;
    }
    
    // create a function Request which will have different parameters to take values from requester
    function createRequest(string description, uint value, address recipient) public restricted{
        Request memory newRequest = Request({
            description: description,
            value: value,
            recipient: recipient,
            complete: false,
            approvalCount: 0
        });
        
        requests.push(newRequest); // it will push the request as a new request
    }
    
    // create a function named approveRequest 
    function approveRequest(uint index) public{
        Request storage request = requests[index]; // variable to store the request index mapping
        
        require(approvers[msg.sender]); // checking condition that approvers is a contributor
        require(!request.approvals[msg.sender]); // checking the condition that approvers has not approved the request
        
        request.approvals[msg.sender] = true; //  
        request.approvalCount++; // it will increment approvalCount whenever approver approves the request
    }
    
    // create a function finalizeRequest that manager will call to finalize request
    function finalizeRequest(uint index) public restricted {
        Request storage request = requests[index]; // variable to store the request index mapping

        require(request.approvalCount > (approversCount/2)); // this require statement will check the approversCount is more than 50% of total approvers 
        require(!request.complete); //it will check the request is complete or not 
        
        request.recipient.transfer(request.value);  // this statement will transfer the amount to the recipient
        request.complete = true; // it will set flag to true after paying amount to the requestor
    }
    
}
