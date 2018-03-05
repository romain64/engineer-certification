pragma solidity ^0.4.11;

contract EngineerCertif {
    address owner;
    address[] authorities;
    address[] engineers;
    
    struct Authority {
        string name;
        string country;
        uint8 approvalLevel;
    }
    
    struct Engineer {
        string name;
        string nationality;
        string certification;
        uint certifDuration;
    }
    
    mapping(address => Authority) authorityInfo;
    mapping(address => Engineer) engineerInfo;
    
    function EngineerCertif() public {
        owner = msg.sender;
    }
    
    function createAuthority(address _addressToGrant, string _name, string _country) public returns(bool) {
        require(msg.sender == owner);
        
        authorityInfo[_addressToGrant].name = _name;
        authorityInfo[_addressToGrant].country = _country;
        authorityInfo[_addressToGrant].approvalLevel = 1;
        
        authorities.push(_addressToGrant);
        
        return true;
    }
    
    function approveEngineer(address _addressToApprove, string _name, string _nationality, string _certfication, uint _certifDuration) public returns(bool) {
        require(checkAuthorityExists(msg.sender) == true);
        
        engineerInfo[_addressToApprove].name = _name;
        engineerInfo[_addressToApprove].nationality = _nationality;
        engineerInfo[_addressToApprove].certification = _certfication;
        engineerInfo[_addressToApprove].certifDuration = _certifDuration;
        
        engineers.push(_addressToApprove);
        
        return true;
    }
    
    function listCertifiedEngineers() public view returns(string name, string nationality, string certification){
        
    }
    
    function getInfoEngineer(string _name) public view returns(string name, string nationality, string certification){
        for(uint i = 0; i < engineers.length; i++){
	        if(keccak256(engineerInfo[engineers[i]].name) == keccak256(_name)){
	            name = _name;
	            nationality = engineerInfo[engineers[i]].nationality;
	            certification = engineerInfo[engineers[i]].certification;
	        }
	    }
    }
    
    function checkAuthorityExists(address auth) internal constant returns(bool){
	    for(uint i = 0; i < authorities.length; i++){
	        if(authorities[i] == auth) return true;
	    }
	    return false;
	}
    
    function checkEngineerExists(address eng) internal constant returns(bool){
	    for(uint i = 0; i < engineers.length; i++){
	        if(engineers[i] == eng) return true;
	    }
	    return false;
	}
    
    function () payable public {}
}