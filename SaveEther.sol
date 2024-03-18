// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract SaveEther {
    mapping(address => uint256) savings;

    function deposit() external payable {
        require(msg.sender != address(0), "wrong EOA");
        assert(msg.value > 0);
        savings[msg.sender] = savings[msg.sender] + msg.value;
    }

    function withdraw() external {
        require(msg.sender != address(0), "wrong EOA");
        uint256 _userSavings = savings[msg.sender];
        if (_userSavings > 0) {
            revert("you don't have any savings");
        }
        savings[msg.sender] -= _userSavings;
        payable(msg.sender).transfer(_userSavings);
    }

    function checkSavings(address _user) external view returns (uint256) {
        return savings[_user];
    }

    function sendOutSavings(address _receiver, uint256 _amount) external {
        require(msg.sender != address(0), "no zero address call");
        assert(_amount > 0);
        require(savings[msg.sender] >= _amount, "insufficient savings");
        savings[msg.sender] -= _amount;
        payable(_receiver).transfer(_amount);
    }
}
