pragma solidity ^0.5.0;

contract storewithapproval {
    uint256 value;
    uint256 n; // nonce
    struct Proposal {
        address proposer;
        uint256 newValue;
        bool executed;
    }
    
    address constant ORG1 = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;
    address constant ORG2 = 0x14723A09ACff6D2A60DcdF7aA4AFf308FDDC160C;
    address constant ORG3 = 0x4B0897b0513fdC7C541B6d9D7E929C4e5364D2dB;
    
    mapping(uint256 => Proposal) setValueItem;
    mapping(uint256 => mapping(address => bool)) approval;
    
    function getValue() public view returns (uint256){
        return value;
    }
    
    function setValue(uint256 _value) private {
        value = _value;
    }
    
    function proposalSetValue(uint256 _value) public {
        require(msg.sender == ORG1 || msg.sender == ORG2 || msg.sender == ORG3); // make sure only the three orgs can make proposal        
        Proposal memory p;
        n = n+1;
        p.proposer = msg.sender;
        p.newValue = _value;
        setValueItem[n] = p;
        approval[n][msg.sender] = true;
    }
    
    function getProposal(uint256 _index) public view returns(address proposer, uint256 newvalue, bool approvalOrg1, bool approvalOrg2, bool approvalOrg3, bool executed) {
        proposer = setValueItem[_index].proposer;
        newvalue = setValueItem[_index].newValue;
        approvalOrg1 = approval[_index][ORG1];
        approvalOrg2 = approval[_index][ORG2];
        approvalOrg3 = approval[_index][ORG3];
        executed = setValueItem[_index].executed;
    }
    
    function executeProposal(uint256 _index) public {
        require(setValueItem[_index].proposer != address(0)); // make sure the proposal is already made
        require(!setValueItem[_index].executed); // only non-executed proposal can be executed
        require(setValueItem[_index].proposer == msg.sender); // only the proposal originator can execute proposal
        require(approval[_index][ORG1]);
        require(approval[_index][ORG2]);
        require(approval[_index][ORG3]);
        setValue(setValueItem[_index].newValue);
        setValueItem[_index].executed = true;
    }
    
    function approve(uint256 _index) public {
        require(msg.sender == ORG1 || msg.sender == ORG2 || msg.sender == ORG3); // make sure only the three orgs can approve
        require(setValueItem[_index].proposer != address(0)); // make sure the proposal is already made
        approval[_index][msg.sender] = true;
    }
}
