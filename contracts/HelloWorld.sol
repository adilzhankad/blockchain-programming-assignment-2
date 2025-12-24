// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract HelloWorld {
    // 1) stored string variable (storage)
    string private s_message;

    // 2) event emitted on state change
    event MessageUpdated(address indexed updater, string oldMessage, string newMessage);

    constructor(string memory initialMessage) {
        s_message = initialMessage;
    }

    // 3) public getter (view)
    function getMessage() public view returns (string memory) {
        return s_message;
    }

    // 4) function that updates the string (state-changing)
    // external — чтобы показать visibility difference
    function setMessage(string calldata newMessage) external {
        string memory old = s_message;

        // call private function (requirement)
        s_message = _sanitize(newMessage);

        emit MessageUpdated(msg.sender, old, s_message);
    }

    // 5) at least one private function
    function _sanitize(string calldata input) private pure returns (string memory) {

        return input;
    }
}
